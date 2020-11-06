class Admin::AdminController < ApplicationController
  before_action :check_if_admin

  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def check_if_admin
    unless current_user.is_admin?
      return true
    end
  end
end
