require "rack"
require "yajl"
require 'yajl/json_gem'

class Boo::Server
  
  attr_accessor :secure, :routes
  
  STATUS = {
    :ok => 200,
    :not_found => 404,
    :exception => 500
  }
  
  def initialize(&block)
    Boo::Config.new(self, &block)
    @router = Boo::Router.new(@routes)
  end
  
  def call(env)
    request = Rack::Request.new(env)
    result = @router.process(request.path) do |resource, path|
      process_request(request, resource, path)
    end
    log_request(request, result)
    result
  end
  
  def process_request(request, resource, path)
    if request.get?
      result = resource.get(path)
      response_with(:ok, result)
    elsif request.put?
      result = resource.put(path, request.params['content'])
      response_with(:ok, result)
    elsif request.delete?
      result = resource.delete(path)
      response_with(:ok, result)
    elsif request.env['REQUEST_METHOD'] == 'SIZE_OF'
      result = resource.size_if(path)
      response_with(:ok, result)
    end
  end
  
  def log_request(request, response)
    puts "#{request.env['REQUEST_METHOD']} -> #{request.path}"
  end
  
  def serialize(content)
    JSON.pretty_generate(content)
  end
  
  def response_with(status, content)
    [
      Boo::Server::STATUS[status],
      {'Content-Type' => 'application/json'},
      serialize(content)
    ]
  end
  
end