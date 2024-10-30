# frozen_string_literal: true

module Users::Populator
  class CustomFieldsValues
    def initialize(fragment:, collection:, **)
      @fragment = fragment
      @custom_fields_values = collection
    end

    def call
      return custom_fields_values.append(build_item) unless item
      return item unless ActiveRecord::Type::Boolean.new.cast(fragment[:_destroy])

      custom_fields_values.delete(item)
      Representable::Pipeline::Stop
    end

    private

    attr_reader :custom_fields_values, :fragment, :form

    def build_item
      ::CustomFieldsValue.new(custom_field_id: fragment[:custom_field_id])
    end

    def item
      @item ||= custom_fields_values.find do |member|
        member.custom_field_id == fragment[:custom_field_id]
      end
    end
  end
end
