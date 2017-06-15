class AttemptCategoriesController < ApplicationController
  before_action :set_course
  before_action :set_attempt_category, only: [:show, :edit, :update, :destroy]

  # GET /attempt_categories
  # GET /attempt_categories.json
  def index
    @attempt_categories = AttemptCategory.where course:@course
  end

  # GET /attempt_categories/1
  # GET /attempt_categories/1.json
  def show
  end

  # GET /attempt_categories/new
  def new
    @attempt_category = AttemptCategory.new course:@course
  end

  # GET /attempt_categories/1/edit
  def edit
  end

  # POST /attempt_categories
  # POST /attempt_categories.json
  def create
    @attempt_category = AttemptCategory.new(attempt_category_params)

    respond_to do |format|
      if @attempt_category.save
        format.html { redirect_to [@attempt_category.course,@attempt_category], notice: 'Attempt category was successfully created.' }
        format.json { render :show, status: :created, location: @attempt_category }
      else
        format.html { render :new }
        format.json { render json: @attempt_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attempt_categories/1
  # PATCH/PUT /attempt_categories/1.json
  def update
    respond_to do |format|
      if @attempt_category.update(attempt_category_params)
        format.html { redirect_to [@attempt_category.course,@attempt_category], notice: 'Attempt category was successfully updated.' }
        format.json { render :show, status: :ok, location: @attempt_category }
      else
        format.html { render :edit }
        format.json { render json: @attempt_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attempt_categories/1
  # DELETE /attempt_categories/1.json
  def destroy
    @attempt_category.destroy
    respond_to do |format|
      format.html { redirect_to course_attempt_categories_url(@course), notice: 'Attempt category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attempt_category
      @attempt_category = AttemptCategory.find(params[:id])
    end
    def set_course
      @course = Course.find(params[:course_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attempt_category_params
      params.require(:attempt_category).permit(:name, :default_attempt_points).merge(course_id:@course.id)
    end
end
