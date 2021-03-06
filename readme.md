[![Maintainability](https://api.codeclimate.com/v1/badges/59e344abf0c492121598/maintainability)](https://codeclimate.com/github/allibubba/ssm-transport/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/59e344abf0c492121598/test_coverage)](https://codeclimate.com/github/allibubba/ssm-transport/test_coverage)

# About

Copies all SSM parameters from one aws account to another, and performs an environment strip from each key segment.

## Create Local Credentials 

request credentials locally with [gimme-aws-creds](https://github.com/Nike-Inc/gimme-aws-creds)

select at least two accounts, note the profile names generated in ~/.aws/credentials

run the script by passing in the from profile and the to profile names

```
ruby app.rb <from-profile-string> <to-profile-string> <environment-string>
```

## Linting with Rubocop

```
docker run --rm -ti -v <app-directory>/ssm-transport:/usr/src/app ruby:latest rubocop \
--enable-pending-cops
```

## Run Tests

```
docker run --rm -ti -v <app-directory>/ssm-transport:/usr/src/app ruby:latest \
rspec \
--profile 10 \
--color \
--order random \
--format RspecJunitFormatter \
--out test-results/rspec/rspec.xml \
--format progress \
-- spec
```
