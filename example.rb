# gem install yajl-ruby
require "./boo"

# gem install ruby-tokyotyrant
# brew install tokyo-tyrant
# ttserver -host 127.0.0.1 -port 1978
require "./storages/tokyo_tyrant"

# gem install memcache-client
# brew install memcached
# memcached -d
require "./storages/memcache"

require "thin"

require "pp"

new_boo = Boo::Server.new do
  
  mount do
    {
      :root => Boo::File.new("."),
      :tmp => Boo::TmpDir.new(),
      :base => Boo::TokyoTyrant.new('127.0.0.1', '1978'),
      :cache => Boo::Memcache.new('localhost', '11211')
    }
  end
  
  secure :key => "12345"
  
end

pp new_boo

Rack::Handler::Thin.run(new_boo, :Port => 9292)