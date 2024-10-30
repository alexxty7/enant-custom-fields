# frozen_string_literal: true

module Users::Operation
  class Update < Trailblazer::Operation
    step Model::Find(User, find_by: :id)
    step Contract::Build(constant: Users::Contract::Update)
    step Contract::Validate()
    step Contract::Persist()
  end
end
