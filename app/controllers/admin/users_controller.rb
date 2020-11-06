class Admin::UsersController < ApplicationController
  before_action :check_if_admin

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
  end

  def create
  end

  def edit
    @user_edit = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    post_params = params.require(:users).permit(:first_name, :last_name, :description, :email, :is_admin)
    @user.update(post_params)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end

  private

  def check_if_admin
    unless current_user.admin?
      redirect_to root_path
    end
  end
end
