FROM ruby:latest
run apt-get install python3
run curl -O https://bootstrap.pypa.io/get-pip.py
run python3 get-pip.py
run pip install awscli
run pip install --upgrade git+https://github.com/Nike-Inc/gimme-aws-creds.git
run gem install rubocop
run gem install rspec
CMD aws --version
