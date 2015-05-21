Silverpop is a mailing campaign manager.

This very simple gem was built to do two things:

1) Check if customers exist on a list (table)
2) Subscribe customers to a list (table)

The library implements their attempt at OAuth(!) and uses Redis to cache the access_token.

To use the gem you must configure it like:

    Silverpops.configure do |config|
      config.silverpop_client_id = ENV['SILVERPOP_CLIENT_ID']
      config.silverpop_client_secret = ENV['SILVERPOP_CLIENT_SECRET']
    end

To run the tests, create a .env file in the root of the project like:

    SILVERPOP_CLIENT_ID=<YOUR_API_USERNAME>
    SILVERPOP_CLIENT_SECRET=<YOUR_API_PASSWORD>

You can run the specs on save with

    guard

or run them manually with

    bundle exec rspec
