require 'faraday'
require 'json'
require 'redis'
require 'nokogiri'

module Silverpops

  class << self
    attr_accessor :configuration
  end

  def self.get_api_base_uri
    return 'http://api' + Silverpops.configuration.server_number.to_s + '.silverpop.com/XMLAPI'
  end

  def self.get_token(clear_cache = false)
    tries ||= 2

    builder = Nokogiri::XML::Builder.new do |xml|
      xml.Envelope {
        xml.Body {
          xml.Login {
            xml.USERNAME Silverpops.configuration.username
            xml.PASSWORD Silverpops.configuration.password
          }
        }
      }
    end

    #conn_options = { ssl: {verify: false} }

    faraday = Faraday.new(:url => get_api_base_uri(), :proxy => Silverpops.configuration.proxy) do |faraday|
      faraday.request :url_encoded
      faraday.adapter  Faraday.default_adapter
    end

    response = faraday.post do |req|
      req.url '/XMLAPI'
      req.headers["Content-Type"] = "text/xml"
      req.headers["Accept"] = "text/xml"
      req.body = builder.to_xml
    end

    if response.status == 200

      doc = Nokogiri::XML(response.body)
      doc.xpath("//Envelope/Body/RESULT/SUCCESS").each do |node|
        return node.content.downcase == "true"
      end

    else
      raise RetryException, response.status.to_s + " " + response.body if response.status == 200
    end

  rescue RetryException => e
    if (tries -= 1) > 0
      retry
    else
      raise e
    end
  end

  def self.find_list_member(email, prop = '', allow_retry_qty = 3)
    
  end

  def self.add_list_member(api_post_id, key_data)

  end

  def self.configuration
    @configuration ||=  Configuration.new
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :username
    attr_accessor :password
    attr_accessor :server_number
    attr_accessor :proxy

    def initialize
      @username = ''
      @password = ''
      @server_number = 1
      @proxy = nil
    end
  end

  class RetryException < RuntimeError
  end

end