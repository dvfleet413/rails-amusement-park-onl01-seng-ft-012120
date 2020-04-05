class UsersController < ApplicationController

    def new
    end

    def create
        @user = User.create(users_params)
        session[:user_id] = @user.id
        params[:user][:admin] == 'true' ? @user.admin = true : @user.admin = false
        @user.save
        redirect_to user_path(@user)
    end

    def signin
    end

    def login
        @user = User.find_by(name: params[:user][:name])
        if @user.authenticate(params[:user][:password])
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            redirect_to signin_path
        end
    end

    def show
        redirect_if_not_authorized
        set_user
    end

    def logout
        session.delete :user_id
        redirect_to root_path
    end


    private
        def set_user
            @user = User.find(params[:id])
        end

        def users_params
            params.require(:user).permit(:id,
                                         :name, 
                                         :height, 
                                         :happiness,
                                         :nausea,
                                         :tickets,
                                         :password,
                                         :admin)
        end

end