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
FactoryBot.define do
  factory :custom_field do
    field_type { :text }
    name { FFaker::Lorem.word }
    options { [] }
    tenant
  end
end
