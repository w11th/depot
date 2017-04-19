class LineItemsController < ApplicationController
  include Cartable
  include AccessTimesTrackable

  skip_before_action :authorize, only: [:create, :destroy]

  before_action :set_cart, only: [:create, :destroy, :increase, :decrease]
  after_action :clear_counter, only: [:create]

  before_action :set_line_item, only: [:show, :edit, :update, :destroy, :increase, :decrease]

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  # POST /line_items.json
  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to stores_index_url }
        format.js { @current_item = @line_item }
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to stores_index_url, notice: 'Line item was successfully destroyed.' }
      format.js
      format.json { head :no_content }
    end
  end

  def increase
    @line_item.increase_quantity
    respond_to do |format|
      format.html { redirect_to stores_index_url }
      format.js { @current_item = @line_item }
    end
  end

  def decrease
    @line_item.decrease_quantity
    respond_to do |format|
      format.html { redirect_to stores_index_url }
      format.js { @current_item = @line_item }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      params.require(:line_item).permit(:product_id)
    end
end
