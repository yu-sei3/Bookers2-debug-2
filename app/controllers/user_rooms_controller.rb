class UserRoomsController < ApplicationController
  before_action :authenticate_user!

  def create
    room_user = current_user.user_rooms.new(room_id: params[:room_id])
    room_user.save
    redirect_to request.referer
  end

  def destroy
    room_user = current_user.user_rooms.find_by(room_id: params[:room_id])
    room_user.destroy
    redirect_to request.referer
  end
end
