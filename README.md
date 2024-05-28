![CI](https://github.com/iTechArt-RubyLab/rails_template/actions/workflows/ci.yml/badge.svg)
![Rubocop](https://github.com/iTechArt-RubyLab/rails_template/actions/workflows/rubocop_linter.yml/badge.svg)
![Reek](https://github.com/iTechArt-RubyLab/rails_template/actions/workflows/reek_linter.yml/badge.svg)
![Rails best practices](https://github.com/iTechArt-RubyLab/rails_template/actions/workflows/rails_best_practices_linter.yml/badge.svg)
![Fasterer](https://github.com/iTechArt-RubyLab/rails_template/actions/workflows/fasterer_linter.yml/badge.svg)
![Security](https://github.com/iTechArt-RubyLab/rails_template/actions/workflows/security.yml/badge.svg)

# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

curl -v -X POST http://localhost:3001/api/users/sign_up -H 'Content-Type: application/json' -H 'Accept: application/json' -d '{"api_user": {"email":"api_user_example@test.com", "password":"123456", "password_confirmation":"123456"}}'

curl -v -X POST http://localhost:3001/api/users/sign_in -H 'Content-Type: application/json' -H 'Accept: application/json' -d '{"api_user": {"email":"api_user_example@test.com", "password":"123456"}}'

curl -v -X DELETE http://localhost:3001/api/users/sign_out -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer XYZ'


curl -X GET 'localhost:3001/api/v1/users' -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer XYZ'

curl -X GET 'localhost:3001/api/v1/users/1' -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer XYZ'

curl -X GET 'localhost:3001/api/v1/current_user' -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer XYZ'
