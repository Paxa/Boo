class Boo::Config
  
  def initialize(server, &block)
    @server = server
    instance_eval(&block)
  end
  
  def mount(options = {})
    @server.routes = block_given? ? yield : options
  end
  
  def secure(options)
    @server.secure = options
  end
  
end