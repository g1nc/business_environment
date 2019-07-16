# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#index' do
    it 'return list' do
      user = create(:user, name: 'John Doe')
      user.update_balance(100)
      get(:index)
      expect(JSON.parse(response.body)).to match(
        'success' => true,
        'users' => [
          {
            'id' => kind_of(Integer),
            'name' => 'John Doe',
            'balance' => 100
          }
        ]
      )
    end
  end

  describe '#show' do
    before(:each) { Operation.destroy_all }
    let(:user) { create(:user, name: 'John Doe', balance: 0) }

    it 'return operations list' do
      user.update_balance(100)
      get(:show, params: { id: user.id })
      expect(JSON.parse(response.body)).to match(
        'success' => true,
        'operations' => [
          {
            'name' => 'John Doe',
            'amount' => 100,
            'created_at' => kind_of(String)
          }
        ]
      )
    end

    it 'return error' do
      get(:show, params: { id: 0 })
      expect(JSON.parse(response.body)).to match(
        'success' => false,
        'error' => kind_of(String)
      )
    end
  end

  describe '#update' do
    let(:user) { create(:user, name: 'John Doe', balance: 100) }

    it 'return operations list' do
      put(:update, params: { id: user.id, amount: 100 })
      expect(JSON.parse(response.body)).to match(
         'success' => true,
         'balance' => 200
      )
      user.reload
      expect(user.balance).to eq(200)
    end

    it 'return error' do
      put(:update, params: { id: 0, amount: 100 })
      expect(JSON.parse(response.body)).to match(
        'success' => false,
        'error' => kind_of(String)
      )
    end
  end
end
