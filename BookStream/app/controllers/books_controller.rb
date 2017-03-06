class BooksController < ApplicationController

  before_action :set_book, only: [:show, :edit, :update, :destroy, :add_tag, :read, :add_book, :email_book, :convert, :remove_tag]

  before_action :authenticate_user!
  before_action :set_path, only: [:read, :email_book]
  before_action :googleapi, only: [:show]
  before_action :imbdapi, only: [:show]

  require 'will_paginate/array'

  # GET /books
  # GET /books.json

  # GET /books/1
  # GET /books/1.json

  def convert
    convert_book(params.require(:book).permit(:format)[:format])
    redirect_to @download_url
  end

  def show
    if current_user.email != 'bookstreammailer@gmail.com'
      if not current_user.books.include? @book
        redirect_to '/home'
      end
    end
  end

  def email_book
    call_rake :email_book, {:USER => current_user.id, :BOOK => @book.id}
    respond_to do |format|
      format.html { redirect_to @book, notice: 'Sending email' }
    end
  end

  # GET /books/1/read
  def read
    if @book.document_file_name.split(".").last.downcase == "pdf"
      @path = (Rails.root.to_s + "/public" + @book.document.url).split('?').first
    else
      @path = Rails.root.to_s + "/public/tempdf/B#{@book.id}.pdf"
      if not File.exist? File.expand_path @path
        convert_book("pdf")
        require 'open-uri'
        open(@path, 'wb') do |file|
          file << open(@download_url).read
        end
      end
    end
    @reader = PDF::Reader.new(@path)
    #@data = @reader.pages
    @data = @reader.pages[1..-1]
    @page = params[:page].to_i
    #@all_data = @reader.pages[1..-1]
    #@all_data = @reader.pages
    #@data = Array.new
    #@data.each do |p|
    #  if p.text.length < 15
    #    @data.delete(p)
    #  end
    #end
    #@pages = @data.paginate(:page => params[:page], :per_page => 1)
  end


  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
    if current_user.email != 'bookstreammailer@gmail.com'
      if not current_user.books.include? @book
        redirect_to '/home'
      end
    end
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
    respond_to do |format|
      if @book.save
        if @book.access == "Public"
          @book = Book.new(book_params)
          @book.access = "Private"
        end
        current_user.books << @book
        @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.delete
    respond_to do |format|
      format.html { redirect_to home_path, notice: '' }
      format.json { head :no_content }
    end
  end

  def add_tag
    @tag_name = params.require(:book).permit(:tags)
    @tag = Tag.find_by(name: @tag_name[:tags])
    if not @book.tags.include? @tag
      @book.tags << @tag
    end
    respond_to do |format|
      format.html { redirect_to @book, notice: 'Tag was successfully added.' }
      format.json { render :show, status: :ok, location: @book }
    end
  end

  def remove_tag
    @tag_name = params.require(:book).permit(:tags)
    @tag = Tag.find_by(name: @tag_name[:tags])
    @book.tags.delete(@tag)
    respond_to do |format|
      format.html { redirect_to @book, notice: 'Tag was successfully removed.' }
      format.json { render :show, status: :ok, location: @book }
    end
  end

  def add_book
    new_book = Book.new
    new_book.name = @book.name
    new_book.author = @book.author
    new_book.document = @book.document
    new_book.image = @book.image
    new_book.description = @book.description
    new_book.access = "Private"
    if @book.tags.size != 0
      @book.tags.each do |t|
        new_book.tags << t
      end
    end
    current_user.books << new_book
    new_book.save
    redirect_to new_book, notice: 'Book was successfully added to your library.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    def googleapi
      name = @book.name.dup
      name.sub! ' ', '+'
      query = "https://www.googleapis.com/books/v1/volumes?q=#{name}&maxResults=1&key=#{ENV['G_API_KEY']}"
      @resp = HTTParty.get(query)
      response = JSON.parse(@resp.body)
      @GoogleItem = response["items"][0]["volumeInfo"]
      @Grating = @GoogleItem['averageRating'].to_i
    end

    def imbdapi
      name = @book.name.dup
      name.sub! ' ', '+'
      query = "http://www.omdbapi.com/?t=#{name}&y=&plot=short&r=json"
      resp = HTTParty.get(query)
      @ImbdItem = JSON.parse(resp.body)
      @link = "http://www.imdb.com/title/" + @ImbdItem["imdbID"].to_s
      @Irating = ((@ImbdItem["imdbRating"].to_f)/2).round
    end

    def set_path
      @path = (Rails.root.to_s + "/public" + @book.document.url).split('?').first
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:name, :author, :document, :image, :description, :access ,:tags, :format)
    end
end
