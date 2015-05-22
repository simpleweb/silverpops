Silverpop is a mailing campaign manager provided by IBM.

This very simple gem was built to do two things:

1) Check if customers exist on a list (table)

2) Subscribe customers to a list (table)

To use the gem you must configure it like:

    Silverpops.configure do |config|
      config.username = ENV['USERNAME']
      config.password = ENV['PASSWORD']
    end

To run the tests, create a .env file in the root of the project like:

    username=<YOUR_USERNAME>
    password=<YOUR_PASSWORD>

You can run the specs on save with

    guard

or run them manually with

    bundle exec rspec
