class OrdersController < ApplicationController
  def index
    @orders = current_user.orders.all
  end

  def show
    if current_admin?
      @order = Order.find(params[:id])
      @items = @order.items.all
      @status = @order.status
      @ordered_items = @items.group(:id).count
      @user = User.find_by(id: @order.user_id)
    elsif current_user && Order.find(params[:id]).user_id == current_user.id
      @order = current_user.orders.find(params[:id])
      @items = @order.items.all
      @status = @order.status
      @ordered_items = @items.group(:id).count
      @user = User.find_by(id: @order.user_id)
    else
      render file: '/public/404'
    end
  end

  def create
    @status = Status.where(name: "Ordered").first_or_create
    @order = Order.new(user: current_user, status: @status)
    @order_completion = OrderCompletion.new(@order, session[:cart])
    if @order_completion.create
      flash[:success] = "Thank you for placing your order"
      session.delete(:cart)
      redirect_to order_path(@order)
    else
      flash[:alert] = "Order did not submit"
      redirect_to cart_path
    end
  end

  private

  def order_params
    params.require(session[:cart])
  end
end
