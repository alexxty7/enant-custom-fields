# frozen_string_literal: true

class CustomFieldsValueSerializer < ApplicationSerializer
  set_type :custom_fields_value

  attributes :value
end
