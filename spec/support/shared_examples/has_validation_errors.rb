# frozen_string_literal: true

RSpec.shared_examples 'has validation errors' do
  it 'has validation errors' do
    error_messages = result['contract.default'].errors.messages

    expect(result).to be_failure
    expect(error_messages).to match(errors)
  end
end
