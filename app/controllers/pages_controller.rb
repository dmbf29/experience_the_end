class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    # render :home, locals: { transparent_nav: true, dark_nav: true }
    @experiences = Experience.all.limit(10)
  end
end
