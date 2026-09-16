class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @item = Item.find(params[:item_id]) if params[:item_id]
  end

  def new
    @item = Item.find(params[:item_id])
    render :index
  end

  def create
    redirect_to root_path
  end
end
