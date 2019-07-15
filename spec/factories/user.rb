# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'John Doe' }
    balance { 0 }
  end
end