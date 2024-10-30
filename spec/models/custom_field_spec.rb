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

RSpec.describe CustomField do
  context 'fields' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to allow_value({}).for(:options) }
    it { is_expected.to have_db_column(:field_type).of_type(:integer).with_options(null: false) }
    it { is_expected.to define_enum_for(:field_type).with_values(%i[text number single_select multiple_select]) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  end

  context 'relations' do
    it { is_expected.to belong_to(:tenant) }
    it { is_expected.to have_many(:apple_calendar_list_items).dependent(:destroy) }
  end

  context 'indexes' do
    it { is_expected.to have_db_index(%i[name field_type]).unique }
    it { is_expected.to have_db_index(:tenant_id) }
  end
end
