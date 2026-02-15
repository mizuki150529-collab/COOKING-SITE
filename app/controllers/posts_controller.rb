class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    if params[:search].present?
      @posts = Post.where(
        "title LIKE ? OR ingredients LIKE ?",
        "%#{params[:search]}%",
        "%#{params[:search]}%"
      )
    else
      @posts = Post.all
    end
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_user.id

    if post.save
      redirect_to posts_path, notice: "投稿しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "削除しました"
  end

  private



  def post_params
    params.require(:post).permit(
      :title, :ingredients, :steps,
      :cook_time, :dish_type, :difficulty, :cuisine_type, :image
    )
  end
end
