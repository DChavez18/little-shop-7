class DashboardsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @customers = @merchant.top_5_customers
    @items = @merchant.ready_to_ship
  end
end