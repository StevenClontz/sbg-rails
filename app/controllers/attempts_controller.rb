class AttemptsController < ApplicationController
  before_action :set_attempt, only: [:show, :edit, :update, :destroy]
  before_action :set_course

  # GET /attempts
  # GET /attempts.json
  def index
    @attempts =   Attempt
      .joins(:student,:standard)
      .where(students:{course:@course})
      .order('students.last_name ASC')
      .order('students.first_name ASC')
      .order(:attempted_on)
      .order('standards.name ASC')
  end

  def index_recent_provisionals
    @attempts = Attempt.recent_provisionals
      .joins(:student,:standard)
      .where(students:{course:@course})
      .order(attempted_on: :desc)
      .order('students.last_name ASC')
      .order('students.first_name ASC')
      .order('standards.name ASC')
    render :index
  end


  # GET /attempts/1
  # GET /attempts/1.json
  def show
  end

  # GET /attempts/new
  def new
    @attempt = Attempt.new(course:@course)
  end

  # GET /attempts/1/edit
  def edit
  end

  # POST /attempts
  # POST /attempts.json
  def create
    @attempt = Attempt.new(attempt_params)

    respond_to do |format|
      if @attempt.save
        format.html { redirect_to [@course, @attempt], notice: 'Attempt was successfully created.' }
        format.json { render :show, status: :created, location: @attempt }
      else
        format.html { render :new }
        format.json { render json: @attempt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attempts/1
  # PATCH/PUT /attempts/1.json
  def update
    respond_to do |format|
      if @attempt.update(attempt_params)
        format.html { redirect_to [@course, @attempt], notice: 'Attempt was successfully updated.' }
        format.json { render :show, status: :ok, location: @attempt }
      else
        format.html { render :edit }
        format.json { render json: @attempt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attempts/1
  # DELETE /attempts/1.json
  def destroy
    @attempt.destroy
    respond_to do |format|
      format.html { redirect_to course_attempts_url(@course), notice: 'Attempt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attempt
      @attempt = Attempt.find(params[:id])
    end
    def set_course
      @course = Course.find(params[:course_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attempt_params
      params.require(:attempt).permit(:standard_id, :student_id, :mark, :note, :attempted_on, :attempt_category_id, :attempt_points_used)
    end
end
