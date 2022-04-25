class ActivitiesController < ApplicationController
  before_action :set_activity, only: %i[ show edit update destroy ]

  # GET /activities or /activities.json
  def index
    @activities = Activity.all
  end

  # GET /activities/1 or /activities/1.json
  def show
  end

  # GET /activities/new
  def new
    session[:activity_params] ||= {}
    @activity = Activity.new(session[:activity_params])
    @activity.current_step = session[:activity_step]
  end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities or /activities.json
  def create
    session[:activity_params].deep_merge!(activity_params) if params[:activity]
    @activity = Activity.new(session[:activity_params])
    @activity.current_step = session[:activity_step]
    if params[:back_button]
      @activity.previous_step
    elsif @activity.last_step?
      @activity.save
    else
      @activity.next_step
    end
    session[:activity_step] = @activity.current_step
    if @activity.new_record?
      render 'new'
    else
      session[:activity_step] = session[:activity_params] = nil
      flash[:notice] = "Activity saved."
      redirect_to @activity
    end
  end

  # PATCH/PUT /activities/1 or /activities/1.json
  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.html { redirect_to activity_url(@activity), notice: "Activity was successfully updated." }
        format.json { render :show, status: :ok, location: @activity }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1 or /activities/1.json
  def destroy
    @activity.destroy

    respond_to do |format|
      format.html { redirect_to activities_url, notice: "Activity was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def activity_params
      params.require(:activity).permit(:name, :address, :starts_at, :ends_at)
    end
end
