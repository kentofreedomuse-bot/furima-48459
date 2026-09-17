class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item_for_order, only: %i[index new create]
  before_action :set_order_form, only: %i[index new create]
  before_action :move_to_index, only: %i[index new create]

  def index
  end

  def new
    render :index
  end

  def create
    @order_form = OrderForm.new(order_form_params)

    if @order_form.valid?
      Payjp.api_key = ENV['PAYJP_SECRET_KEY']
      Payjp::Charge.create(
        amount: @item.price,
        card: params[:token],
        currency: 'jpy'
      )
      @order_form.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item_for_order
    @item = Item.find(params[:item_id]) if params[:item_id].present?
  end

  def set_order_form
    @order_form = OrderForm.new
  end

  def move_to_index
    return if @item.user != current_user && @item.order.blank?

    redirect_to root_path
  end

  def order_form_params
    params.require(:order_form).permit(:postcode, :region_id, :city, :block, :building, :phone_number).merge(
      user_id: current_user.id,
      item_id: @item.id,
      token: params[:token]
    )
  end
end
