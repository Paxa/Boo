require "./boo"
require "thin"

require "pp"

new_boo = Boo::Server.new do
  
  mount do
    {
      :root => Boo::File.new(".")
    }
  end
  
  secure :key => "12345"
  
end

pp new_boo

Rack::Handler::Thin.run(new_boo, :Port => 9292)