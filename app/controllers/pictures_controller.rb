class PicturesController < ApplicationController
  def create
    @user = current_user
    @user.picture.attach(params[:avatar])
  end
end
