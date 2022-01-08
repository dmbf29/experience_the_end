module Owner
  class BookingPolicy < ApplicationPolicy
    class Scope < Scope
      def resolve
        scope.joins(:experience).where(experiences: { user: user })
      end
    end
  end
end
