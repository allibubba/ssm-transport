# readme

## get credentials 

request credentials locally with [gimme-aws-creds](https://github.com/Nike-Inc/gimme-aws-creds)

select at least two accounts, note the profile names generated in ~/.aws/credentials

run the script by passing in the from profile and the to profile names
```
ruby data_mapper.rb <profile-string> <profile-string>
```

## Linting with Rubocop

```
docker run --rm -ti -v <app-directory>:/usr/src/app ruby:latest rubocop .
```
