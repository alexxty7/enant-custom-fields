# frozen_string_literal: true

require 'reform/form/dry'
require 'reform/form/coercion'

class ApplicationForm < Reform::Form
  include Reform::Form::Dry
  feature Reform::Form::Dry
  feature Reform::Form::Coercion
end
