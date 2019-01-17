class DishTypesController < ApplicationController
  layout 'dish_type'
  
    def index
    page=params[:page] ? params[:page].to_i : 1
    page_size = params[:page_size] ? params[:page_size].to_i : 15
    @list = DishType.order('id desc').paginate(:page => page, :per_page => page_size)
    end
    
      def show
        respond_to do |format|
          format.html # show.html.erb
          format.json { render json: @dish_type }
        end
      end
      
      def new
        @dish_type = DishType.new
      end

# GET /dishes/1/edit
  def edit

  end

# POST /dishes
# POST /dishes.json
  def create
    @dish_type = DishType.new()

    #t.string   "name"
    #t.string   "describe"
    #t.datetime "created_at"
    #t.datetime "updated_at"
    @dish_type.name = params[:dish_type][:name]
    @dish_type.describe = params[:dish_type][:describe]

    begin
      DishType.transaction do
        @dish_type.save!
        flash[:notice] = '创建菜品成功'
      end
      redirect_to :action => :index

    rescue
      error_message = ''
      @dish_type.errors[:error_message].each do |error|
        if error == @dish_type.errors[:error_message].last
          error_message += error.to_s
        else
          error_message += error.to_s + ','
        end
      end
      flash[:msg] = error_message
      @dish_type.errors.clear
      render :new and return
    end

  end

# PATCH/PUT /dishes/1
# PATCH/PUT /dishes/1.json
  def update
    @dish_type.name = params[:dish_type][:name]
    @dish_type.describe = params[:dish_type][:describe]

    begin
      DishType.transaction do
        @dish_type.save!
        flash[:notice] = '修改菜系成功'
      end
      redirect_to :action => :show, :id => @dish_type.id #, :port => PORT
    rescue
      error_message = ''
      @dish_type.errors[:error_message].each do |error|
        if error == @dish_type.errors[:error_message].last
          error_message += error.to_s
        else
          error_message += error.to_s + ','
        end
      end
      flash[:msg] = error_message
      @dish_type.errors.clear
      render :edit and return

    end
  end

# DELETE /dishes/1
# DELETE /dishes/1.json
  def destroy
    @dish_type.destroy
    respond_to do |format|
      format.html { redirect_to dish_types_url }
      format.json { head :no_content }
    end
  end


  private
# Use callbacks to share common setup or constraints between actions.
  def set_dish_type
    @dish_type= DishType.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def dish_params
    params[:dish_type]
  end

end