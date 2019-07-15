# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe '#update_balance' do
    it 'update balance' do
      user.update_balance(100)
      expect(user.balance).to eq(100)
    end

    it 'create operation' do
      expect{ user.update_balance(100) }.to change(Operation, :count).by(1)
    end

    it 'use transaction' do
      threads = []
      5.times do
        threads << Thread.new do
          user.update_balance(10)
        end
      end
      ActiveSupport::Dependencies.interlock.permit_concurrent_loads  do
        threads.each(&:join)
      end
      expect(user.balance).to eq(100)
    end
  end
end
