adduser --disabled-password --gecos "" development
echo "development:dev" | sudo chpasswd


sudo apt-get update
sudo apt-get --assume-yes remove ruby1.8
sudo apt-get --assume-yes install python-software-properties postgresql
sudo apt-add-repository ppa:brightbox/ruby-ng
sudo apt-get update
sudo apt-get --assume-yes install ruby2.2 git curl git-core nginx mc

sudo gem install bundler uglifier
sudo apt-get --assume-yes install ruby2.2-dev libpq-dev make npm

curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
sudo apt-get --assume-yes install -y nodejs
sudo apt-get --assume-yes install -y nodejs
sudo npm install -g bower

sudo -u postgres psql postgres -c 'CREATE USER development;'
sudo -u postgres psql postgres -c 'CREATE DATABASE "ut-arena-api_production";'
sudo -u postgres psql postgres -c 'GRANT ALL PRIVILEGES ON "ut-arena-api_production" TO development'


sudo mkdir -p /home/development/apps/ut-arena/shared/config/
sudo chown -R vagrant /home/development/apps
sudo echo "default: &default
  adapter: postgresql
  encoding: unicode
  pool: 5
production:
  <<: *default
  database: ut-arena-api_production
  username: development
  password: dev
" > /home/development/apps/ut-arena/shared/config/database.yml

sudo echo "production:
  secret_key_base: d9bec8052a146754575a63870a97a3ab03dcda105a88cd49e47172d3fb628cb73be0be88b9e632cd1130499becd340b017b28c8b2ede8c016293230e600$
  secret_token: 77078f2c4d3702540cfa942fbd03ea9fb876040a7f2a011f104e4c204ebc2e172846f50e0e78e2de79d13b2051a63d7c243cf8f413c974770cccec907497f8$
" > /home/development/apps/ut-arena/shared/config/secrets.yml

sudo chown -R development /home/development/apps

sudo rm /etc/nginx/sites-enabled/default
sudo ln -nfs "/home/development/apps/ut-arena/current/config/nginx.conf" "/etc/nginx/sites-enabled/ut-arena"
sudo service nginx restart

sudo reboot
