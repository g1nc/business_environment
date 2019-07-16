# README

* update dataabase.yml
* run rake db:create
* run rake db:seed

Routes:

* GET /users - list of user with balance
* GET /users/:id - list of specified user's operations
* PUT /users/:id - update user balance with json body (ex. { "amount": 100 })
