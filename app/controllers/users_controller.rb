class UsersController < ApplicationController
  def show
    @user = current_user
    @month = params[:month] ? Date.parse("#{params[:month]}-01") : Date.current.beginning_of_month

    @range =
     @month.beginning_of_month.beginning_of_week(:sunday)..
     @month.end_of_month.end_of_week(:sunday)

    logs = current_user.cooking_logs.includes(:post).where(cooked_on: @range)
    @logs_by_date = logs.group_by(&:cooked_on)
  end
end
