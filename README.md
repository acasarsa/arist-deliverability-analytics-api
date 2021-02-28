# Code Challenge - Deliverablity Analytics API

## System Requirements
- [Git](https://git-scm.com/) 2.19.2
- [Rails](https://github.com/rails/rails) 6.1.3
- [Ruby](https://github.com/ruby/ruby) 2.5.8

## Setup 
```
git clone https://github.com/acasarsa/arist-deliverability-analytics-api.git
cd arist-deliverability-analytics-api
```
Once in the directory you can 
```
bundle install
rake db:create
rake db:migrate
rails s
```

## Test Endpoints with Postman 
[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/35cf2cc993f6d1f29e89)
Run the register_device POST request then use the device.id to send POST requests to 
