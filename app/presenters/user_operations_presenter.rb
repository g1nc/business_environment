# frozen_string_literal: true

class UserOperationsPresenter
  def initialize(user)
    @user = user
  end

  def present
    {
      success: true,
      operations: @user.operations.map do |operation|
        {
          name: @user.name,
          amount: operation.amount,
          created_at: operation.created_at
        }
      end
    }
  end
end
