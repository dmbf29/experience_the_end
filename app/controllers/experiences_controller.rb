class ExperiencesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  include Wicked::Wizard

  steps :add_name, :add_description, :add_price, :add_address, :add_photos

  def index
    @experiences = policy_scope(Experience)
    @markers = @experiences.geocoded.map do |experience|
      {
        lat: experience.latitude,
        lng: experience.longitude,
        popup_html: render_to_string(partial: "map_popup", locals: { experience: experience }),
        marker_html: render_to_string(partial: "map_marker", locals: { experience: experience })
      }
    end
  end

  def show
    @experience = Experience.find(params[:id])
    @booking = Booking.new
    authorize @experience
    render_wizard
  end

  def new
    @experience = Experience.new
    authorize @experience
    redirect_to wizard_path(steps.first, experience_id: @experience.id)
  end
end
