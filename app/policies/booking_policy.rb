class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def create?
    record.experience.user != user
  end

  def update?
    record.user == user
  end
end
