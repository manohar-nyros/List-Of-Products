class ListsController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  # GET /lists
  # GET /lists.json
  def index
    @lists = List.search(params[:search]).order(sort_column + ' ' + sort_direction).paginate(:per_page => 3, :page => params[:page])
    respond_to do |format|
    format.html
    format.js   
    format.json { head :no_content }
    end
  end
  # GET /lists/1
  # GET /lists/1.json
  def show
    # render 'new'
  end
  # GET /lists/new
  def new
    @list = List.new
  end

  def send_email
    @lists = List.all
    ExampleMailer.sent_product(@lists).deliver_now  
    # redirect_to lists_path
    render :index
  end
  # GET /lists/1/edit
  def edit
  end

  # POST /lists
  # POST /lists.json
  def create
    @list = List.new(list_params)
    respond_to do |format|
      if @list.save
        format.html { redirect_to @list, notice: 'List was successfully created.' }
        format.json { render json: @list, status: :created, location: @list }
      else
        format.html { render :new }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lists/1
  # PATCH/PUT /lists/1.json
  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to @list, notice: 'List was successfully updated.' }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy
    @list.photo = nil
    @list.destroy
    respond_to do |format|
      format.html { redirect_to lists_url, notice: 'List was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def list_params
      params.require(:list).permit(:title, :description, :text, :price, :quantity, :photo, :vat, :total, :product_id )
    end

  def sort_column
    List.column_names.include?(params[:sort]) ? params[:sort] : "title" 
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end
end