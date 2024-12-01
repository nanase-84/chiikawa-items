class CommentsController < ApplicationController

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
    @comment = @item.comments.find(params[:id])
  end

  def update
    @comment = @item.comments.find(params[:id])
    if @comment.update(comment_params)
      redirect_to item_path(@item), notice: 'コメントが更新されました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(item_id: params[:item_id])
  end
end
