![CI](https://github.com/iTechArt-RubyLab/rails_template/actions/workflows/ci.yml/badge.svg)
![Rubocop](https://github.com/iTechArt-RubyLab/rails_template/actions/workflows/rubocop_linter.yml/badge.svg)
![Reek](https://github.com/iTechArt-RubyLab/rails_template/actions/workflows/reek_linter.yml/badge.svg)
![Rails best practices](https://github.com/iTechArt-RubyLab/rails_template/actions/workflows/rails_best_practices_linter.yml/badge.svg)
![Fasterer](https://github.com/iTechArt-RubyLab/rails_template/actions/workflows/fasterer_linter.yml/badge.svg)
![Security](https://github.com/iTechArt-RubyLab/rails_template/actions/workflows/security.yml/badge.svg)

# README

Rails Template is a base skeleton Ruby On Rails project with extensibility and best practises concepts in mind. It is served as a starter project for potentially any new RoR application. Only essentials  are included so that a developer not bound to reverting bulk parts of code.

Combat proven Puma server is used for parallelism.

PostgreSQL with performance dashboard and most popular gems to work with migrations, bulk importing, views is served as persistence layer.

Authentication is grounded on Devise gem and includes omniauth, two factor and JWT possibilities. Roles and authorization strategies are covered.

Background jobs are processed by Sidekiq utilizing an in-memory Redis DB soultion. A bunch of useful extensions such as Cron, job status, uniqueness, throttling and failures are includes with examples.

Exceptions and notifications are manged by Honeybadger and Slack.

Most popular parsers, formatters and serialization libs are bundled.

Typical RoR tasks might include using of state machine, files upload, mailing, pagination, models auditing, versioning and soft delete. All theses are covered.

OpenAPI (Swagger spec.) is used for describing RESTful APIs with examples.

There are some popular gems for detecting security vulnerabilities, patch-level verification to keep the project dependencies up to date, most popular linters for code smells and performance for both plain Ruby and Rails. Some convenient REPLs are at disposal as well. 

Testing is heavily based on RSpec.

Live and configured CI / CD is presently performed by GitHub Actions and AWS. There are currently some workflows to test and lint the project. Once done, it can be automatically deployed to AWS Elastic Beanstalk using modern Linux 2 instances.


curl -v -X POST http://localhost:3001/api/users/sign_up -H 'Content-Type: application/json' -H 'Accept: application/json' -d '{"api_user": {"email":"api_user_example@test.com", "password":"123456", "password_confirmation":"123456"}}'

curl -v -X POST http://localhost:3001/api/users/sign_in -H 'Content-Type: application/json' -H 'Accept: application/json' -d '{"api_user": {"email":"api_user_example@test.com", "password":"123456"}}'

curl -v -X DELETE http://localhost:3001/api/users/sign_out -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer XYZ'


curl -X GET 'localhost:3001/api/v1/users' -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer XYZ'

curl -X GET 'localhost:3001/api/v1/users/1' -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer XYZ'

curl -X GET 'localhost:3001/api/v1/current_user' -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer XYZ'
