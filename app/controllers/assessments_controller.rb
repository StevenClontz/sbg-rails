class AssessmentsController < ApplicationController
  before_action :set_assessment, only: [:show, :edit, :update, :destroy]
  before_action :set_course

  # GET /attempts
  # GET /attempts.json
  def index
    @assessments = Assessment
      .where(course:@course)
  end

  # GET /attempts/1
  # GET /attempts/1.json
  def show
  end

  # GET /attempts/new
  def new
    @assessment = Assessment.new(course:@course)
  end

  # GET /attempts/1/edit
  def edit
  end

  # POST /attempts
  # POST /attempts.json
  def create
    @assessment = Assessment.new(assessment_params)

    respond_to do |format|
      if @assessment.save
        format.html { redirect_to [@course, @assessment], notice: 'Assessment was successfully created.' }
        format.json { render :show, status: :created, location: @assessment }
      else
        format.html { render :new }
        format.json { render json: @assessment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attempts/1
  # PATCH/PUT /attempts/1.json
  def update
    respond_to do |format|
      if @assessment.update(assessment_params)
        format.html { redirect_to [@course, @assessment], notice: 'Attempt was successfully updated.' }
        format.json { render :show, status: :ok, location: @assessment }
      else
        format.html { render :edit }
        format.json { render json: @assessment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attempts/1
  # DELETE /attempts/1.json
  def destroy
    @assessment.destroy
    respond_to do |format|
      format.html { redirect_to course_attempts_url(@course), notice: 'Attempt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assessment
      @assessment = Assessment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assessment_params
      params.require(:assessment).permit(:name).merge(course:@course)
    end
end
