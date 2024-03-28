require 'swagger_helper'

RSpec.describe 'api/users/sessions', type: :request do

  path '/api/users/sign_in' do
    post('create session') do
      consumes 'application/json'

      parameter name: :sign_in_credentials, in: :body, schema: {
        type: :object,
        properties: {
          api_user: {
            type: :object,
            properties: {
              email: { type: :string },
              password: { type: :string }
            },
            required: %w(email password)
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

  path '/api/users/sign_out' do
    delete('delete session') do
      security [{ BearerAuth: [] }]

      response(200, 'successful') do
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
