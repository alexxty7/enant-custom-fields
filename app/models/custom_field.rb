# frozen_string_literal: true

# == Schema Information
#
# Table name: custom_fields
#
#  id         :bigint           not null, primary key
#  field_type :integer          default("text"), not null
#  name       :string           not null
#  options    :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tenant_id  :bigint
#
# Indexes
#
#  index_custom_fields_on_name_and_field_type  (name,field_type) UNIQUE
#  index_custom_fields_on_tenant_id            (tenant_id)
#
# Foreign Keys
#
#  fk_rails_...  (tenant_id => tenants.id)
#
class CustomField < ApplicationRecord
  belongs_to :tenant

  enum :field_type, { text: 0, number: 1, single_select: 2, multiple_select: 3 }
end
