class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!, only: [:search]

  def configure_permitted_parameters
  devise_parameter_sanitizer.for(:sign_up) { |params|
    params.permit(
      :email, :password, :password_confirmation, :name,
      :last_name
    )
  }
  devise_parameter_sanitizer.for(:account_update) { |params|
    params.permit(
      :email, :password, :password_confirmation, :name,
      :last_name
    )
  }
  end

  def read_book(path)
    @reader = PDF::Reader.new(path)
    @data = @reader.pages
    @pages = @data.paginate(:page => params[:page], :per_page => 1)
    @pages = path
  end


  def convert_book(salida)
    @book_actual_format = @book.document_file_name.split(".").last
    @path_libro = (Rails.root.to_s + "/public" + @book.document.url).split('?').first
        #@client = CloudConvert::Client.new(api_key: "Cqi8ofoKzx6CXwbsbcRfJjK-nlAUGiGPH70Ezf-ghB5QJbsXB6Wx14pY_6XLXe5uxZD9jb5eoBuPQQ_tE8qJZg")
        @client = CloudConvert::Client.new(api_key: ENV['CLOUDCONVERT_KEY'])
        @process = @client.build_process(input_format: @book_actual_format, output_format: salida)
        @process_response = @process.create
        @conversion_response = @process.convert(
                    input: "upload",
                    outputformat: salida,
                    file: Pathname.new(@path_libro).open,
                    download: "false"
                  )
        @download_url = @process.download_url
  end

  def call_rake(task, options = {})
    options[:rails_env] ||= Rails.env
    args = options.map { |n, v| "#{n.to_s.upcase}='#{v}'" }
    system "rake #{task} #{args.join(' ')} &"
  end

end
