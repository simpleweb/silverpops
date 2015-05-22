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
          expect(response).to be_an_instance_of(String) 
        end
      end

    end
  end

  context "#find_list_member" do
    context "with an email address that does not exist in cheetahmail" do
      it "responds with false" do
        exists = Silverpops.find_list_member(ENV['DATABASE_ID'], Time.now.to_f.to_s + "@simpleweb.co.uk")
        expect(exists).to eq(false)
      end
    end

    context "with a known email address" do
      it "responds with the row" do
        response = Silverpops.find_list_member(ENV['DATABASE_ID'], "tom@simpleweb.co.uk")
        #expect(response).to be_kind_of(Hash)
        #expect(response).to include("id", "properties")
        #expect(response["id"]).to be_kind_of(Integer)
      end

      #context "when additional properties are requested" do
      #  it "responds with the row with additional properties included" do
      #    response = Silverpops.find_list_member("tom@simpleweb.co.uk", "email_address")
      #  #  expect(response).to be_kind_of(Hash)
      #    expect(response).to include("id", "properties")
      #    expect(response["id"]).to be_kind_of(Integer)
      #    expect(response["properties"][0]["propName"]).to eq "email_address"
      #    expect(response["properties"][0]["value"]).to be_kind_of String
      #  end
      #end

    end
  end

  context "#add_list_member" do
    context "with a valid database id" do
      it "succeeds and returns true" do
        data = {
          "Email" => "tom.holder@simpleweb.co.uk",
          "Forename" => "Thomas",
          "Surname" => "Holder"
        }
        response = Silverpops.add_list_member ENV['DATABASE_ID'], data
        expect(response).to eq(true)
      end
    end

  end

end




