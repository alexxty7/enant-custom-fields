# frozen_string_literal: true

class UserSerializer < ApplicationSerializer
  set_type :user

  attributes :name

  has_many :custom_fields_values, serializer: CustomFieldsValueSerializer
  has_many :custom_fields, serializer: CustomFieldSerializer
end
