class ActivitiesController < ApplicationController
  def index
    activities = Activity.all
    render json: activities, status: :ok
  end

  def destroy
    activity = Activity.find_by(id: params[:id])

    if activity
      activity.signups.destroy_all
      activity.destroy
      head :no_content
    else
      render json: { error: "Activity not found" }, status: :not_found
    end
  end

  def create
    activity = Activity.new(activity_params)
    if activity.save
      render json: activity, status: :created
    else
      render json: { errors: activity.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def activity_params
    params.require(:activity).permit(:name, :difficulty)
  end
end
