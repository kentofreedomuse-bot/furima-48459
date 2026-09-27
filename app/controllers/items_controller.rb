class ItemsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def index
    @items = Item.includes(:order).order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to root_path, status: :see_other
  end

  private

  def item_params
    params.require(:item).permit(
      :image,
      :name,
      :explanation,
      :category_id,
      :status_id,
      :shipping_fee_id,
      :region_id,
      :required_day_id,
      :price
    ).merge(user_id: current_user.id)
  end
end
