class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_good_user?, only: [:show]

  def show
    @event = Event.where(organizer: current_user)
    @user = current_user
  end

  private
end
