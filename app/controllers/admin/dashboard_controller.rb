class Admin::DashboardController < Admin::BaseController

  def show
    @statuses = Order.count_by_status
    if params[:status].nil?
      @orders = Order.all
    elsif params[:status] == "Ordered"
      status = Status.find_by(name: "Ordered")
      @orders = status.orders
    elsif params[:status] == "Paid"
      status = Status.find_by(name: "Paid")
      @orders = status.orders
    elsif params[:status] == "Cancelled"
      status = Status.find_by(name: "Cancelled")
      @orders = status.orders
    elsif params[:status] == "Completed"
      status = Status.find_by(name: "Completed")
      @orders = status.orders
    end
  end

end
