# frozen_string_literal: true

class UsersListPresenter
  def initialize(users)
    @users = users
  end

  def present
    {
      success: true,
      users: @users.map do |user|
        {
          id: user.id,
          name: user.name,
          balance: user.balance
        }
      end
    }
  end
end
