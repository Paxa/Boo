module Boo
  class NotImplimented < Exception
    
  end
  
  class NotFound < Exception
    
  end
  
  def self.init(&block)
    
    new Boo::Server
    
  end
end

require "./storage"
require "./storages/file"
require "./storages/tmp_dir"

require "./config"
require "./router"
require "./server"