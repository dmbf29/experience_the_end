module Owner
    class ExperiencePolicy < ApplicationPolicy
      class Scope < Scope
        def resolve
          scope.where(user: user )
        end
      end
    end
  end
  