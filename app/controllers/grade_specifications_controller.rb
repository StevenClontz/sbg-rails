class GradeSpecificationsController < ApplicationController
  before_action :set_course
  before_action :set_grade_specification, only: [:show, :edit, :update, :destroy]

  # GET /grade_specifications
  # GET /grade_specifications.json
  def index
    @grade_specifications = GradeSpecification
      .includes(:standard_category)
      .where(course:@course)
  end

  # GET /grade_specifications/1
  # GET /grade_specifications/1.json
  def show
  end

  # GET /grade_specifications/new
  def new
    @grade_specification = GradeSpecification.new course:@course
  end

  # GET /grade_specifications/1/edit
  def edit
  end

  # POST /grade_specifications
  # POST /grade_specifications.json
  def create
    @grade_specification = GradeSpecification.new(grade_specification_params)

    respond_to do |format|
      if @grade_specification.save
        format.html { redirect_to [@grade_specification.course,@grade_specification], notice: 'Grade specification was successfully created.' }
        format.json { render :show, status: :created, location: @grade_specification }
      else
        format.html { render :new }
        format.json { render json: @grade_specification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /grade_specifications/1
  # PATCH/PUT /grade_specifications/1.json
  def update
    respond_to do |format|
      if @grade_specification.update(grade_specification_params)
        format.html { redirect_to [@grade_specification.course,@grade_specification], notice: 'Grade specification was successfully updated.' }
        format.json { render :show, status: :ok, location: @grade_specification }
      else
        format.html { render :edit }
        format.json { render json: @grade_specification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grade_specifications/1
  # DELETE /grade_specifications/1.json
  def destroy
    @grade_specification.destroy
    respond_to do |format|
      format.html { redirect_to course_grade_specifications_url(@course), notice: 'Grade specification was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grade_specification
      @grade_specification = GradeSpecification.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grade_specification_params
      params.require(:grade_specification).permit(:grade, :requirement, :amount, :standard_category_id).merge(course:@course)
    end
end
