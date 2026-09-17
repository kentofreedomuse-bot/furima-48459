class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item_for_order, only: %i[index new create]

  def index
    @order_form = OrderForm.new
  end

  def new
    @order_form = OrderForm.new
    render :index
  end

  def create
    @order_form = OrderForm.new(order_form_params)

    if @order_form.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item_for_order
    @item = Item.find(params[:item_id]) if params[:item_id].present?
  end

  def order_form_params
    params.require(:order_form).permit(:postcode, :region_id, :city, :block, :building, :phone_number).merge(
      user_id: current_user.id,
      item_id: @item.id
    )
  end
end
