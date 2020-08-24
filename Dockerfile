FROM ruby:latest
WORKDIR /usr/src/app
run apt-get install curl python3 git
run curl -O https://bootstrap.pypa.io/get-pip.py
run python3 get-pip.py
run pip install awscli
run pip install --upgrade git+https://github.com/Nike-Inc/gimme-aws-creds.git
run gem install rubocop
run gem install rspec
run apt-get update
run apt-get install less
CMD aws --version
