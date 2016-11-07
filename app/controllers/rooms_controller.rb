class RoomsController < ApplicationController
  before_action :require_authentication,  :only => [:new, :edit, :create, :update, :destroy]

  def index
    @search_query = params[:q]

    rooms = Room.search(@search_query)
    @rooms = rooms.most_recent.map do |room|
    # Não exibiremos o formulário na listagem
    RoomPresenter.new(room, self, false)
    end
  end

  def show
    @room = RoomPresenter.new(Room.friendly.find(params[:id]), self)
  end

  def new
    @room = current_user.rooms.build
  end

  def edit
    @room = current_user.rooms.find(params[:id])
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
    @room = current_user.rooms.find(params[:id])

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
    params.require(:room).permit(:title, :location, :description)
  end

end
