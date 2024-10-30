# frozen_string_literal: true

class CreateCustomFields < ActiveRecord::Migration[7.2]
  def change
    create_table :custom_fields do |t|
      t.string :name, null: false
      t.integer :field_type, default: 0, null: false
      t.jsonb :options, default: []

      t.references :tenant, foreign_key: true
      t.timestamps

      t.index %i[name field_type], unique: true
    end
  end
end
