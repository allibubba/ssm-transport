[![Maintainability](https://api.codeclimate.com/v1/badges/59e344abf0c492121598/maintainability)](https://codeclimate.com/github/allibubba/ssm-transport/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/59e344abf0c492121598/test_coverage)](https://codeclimate.com/github/allibubba/ssm-transport/test_coverage)

# readme

## get credentials 

request credentials locally with [gimme-aws-creds](https://github.com/Nike-Inc/gimme-aws-creds)

select at least two accounts, note the profile names generated in ~/.aws/credentials

run the script by passing in the from profile and the to profile names
```
ruby app.rb <profile-string> <profile-string> <environment-string>
```

## Linting with Rubocop

```
docker run --rm -ti -v <app-directory>/ssm-transport:/usr/src/app ruby:latest rubocop \
--enable-pending-cops
```

## Run tests

```
docker run --rm -ti -v $HOME/tools/ssm-transport:/usr/src/app ruby:latest \
rspec \
--profile 10 \
--color \
--order random \
--format RspecJunitFormatter \
--out test-results/rspec/rspec.xml \
--format progress \
-- spec
```
