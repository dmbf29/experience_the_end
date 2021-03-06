class Experiences::BuildController < ApplicationController
  include Wicked::Wizard
  skip_before_action :authenticate_user!
  before_action :set_progress, only: [:show]


  steps :add_name, :add_description, :add_price, :add_address, :add_photos

  def show
    @experience = Experience.find(params[:experience_id])
    authorize @experience
    render_wizard
  end


  def update
    @experience = Experience.find(params[:experience_id])
    params[:experience][:status] = step.to_s
    params[:experience][:status] = 'active' if step == steps.last
    authorize @experience
    @experience.update(experience_params)
    render_wizard @experience
  end

  def new
    @experience = Experience.find(params[:experience_id])
    authorize @experience
    redirect_to wizard_path(steps.first)
  end

  def finish_wizard_path
    experience_path(@experience)
  end

  private

  def set_progress
    if wizard_steps.any? && wizard_steps.index(step).present?
      @progress = ((wizard_steps.index(step) + 1).to_d / wizard_steps.count.to_d) * 100
    else
      @progress = 0
    end
  end

  def experience_params
    params.require(:experience).permit(:name, :description, :price, :start_time, :end_time, :address, :status, photos: [])
  end
end
