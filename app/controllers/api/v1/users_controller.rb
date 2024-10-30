# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def update
        result = Users::Operation::Update.call(params: params.to_unsafe_hash)

        if result.success?
          render json: UserSerializer.new(result[:model], { include: params[:include] }).serializable_hash, status: :ok
        else
          handle_errors(result)
        end
      end

      private

      def handle_errors(result)
        return head(:not_found) if result[:model].nil?

        render json: { errors: result['contract.default'].errors.messages }, status: :unprocessable_entity
      end
    end
  end
end
