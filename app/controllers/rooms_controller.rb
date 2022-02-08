class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    @room.owner_id = current_user.id
    if @room.save
      redirect_to rooms_path, notice: 'グループを作成しました。'
    else
      render :new, notice: '入力してください！！'
    end
  end

  def index
    @book = Book.new
    @rooms = Room.all
  end

  def show
    @book = Book.new
    @room = Room.find(params[:id])
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
    delete_room = Room.find(params[:id])
    if delete_room.destroy
      redirect_to rooms_path, notice: 'グループを削除しました。'
    end
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
