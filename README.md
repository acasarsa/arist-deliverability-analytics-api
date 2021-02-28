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
## Run Tests

``` 
bundle install
rake db:create
RAILS_ENV=test rake db:migrate
rspec

```

## Test Endpoints with Postman 
[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/35cf2cc993f6d1f29e89)

### Postman Collection Docs for this API

Since this is a development environment you can access the /devices route to see all the changes you make! The /devices route is also where you'll need to look to get the device_id for your other routes. I ordered the routes in the collection so they can be performed in order without running into an error even if you use the same uuid. NOTE that the **terminate** route will disable a device and therefore using that uuid will throw an error (this is intended). I created a `to_disabled_device` request for the /alive and /report endpoints which should be used for testing requests sent from disabled devices. 

For /alive and /reports routes copy the id's uuid value sans quotes from the /devices route (make sure it's not disabled!) and paste it into the query parmas value for device_id. You'll see a big **INSERT DEVICE ID HERE** so you will know you're in the right place. 

For those not familiar with uuid's it will look like something like this id: `5c4b60ad-f00d-4f89-9725-be16f84ecb9f`

You will do the same for the /terminate PATCH, but I would recommend using a different device_id to avoid any confusion with repeated testing. 

