class CookingLogsController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.cooking_logs.find_or_create_by!(
      post_id: params[:post_id],
      cooked_on: Date.current
    )
    redirect_back fallback_location: root_path, notice: "カレンダーに記録したよ！"
  end

  def destroy
    log = current_user.cooking_logs.find(params[:id])
    log.destroy
    redirect_back fallback_location: root_path, notice: "カレンダーの記録を削除したよ！"
  end
end
