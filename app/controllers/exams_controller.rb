class ExamsController < ApplicationController
  before_action :set_exam, only: [:show, :edit, :update, :destroy, :grade, :post_grades]

  # GET /exams
  # GET /exams.json
  def index
    @exams = Exam.all
  end

  # GET /exams/1
  # GET /exams/1.json
  def show
  end

  # GET /exams/new
  def new
    @exam = Exam.new
  end

  # GET /exams/1/edit
  def edit
  end

  # POST /exams
  # POST /exams.json
  def create
    @exam = Exam.new(exam_params)

    respond_to do |format|
      if @exam.save
        format.html { redirect_to @exam, notice: 'Exam was successfully created.' }
        format.json { render :show, status: :created, location: @exam }
      else
        format.html { render :new }
        format.json { render json: @exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exams/1
  # PATCH/PUT /exams/1.json
  def update
    respond_to do |format|
      if @exam.update(exam_params)
        format.html { redirect_to @exam, notice: 'Exam was successfully updated.' }
        format.json { render :show, status: :ok, location: @exam }
      else
        format.html { render :edit }
        format.json { render json: @exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exams/1
  # DELETE /exams/1.json
  def destroy
    @exam.destroy
    respond_to do |format|
      format.html { redirect_to exams_url, notice: 'Exam was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /exams/1/grade/
  def grade
    @students = Student.all
  end

  # POST /exams/1/post_grades/
  def post_grades

    params[:attempt].each do |student_id|
      params[:attempt][student_id].each do |assessment_id|

        if outcome_id = params[:attempt][student_id][assessment_id]

          unless Attempt.create(
            student_id: student_id,
            assessment_id: assessment_id,
            outcome_id: outcome_id
          )
            respond_to do |format|
              format.html { render :grade, notice: 'There was an issue in saving grades.' }
            end
          end

        end

      end
    end

    respond_to do |format|
        format.html { redirect_to grade_exam_path(@exam), notice: 'Grades were successfully posted.' }
        format.json { render :show, status: :created, location: @exam }
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exam
      @exam = Exam.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exam_params
      params.require(:exam).permit(:name, :description)
    end
end
