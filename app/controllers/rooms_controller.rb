class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def new
    @room = Room.new
  end


  def index
    @book = Book.new
    @rooms = Room.all
  end

  def show
    @book = Book.new
    @room = Room.find(params[:id])
  end

  def join
    @room = Room.find(params[:room_id])
    @room.users << current_user
    redirect_to rooms_path
  end

  def create
    @room = Room.new(room_params)
    @room.owner_id = current_user.id
    @room.user << current_user
    if @room.save
      redirect_to rooms_path, notice: 'グループを作成しました。'
    else
      render :new, notice: '入力してください！！'
    end
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      redirect_to rooms_path, notice: 'グループを更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.users.delete(current_user)
    redirect_to rooms_path
  end

  def new_mail
    @room = Room.find(params[:room_id])
  end

  def send_mail
    @room = Room.find(params[:room_id])
    room_users = @room.users
    @mail_title = params[:mail_title]
    @mail_content = params[:mail_content]
    ContactMailer.send_mail(@mail_title, @mail_content, room_users).deliver
  end

  private

  def room_params
    params.require(:room).permit(:name, :introduction, :image)
  end

  def ensure_correct_user
    @room = Room.find(params[:id])
    unless @room.owner_id == current_user.id
      redirect_to rooms_path
    end
  end

end
