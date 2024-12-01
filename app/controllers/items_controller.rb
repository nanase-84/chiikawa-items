class ItemsController < ApplicationController
skip_before_action :require_login, only: %i[top]
before_action :require_login, only: %i[new create edit update destroy]
before_action :set_item, only: %i[show edit update destroy]

  # GET /items or /items.json
  def index
    @items = Item.all
  end

  def top
    if params[:tag].present?
      @items = Item.joins(:tags).where(tags: { name: params[:tag] }).order(created_at: :desc).page(params[:page]).per(6)
    else
      @items = Item.includes(:tags).order(created_at: :desc).page(params[:page]).per(6)
    end
  end

  # GET /items/1 or /items/1.json
  def show
    @comment = Comment.new
    @comments = @item.comments.includes(:user).order(created_at: :desc)
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items or /items.json
  def create
    @item = Item.new(item_params)
      if @item.save
        @item.assign_tags(params[:item][:tag_list]) if params[:item][:tag_list].present?
        redirect_to @item, notice: "アイテムが登録されました。"
      else
        render :new, status: :unprocessable_entity
      end
  end

  # PATCH/PUT /items/1 or /items/1.json
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      @item.assign_tags(params[:item][:tag_list]) if params[:item][:tag_list].present?
      redirect_to @item, notice: "アイテムが更新されました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /items/1 or /items/1.json
  def destroy
    if @item.destroy
      redirect_to items_path, status: :see_other, notice: "アイテムが正常に削除されました。"
    else
      redirect_to items_path, alert: "アイテムの削除に失敗しました。"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def require_login
      unless logged_in?
        redirect_to new_user_path, alert: 'ログインしてください'
      end
    end

    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:name, :description, :image_url, :image_url_cache, :storage, :status, :tag_list, tag_ids: [])
    end
end
