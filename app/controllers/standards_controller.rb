class StandardsController < ApplicationController
  before_action :set_course
  before_action :set_standard, only: [:show, :edit, :update, :destroy]

  # GET /standards
  # GET /standards.json
  def index
    @standards = Standard.all
  end

  # GET /standards/1
  # GET /standards/1.json
  def show
  end

  # GET /standards/new
  def new
    @standard = Standard.new(course:@course)
  end

  # GET /standards/1/edit
  def edit
  end

  # POST /standards
  # POST /standards.json
  def create
    @standard = Standard.new(standard_params)

    respond_to do |format|
      if @standard.save
        format.html { redirect_to [@course, @standard], notice: 'Standard was successfully created.' }
        format.json { render :show, status: :created, location: @standard }
      else
        format.html { render :new }
        format.json { render json: @standard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /standards/1
  # PATCH/PUT /standards/1.json
  def update
    respond_to do |format|
      if @standard.update(standard_params)
        format.html { redirect_to course_standard_url(@course,@standard), notice: 'Standard was successfully updated.' }
        format.json { render :show, status: :ok, location: @standard }
      else
        format.html { render :edit }
        format.json { render json: @standard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /standards/1
  # DELETE /standards/1.json
  def destroy
    @standard.destroy
    respond_to do |format|
      format.html { redirect_to course_standards_url(@course), notice: 'Standard was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # # GET /exams/1/grade/
  # def grade
  # end
  #
  # # POST /exams/1/post_grades/
  # def post_grades
  #
  #   params[:attempt].each do |assessment_id|
  #     if outcome_id = params[:attempt][assessment_id]
  #       unless Attempt.create(
  #         standard: @standard,
  #         assessment_id: assessment_id,
  #         outcome_id: outcome_id
  #       )
  #         respond_to do |format|
  #           format.html { render :grade, notice: 'There was an issue in saving grades.' }
  #         end
  #       end
  #     end
  #   end
  #
  #   respond_to do |format|
  #       format.html { redirect_to grade_standard_path(@standard), notice: 'Grades were successfully posted.' }
  #       format.json { render :show, status: :created, location: @standard }
  #   end
  #
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_standard
      @standard = Standard.find(params[:id])
    end
    def set_course
      @course = Course.find(params[:course_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def standard_params
      params.require(:standard).permit(:name, :description, :category).merge(course:@course)
    end
end
