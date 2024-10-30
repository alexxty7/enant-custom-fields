# frozen_string_literal: true

RSpec.describe Users::Operation::Update do
  subject(:result) { described_class.call(params:) }

  let(:params) { { id: user.id, name:, custom_fields_values: } }
  let(:user) { create(:user) }
  let(:name) { FFaker::Name.name }
  let(:custom_fields_values) { [] }

  let(:options) { %w[A1 A2 B1 B2] }
  let!(:number_field) { create(:custom_field, field_type: :number, tenant: user.tenant) }
  let!(:text_field) { create(:custom_field, field_type: :text, tenant: user.tenant) }
  let!(:multiple_select_field) { create(:custom_field, field_type: :multiple_select, options:, tenant: user.tenant) }
  let!(:single_select_field) { create(:custom_field, field_type: :single_select, options:, tenant: user.tenant) }

  describe 'Success' do
    it 'updates user fields' do
      expect { result }.to change { user.reload.name }.to(name)

      expect(result).to be_success
    end

    context 'when user fields empty' do
      let(:custom_fields_values) do
        [
          { custom_field_id: number_field.id, value: 1_234_567 },
          { custom_field_id: text_field.id, value: 'My life' },
          { custom_field_id: multiple_select_field.id, value: %w[A1 A2] },
          { custom_field_id: single_select_field.id, value: 'A1' }
        ]
      end

      it 'creates new user custom fields' do
        expect(result[:model].custom_fields_values)
          .to contain_exactly(have_attributes(value: 1_234_567), have_attributes(value: 'My life'),
                              have_attributes(value: %w[A1 A2]),
                              have_attributes(value: 'A1'))
        expect(result).to be_success
      end
    end

    context 'when user already have custom field' do
      let(:custom_fields_values) do
        [
          { custom_field_id: number_field.id, value: 1_234_567 },
          { custom_field_id: text_field.id, value: 'My life 2' },
          { custom_field_id: multiple_select_field.id, value: %w[A1] },
          { custom_field_id: single_select_field.id, value: 'A1', _destroy: true }
        ]
      end

      before do
        create(:custom_fields_value, customizable: user, custom_field: number_field, value: 1_234_567)
        create(:custom_fields_value, customizable: user, custom_field: text_field, value: 'My life')
        create(:custom_fields_value, customizable: user, custom_field: multiple_select_field, value: %w[A1 A2])
        create(:custom_fields_value, customizable: user, custom_field: single_select_field, value: 'A1')
      end

      it 'updates user custom fields' do
        expect(result[:model].custom_fields_values)
          .to contain_exactly(have_attributes(value: 1_234_567), have_attributes(value: 'My life 2'),
                              have_attributes(value: %w[A1]))
        expect(result).to be_success
      end
    end
  end

  describe 'Failure' do
    context 'when custom_field_id not exists' do
      let(:custom_fields_values) do
        [
          { custom_field_id: -1, value: 1_234_567 }
        ]
      end
      let(:errors) do
        {
          'custom_fields_values.custom_field_id': ["Custom field does't exists"]
        }
      end

      include_examples 'has validation errors'
    end

    context 'when field type is number' do
      let(:custom_fields_values) do
        [
          { custom_field_id: number_field.id, value: 'some string' }
        ]
      end
      let(:errors) do
        {
          'custom_fields_values.value': ['must be a number']
        }
      end

      include_examples 'has validation errors'
    end

    context 'when field type is single_choice' do
      let(:custom_fields_values) do
        [
          { custom_field_id: single_select_field.id, value: 'best' }
        ]
      end
      let(:errors) do
        {
          'custom_fields_values.value': ['Field value not in the list']
        }
      end

      include_examples 'has validation errors'
    end

    context 'when field type is multiple_choice' do
      context 'when value is not an array' do
        let(:custom_fields_values) do
          [
            { custom_field_id: multiple_select_field.id, value: 'best' }
          ]
        end
        let(:errors) do
          {
            'custom_fields_values.value': ['must be an array']
          }
        end

        include_examples 'has validation errors'
      end

      context 'when value is not in the list' do
        let(:custom_fields_values) do
          [
            { custom_field_id: multiple_select_field.id, value: ['best'] }
          ]
        end
        let(:errors) do
          {
            'custom_fields_values.value': ['Field value not in the list']
          }
        end

        include_examples 'has validation errors'
      end
    end
  end
end
