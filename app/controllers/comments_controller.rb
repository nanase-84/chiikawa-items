class CommentsController < ApplicationController

  def new
    @item = Item.find_by(id: params[:item_id]) # item_idを使ってitemを取得
    if @item.nil?
      redirect_to items_path, alert: 'アイテムが見つかりませんでした'
      return
    end
    @comment = @item.comments.build 
  end

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to item_path(@comment.item), success: "コメントを投稿しました"
    else
      redirect_to item_path(@comment.item), danger: "コメントの投稿に失敗しました"
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
