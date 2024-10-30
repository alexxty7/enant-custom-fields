# frozen_string_literal: true

class CreateTenants < ActiveRecord::Migration[7.2]
  def change
    create_table :tenants do |t|
      t.string :name, index: { unique: true }, null: false
      t.timestamps
    end
  end
end
