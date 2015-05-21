require 'Silverpops'
require 'redis'

RSpec.describe Silverpops do

  before(:each) do
    #@redis = Redis.new(Silverpops.configuration.redis)
    #@redis.del "Silverpops_access_token"

    Silverpops.configure do |config|
      config.username = ENV["USERNAME"]
      config.password = ENV["PASSWORD"]
      config.server_number = ENV["SERVER_NUMBER"]
      config.proxy = ENV["PROXY"]
    end
  end

  context "#get_token" do
    context "when user is not authenticated" do

      context "trying to authenticate with invalid credentials" do
        it "fails and returns false" do
          Silverpops.configure do |config|
            config.username = "invalid"
            config.password = "invalid"
          end

          response = Silverpops.get_token
          expect(response).to eq(false)
        end
      end

      context "trying to authenticate with valid credentials" do
        it "succeeds and returns true" do
          response = Silverpops.get_token
          expect(response).to eq(true)
        end
      end

    end
  end

end




