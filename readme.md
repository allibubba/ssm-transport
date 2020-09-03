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
docker run --rm -ti -v <app-directory>/ssm-transport:/usr/src/app ruby:latest rubocop --enable-pending-cops
```
