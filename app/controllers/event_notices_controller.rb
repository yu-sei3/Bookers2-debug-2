class EventNoticesController < ApplicationController

  def new
    @room = Room.find(params[:room_id])
  end

  def create
    @room = Room.find(params[:room_id])
    @title = params[:title]
    @body = params[:body]

    event = {
      :room => @room,
      :title => @title,
      :body => @body
    }
    EventMailer.send_notifications_to_group(event)
    render :sent
  end

  def sent
    redirect_to room_path(params[:room_id])
  end
end
