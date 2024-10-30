# frozen_string_literal: true

module Users::Contract
  class Update < ApplicationForm
    property :name
    collection :custom_fields_values, form: Users::Contract::CustomFieldsValue, populator: lambda { |options|
      Users::Populator::CustomFieldsValues.new(**options).call
    }

    validation do
      params do
        required(:name).filled(:string)
      end
    end
  end
end
