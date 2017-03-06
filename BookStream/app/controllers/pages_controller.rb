class PagesController < ApplicationController
    def main
        if user_signed_in?
            redirect_to '/home', notice: ""
        end
    end

    def home
        if not user_signed_in?
            redirect_to '/error', notice: "Home Page Access Denied."
        end
        if (defined? (params[:search])) and params[:search]!= nil
            @search = params[:search]
        end
    end

    def publiclib
        if not user_signed_in?
            redirect_to '/error', notice: "Public Library Access Denied"
        end
        if (defined? (params[:search])) and params[:search]!= nil
            @search = params[:search]
        end
    end

    def adm_users
        if not user_signed_in?
            redirect_to '/error', notice: ""
        end
        if current_user.email != 'bookstreammailer@gmail.com'
            redirect_to '/private', notice: "Private Access Only"
        end
        if (defined? (params[:search])) and params[:search]!= nil
            @search = params[:search]
        end
    end

    def delete_user
        if not user_signed_in?
            redirect_to '/error', notice: ""
        else
            @id = params[:id].to_i
            @user = User.find(@id)
            if @user.books.size != 0
              @user.books.each do |b|
                b.delete
              end
            end
            if @user.tags.size != 0
              @user.tags.each do |t|
                t.delete
              end
            end
            if current_user.email != 'bookstreammailer@gmail.com'
                @user.delete
                redirect_to '/users/sign_up'
            else
                @user.delete
                redirect_to '/adm_users'
            end
        end
    end
end
