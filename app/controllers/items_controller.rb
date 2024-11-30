class ItemsController < ApplicationController
  skip_before_action :require_login, only: %i[top]
  before_action :require_login, only: %i[new create edit update destroy]
  before_action :set_item, only: %i[ show edit update destroy ]

  # GET /items or /items.json
  def index
    @items = Item.all
  end

  def top
    @items = Item.all
  end

  # GET /items/1 or /items/1.json
  def show; end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit; end

  # POST /items or /items.json
  def create
    @item = Item.new(item_params)

      if @item.save
        @item.tags = parse_tags(params[:item][:tag_list])
        redirect_to @item, notice: "アイテムが登録されました。"
      else
        render :new
      end
  end

  # PATCH/PUT /items/1 or /items/1.json
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      @item.tags = parse_tags(params[:item][:tag_list])
      redirect_to @item, notice: "アイテムが更新されました。"
    else
      render :edit
    end
  end

  # DELETE /items/1 or /items/1.json
  def destroy
    @item.destroy!

    respond_to do |format|
      format.html { redirect_to items_path, status: :see_other, notice: "Item was successfully destroyed." }
      format.json { head :no_content }
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
      params.require(:item).permit(:name, :description, :image_url, :image_url_cache, :storage, :status)
    end

    def parse_tags(tag_list)
      tag_list.split(',').map(&:strip).uniq.map do |tag_name|
        Tag.find_or_create_by(name: tag_name)
      end
    end
end
