class ItemsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update]
  before_action :set_item, only: %i[show edit update]
  before_action :move_to_index, only: %i[edit update]

  def index
    @items = Item.order(created_at: :desc)
  end

  def show
  end

  def new
    @item = Item.new
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    return if @item.user == current_user

    redirect_to root_path
  end

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
