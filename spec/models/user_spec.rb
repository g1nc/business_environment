# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user, balance: 0) }

  describe '#update_balance' do
    it 'update balance' do
      user.update_balance(100)
      expect(user.balance).to eq(100)
    end

    it 'create operation' do
      expect { user.update_balance(100) }.to change(Operation, :count).by(1)
    end

    it 'use transaction with lock' do
      threads = []
      10.times do
        threads << Thread.new { User.find(user.id).update_balance(10) }
      end
      ActiveSupport::Dependencies.interlock.permit_concurrent_loads { threads.each(&:join) }
      user.reload
      expect(user.balance).to eq(100)
    end
  end
end
