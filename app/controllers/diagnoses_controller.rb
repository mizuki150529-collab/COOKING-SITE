class DiagnosesController < ApplicationController
    def intro
    end
  
    def new
    end

    def result
      cook_time   = params[:cook_time].to_i
      mood        = params[:mood].to_s
      dish_type   = params[:dish_type].to_i
      cuisine_raw = params[:cuisine_type].to_s

      if cook_time.zero? || mood.blank? || params[:dish_type].blank? || cuisine_raw.blank?
        redirect_to new_diagnosis_path, alert: "診断の選択肢をすべて選んでね！"
        return
      end

      difficulty_map = { "quick" => 0, "normal" => 1, "careful" => 2 }
      difficulty = difficulty_map[mood]

      scope = Post.all

      scope =
        case cook_time
        when 30 then scope.where("cook_time <= ?", 30)
        when 60 then scope.where("cook_time > ? AND cook_time <= ?", 30, 60)
        else         scope.where("cook_time > ?", 60)
        end

      scope = scope.where(difficulty: difficulty)
      scope = scope.where(dish_type: dish_type)

      # ★ここが重要：any以外は整数化して絞る
      if cuisine_raw != "any"
        scope = scope.where(cuisine_type: cuisine_raw.to_i)
      end

      @post = scope.order(Arel.sql("RANDOM()")).first

      # ★@post が無いなら、診断に戻す or 別メッセージ
      if @post.nil?
        redirect_to new_diagnosis_path, alert: "条件に合うレシピが見つからなかったよ。条件を変えてみて！"
        return
      end
    end
end
