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

RSpec.describe CustomFieldsValue do
  context 'fields' do
    it { is_expected.to have_db_column(:customizable_type).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:value).of_type(:jsonb).with_options(null: false) }
    it { is_expected.to have_db_column(:custom_field_id).of_type(:integer) }
    it { is_expected.to have_db_column(:customizable_id).of_type(:integer).with_options(null: false) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
  end

  context 'relations' do
    it { is_expected.to belong_to(:custom_field) }
    it { is_expected.to belong_to(:customizable) }
  end

  context 'indexes' do
    it { is_expected.to have_db_index(%i[customizable_type customizable_id custom_field_id]).unique }
    it { is_expected.to have_db_index(:custom_field_id) }
  end
end
