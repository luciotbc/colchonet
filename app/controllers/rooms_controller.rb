class RoomsController < ApplicationController
  before_action :require_authentication,  :only => [:new, :edit, :create, :update, :destroy]

  PER_PAGE = 10

  def index
    @search_query = params[:q]

    rooms = Room.search(@search_query).most_recent.page(params[:page]).per(PER_PAGE)

    @rooms = RoomCollectionPresenter.new(rooms, self)
  end

  def show
    room = Room.friendly.find(params[:id])
    @room = RoomPresenter.new(room, self)
  end

  def new
    @room = current_user.rooms.build
  end

  def edit
    @room = current_user.rooms.friendly.find(params[:id])
  end

  def create
    @room = current_user.rooms.build(room_params)

    if @room.save
      redirect_to @room, :notice => t('flash.notice.room_created')
    else
      render action: "new"
    end
  end

  def update
    @room = current_user.rooms.friendly.find(params[:id])

    if @room.update_attributes(room_params)
      redirect_to @room, :notice => t('flash.notice.room_updated')
    else
      render :action => "edit"
    end
  end

  def destroy
    @room = current_user.rooms.find(params[:id])
    @room.destroy
    redirect_to rooms_url
  end

  private
  def set_room
    room_model = Room.friendly.find(params[:id])
    @room = RoomPresenter.new(room_model, self)
  end

  def set_users_room
    @room = current_user.rooms.friendly.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:title, :location, :description, :picture)
  end

end
