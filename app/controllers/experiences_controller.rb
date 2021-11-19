class ExperiencesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  def index
  end

  def show
    @expeience = Experience.find(params[:id])
  end

  def new
  end
end
