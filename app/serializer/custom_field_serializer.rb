# frozen_string_literal: true

class CustomFieldSerializer < ApplicationSerializer
  set_type :custom_field

  attributes :name, :field_type, :options
end
