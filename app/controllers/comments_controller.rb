class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :destroy]
  before_action :require_login, only: [:create, :edit, :update, :destroy]

  def create
    @item = Item.find(params[:item_id])
    @comment = current_user.comments.build(comment_params)
    @comment.item = @item
    if @comment.save
      redirect_to item_path(@item), success: "コメントを投稿しました"
    else
      render 'items/show', status: :unprocessable_entity
    end
  end

  def edit
    @item = Item.find(params[:item_id])
    @comment = Comment.find(params[:id])
  end

  def update
    @item = Item.find(params[:item_id])
    @comment = @item.comments.find(params[:id])
    if @comment.update(comment_params)
      redirect_to item_path(@item), notice: 'コメントが更新されました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy!
    redirect_to item_path(@comment.item), notice: 'コメントが削除されました'
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def require_login
    return if logged_in?

    redirect_to login_path
  end

  def comment_params
    params.require(:comment).permit(:content).merge(item_id: params[:item_id])
  end
end
