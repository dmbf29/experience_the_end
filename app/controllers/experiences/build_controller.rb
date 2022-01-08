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
    params[:experience][:status] = 'active' if step == steps.last
    @experience.update_attributes(params[:experience])
    authorize @experience
    render_wizard @experience
  end


  def new
    @experience = Experience.find(params[:experience_id])
    authorize @experience
    redirect_to wizard_path(steps.first)
  end

  private
    def set_progress
      if wizard_steps.any? && wizard_steps.index(step).present?
        @progress = ((wizard_steps.index(step) + 1).to_d / wizard_steps.count.to_d) * 100
      else
        @progress = 0
      end
    end
end