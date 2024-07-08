![CI](https://github.com/iTechArt-RubyLab/rails_template/actions/workflows/ci.yml/badge.svg)
![Rubocop](https://github.com/iTechArt-RubyLab/rails_template/actions/workflows/rubocop_linter.yml/badge.svg)
![Reek](https://github.com/iTechArt-RubyLab/rails_template/actions/workflows/reek_linter.yml/badge.svg)
![Rails best practices](https://github.com/iTechArt-RubyLab/rails_template/actions/workflows/rails_best_practices_linter.yml/badge.svg)
![Fasterer](https://github.com/iTechArt-RubyLab/rails_template/actions/workflows/fasterer_linter.yml/badge.svg)
![Security](https://github.com/iTechArt-RubyLab/rails_template/actions/workflows/security.yml/badge.svg)

<h1>DESCRIPTION</h1>

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
<br>
<h2>ENV</h2>
When working with the application, please, care to create a .env file in the project root specifying the following:

RACK_ENV\
RAILS_ENV

DB_USER\
DB_PASSWORD\
DB_HOST\
DB_PORT\
DB_DEVELOPMENT_NAME\
DB_TEST_NAME\
DB_NAME\
DB_CONNECT_TIMEOUT

PORT\
RAILS_MAX_THREADS

REDIS_URL

SIDEKIQ_CONCURRENCY\
SIDEKIQ_TIMEOUT_SECONDS

ACTIVE_RECORD_ENCRYPTION_PRIMARY_KEY\
ACTIVE_RECORD_ENCRYPTION_DETERMINISTIC_KEY\
ACTIVE_RECORD_ENCRYPTION_KEY_DERIVATION_SALT

OTP_SECRET_KEY\
OTP_TWO_FACTOR_AUTHENTICATION_ISSUER_NAME

SLACK_API_TOKEN\
SLACK_CHANNEL

TELEGRAM_API_TOKEN\
TELEGRAM_CHAT_ID

GOOGLE_CLIENT_ID\
GOOGLE_CLIENT_SECRET

GITHUB_CLIENT_ID\
GITHUB_CLIENT_SECRET

DEVISE_JWT_SECRET_KEY
<br>
<br>

curl -v -X POST http://localhost:3001/api/users/sign_up -H 'Content-Type: application/json' -H 'Accept: application/json' -d '{"api_user": {"email":"api_user_example@test.com", "password":"123456", "password_confirmation":"123456"}}'

curl -v -X POST http://localhost:3001/api/users/sign_in -H 'Content-Type: application/json' -H 'Accept: application/json' -d '{"api_user": {"email":"api_user_example@test.com", "password":"123456"}}'

curl -v -X DELETE http://localhost:3001/api/users/sign_out -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer XYZ'


curl -X GET 'localhost:3001/api/v1/users' -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer XYZ'

curl -X GET 'localhost:3001/api/v1/users/1' -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer XYZ'

curl -X GET 'localhost:3001/api/v1/current_user' -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer XYZ'
<br>
<h2>AWS | Github Actions</h2>

There's a pipeline set to deploy the template application to AWS using Github Actions. Please, consider reviewing
staging_cd github workflow. 'Staging' naming convention implies volatility of the pipeline and that further discretion from
DevOps team is advised.

Please, set the following secrets under 'Actions secrets and variables' tab.

AWS_ACCESS_KEY_ID\
AWS_REGION\
AWS_SECRET_ACCESS_KEY

EB_APP_NAME\
EB_APP_PACKAGE_S3_BUCKET

STAGING_EB_APP_PACKAGE_S3_KEY_SUBFOLDER\
STAGING_EB_WEB_ENV_NAME

EB stands for Elastic Beanstalk which is the AWS orchestration service that is used to deploy the application. Please, pay
attention to .ebextensions folder that contains some custom Elastic Beanstalk configurations.

Additional Elastic Beanstalk environment variables should contain the following:

BUNDLER_DEPLOYMENT_MODE=TRUE\
BUNDLE_WITHOUT=test:development\
RACK_ENV=staging\
RAILS_ENV=staging
RAILS_SKIP_ASSET_COMPILATION=FALSE\
RAILS_SKIP_MIGRATIONS=FALSE

Some other AWS services needed to deploy the application are VPC, S3, RDS and ElastiCache

Please, notice that the pipeline is only set to deploy Web server tier. Most likely, you will have a need to perform
asynchronous tasks in your application, so a pool of Worker tiers within Elastic Beanstalk service has to be provisioned.
In that case you are to prepare your Elastic Beanstalk Web tier, uncomment 'Deploy new application version to elastic beanstalk staging worker tier' step
and set STAGING_EB_WORKER_ENV_NAME secret.
