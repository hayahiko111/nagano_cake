class Admin::ItemsController < ApplicationController
  def new
    @item=Item.new
  end

  def create
    @item=Item.new(item_params)
    if @item.save
      flash[:notice] = "You have created item successfully."
      redirect_to admin_items_path
    else
      render:new
    end
  end

  def index
    @items=Item.all
    @genres=Genre.all
  end

  def show
    @item=Item.find(params[:id])
  end

  def edit
    @item=Item.find(params[:id])
    @genres=Genre.all
  end

  def update
    @item=Item.find(params[:id],)
    if @item.update(item_params)
      flash[:notice] = "You have created item successfully."
      redirect_to admin_item_path(@item.id)
    else
      render:edit
    end

  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :introduction, :genre_id, :price, :is_active)
  end
end