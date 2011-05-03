require "net/http"
require "rack"
require "yajl"
require 'yajl/json_gem'


class Net::HTTP::SizeOf <  Net::HTTPRequest
  METHOD = 'SIZE_OF'
  REQUEST_HAS_BODY = true
  RESPONSE_HAS_BODY = true
end

module Boo
  class Client
    
    def initialize(host, port)
      @host = host
      @port = port
    end
    
    def connect
      @connect ||= Net::HTTP.start(@host, @port)
      @connect
    end
    
    def get(key)
      auto_reconnect_request do 
        connect.get(key).body
      end
    end
    
    def put(key, content)
      auto_reconnect_request do 
        connect.put(key, Rack::Utils.build_query(:content => content)).body
      end
    end
    
    def size_of(key)
      connect.request(Net::HTTP::SizeOf.new(key, {})).body
    end
    
    def auto_reconnect_request(&block)
      res = ''
      retries = 0
      begin
        res = block.call
      rescue 
        retries += 1
        retries < 3 ? retry : nil
      end
      deserialize(res)
    end
    
    def deserialize(content)
      JSON.parse(content)
    end
  end
end