module Owner
    class ExperiencesController < ApplicationController
      def index
        @experiences = policy_scope([:owner, Experience]).order(created_at: :asc)
      end

      def destroy
        @experience = Experience.find(params[:id])
        authorize @experience
        @experience.destroy
      end
    end
  end
  