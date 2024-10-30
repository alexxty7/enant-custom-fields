# frozen_string_literal: true

class CreateCustomFieldsValues < ActiveRecord::Migration[7.2]
  def change
    create_table :custom_fields_values do |t|
      t.references :customizable, polymorphic: true, null: false, index: false

      t.references :custom_field, foreign_key: true
      t.jsonb :value, null: false, default: {}
      t.timestamps

      t.index %i[customizable_type customizable_id custom_field_id], unique: true
    end
  end
end
