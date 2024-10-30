# frozen_string_literal: true

# == Schema Information
#
# Table name: custom_fields_values
#
#  id                :bigint           not null, primary key
#  customizable_type :string           not null
#  value             :jsonb            not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  custom_field_id   :bigint
#  customizable_id   :bigint           not null
#
# Indexes
#
#  idx_on_customizable_type_customizable_id_custom_fie_766f7da43e  (customizable_type,customizable_id,custom_field_id) UNIQUE
#  index_custom_fields_values_on_custom_field_id                   (custom_field_id)
#
# Foreign Keys
#
#  fk_rails_...  (custom_field_id => custom_fields.id)
#
class CustomFieldsValue < ApplicationRecord
  belongs_to :custom_field
  belongs_to :customizable, polymorphic: true
end
