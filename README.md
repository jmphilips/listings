# How to run this application

1. Clone the repo down to your local machine
2. `cd` into the repo
3. Run the command `bundle install` to install all of the dependencies.
4. Run the command `rails db:setup` to setup and seed the local database.
5. Run the command `rails s` to start up the server.
6. Run `bundle exec rspec` to run the test suite.

### Notes about design decisions.
1. I used `Active Model Serializers` as the spec did not include the id field in the example response.
2. I included request specs in order to test out the responses.  I used `rspec` and the tests are in the `/spec` folder