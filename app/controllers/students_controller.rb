class StudentsController < ApplicationController
  before_action :set_course
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  # GET /students
  # GET /students.json
  def index
    @students = Student.where(course:@course).order(last_name: :asc)
  end

  # GET /students/1
  # GET /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new(course:@course)
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to [@course, @student], notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to course_student_url(@course,@student), notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to course_students_url(@course), notice: 'Student was successfully destroyed.' }
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
  #         student: @student,
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
  #       format.html { redirect_to grade_student_path(@student), notice: 'Grades were successfully posted.' }
  #       format.json { render :show, status: :created, location: @student }
  #   end
  #
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end
    def set_course
      @course = Course.find(params[:course_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:first_name, :last_name, :school_identifier, :email).merge(course:@course)
    end
end
