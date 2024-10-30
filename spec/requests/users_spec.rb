# frozen_string_literal: true

RSpec.describe 'Users' do
  path '/users/{id}' do
    put 'updates user' do
      tags 'Users'
      consumes 'application/vnd.api+json'
      produces 'application/vnd.api+json'

      parameter name: :id, in: :path, type: :string, description: 'User id'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          name: {
            type: :string,
            description: 'User name'
          },
          custom_fields_values: {
            type: :array,
            items: {
              type: :object,
              properties: {
                required: %w[custom_field_id value],
                custom_field_id: {
                  type: :integer
                },
                value: {
                  type: :string
                }
              }
            }
          }
        },
        required: %w[name]
      }

      let(:user) { create(:user) }
      let(:name) { FFaker::Name.name }
      let(:options) { %w[A1 A2] }
      let(:custom_field) { create(:custom_field, field_type: :multiple_select, options:, tenant: user.tenant) }
      let(:custom_fields_values) { [{ custom_field_id: custom_field.id, value: %w[A1 A2] }] }
      let(:include) { %w[custom_fields_values custom_fields] }
      let(:params) { { name:, custom_fields_values:, include: } }

      before do
        put "/api/v1/users/#{target_id}", params:, as: :json
      end

      response(200, 'Updated') do
        let(:target_id) { user.id }

        it 'returns user_profile' do
          expect(response).to match_json_schema('users/update')
          expect(response).to match_resource_type('user')
          expect(response).to be_ok
        end

        examples 'application/json' => response_schema('users/update')
      end

      response(404, 'Not found') do
        let(:target_id) { 'wrong_id' }

        it 'respond with not found' do
          expect(response).to be_not_found
        end
      end

      response(422, 'Unprocessable Entity') do
        let(:options) { %w[A3 A4] }
        let(:target_id) { user.id }

        it 'renders errors' do
          expect(response).to be_unprocessable
          expect(response).to match_json_schema('users/errors')
        end
      end
    end
  end
end
