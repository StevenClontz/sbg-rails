class StandardCategoriesController < ApplicationController
  before_action :set_course
  before_action :set_standard_category, only: [:show, :edit, :update, :destroy]

  # GET /standard_categories
  # GET /standard_categories.json
  def index
    @standard_categories = StandardCategory.where course:@course
  end

  # GET /standard_categories/1
  # GET /standard_categories/1.json
  def show
  end

  # GET /standard_categories/new
  def new
    @standard_category = StandardCategory.new course:@course
  end

  # GET /standard_categories/1/edit
  def edit
  end

  # POST /standard_categories
  # POST /standard_categories.json
  def create
    @standard_category = StandardCategory.new(standard_category_params)

    respond_to do |format|
      if @standard_category.save
        format.html { redirect_to [@standard_category.course,@standard_category], notice: 'Standard category was successfully created.' }
        format.json { render :show, status: :created, location: @standard_category }
      else
        format.html { render :new }
        format.json { render json: @standard_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /standard_categories/1
  # PATCH/PUT /standard_categories/1.json
  def update
    respond_to do |format|
      if @standard_category.update(standard_category_params)
        format.html { redirect_to [@standard_category.course,@standard_category], notice: 'Standard category was successfully updated.' }
        format.json { render :show, status: :ok, location: @standard_category }
      else
        format.html { render :edit }
        format.json { render json: @standard_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /standard_categories/1
  # DELETE /standard_categories/1.json
  def destroy
    @standard_category.destroy
    respond_to do |format|
      format.html { redirect_to course_standard_categories_url(@course), notice: 'Standard category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_standard_category
      @standard_category = StandardCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def standard_category_params
      params.require(:standard_category).permit(:name, :description, :satsifactory_limit).merge(course:@course)
    end
end
