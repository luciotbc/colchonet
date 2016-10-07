class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def show
        @user = User.find(params[:id])
    end

    def edit
        @user = User.find(params[:id])
    end

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to @user,
                        notice: 'Cadastro criado com sucesso!'
        else
            render :new
        end
    end

    def update
        @user = User.find(params[:id])
        if @user.update_attributes(user_params)
            redirect_to @user, notice: 'Cadastro atualizado com sucesso!'
        else
            render :update
        end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
        params.require(:user).permit(:full_name, :location, :email, :password, :password_confirmation, :bio)
    end
end
