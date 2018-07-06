class UsersController < ApplicationController
  before_action  :authenticate_user!
  before_action :load_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all.order('first_name')

  end

  def update
    if @user.update_attributes(authorized_attributes)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def load_user
    @user = User.find(params["id"])
  end



  def destroy
    @user= User.find(params["id"])
    @user.destroy
    redirect_to users_url
  end

  def authorized_attributes
    params.require(:user).permit(:first_name, :last_name, :date_of_birth, :email, :phone_number)
  end
end
