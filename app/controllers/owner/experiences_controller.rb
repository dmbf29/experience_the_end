module Owner
    class ExperiencesController < ApplicationController
      def index
        @experiences = policy_scope([:owner, Experience]).order(created_at: :asc)
      end
    end
  end
  