# frozen_string_literal: true

module Users::Contract
  class CustomFieldsValue < ApplicationForm
    property :value
    property :custom_field_id
    property :custom_field

    validation do
      option :form

      params do
        optional(:value)
        required(:custom_field_id).filled(:integer)
      end

      rule(:custom_field_id) do
        key.failure(:custom_field_exists?) if custom_field.blank?
      end

      rule(:value) do
        next unless value && custom_field

        key.failure(:number?) if custom_field.number? && !value.is_a?(Numeric)
        key.failure(:valid_choice?) if custom_field.single_select? && custom_field.options.exclude?(value)

        if custom_field.multiple_select?
          next key.failure(:array?) unless value.is_a?(Array)

          key.failure(:valid_choice?) unless custom_field.options & value == value
        end
      end

      def custom_field
        @custom_field ||= form.model.custom_field
      end
    end
  end
end
