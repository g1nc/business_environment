# frozen_string_literal: true

class User < ApplicationRecord
  has_many :operations

  def update_balance(amount)
    with_lock do
      self.balance += amount
      operations.create!(amount: amount)
      save!
    end
  end
end
