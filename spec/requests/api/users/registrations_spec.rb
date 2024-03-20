require 'swagger_helper'

RSpec.describe 'api/users/registrations', type: :request do

  path '/api/users/sign_up' do
    post('create registration') do
      consumes 'application/json'

      parameter name: :sign_up_credentials, in: :body, schema: {
        type: :object,
        properties: {
          api_user: {
            type: :object,
            properties: {
              email: { type: :string },
              password: { type: :string },
              password_confirmation: { type: :string }
            },
            required: %w(email password password_confirmation)
          }
        }
      }

      response(201, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end
    end
  end
end
