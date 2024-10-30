# frozen_string_literal: true

# == Schema Information
#
# Table name: tenants
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tenants_on_name  (name) UNIQUE
#
class Tenant < ApplicationRecord
  has_many :custom_fields, dependent: :destroy
  has_many :users, dependent: :destroy
end
