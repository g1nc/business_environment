# frozen_string_literal: true

class CreateOperations < ActiveRecord::Migration[5.2]
  def change
    create_table :operations do |t|
      t.references :user
      t.float :amount, null: false
      t.timestamps
    end
  end
end
