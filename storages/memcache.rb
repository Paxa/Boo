require 'memcache'

class Boo::Memcache < Boo::Storage
  
  def initialize(host, port)
    @host = host
    @port = port
  end
  
  def cache
    @cache ||= ::MemCache.new("#{@host}:#{@port}")
  end
  
  def get(key)
    if value = cache.get(key)
      {:data_type => 'string', :content => value }
    else
      nil
    end
  end
  
  def put(key, content)
    cache.set(key, content)
    true
  end
  
  def delete(key)
    cache.delete(key)
    true
  end
  
  def size_of(key)
    cache.get(key).size
  end
  
  def stat(key)
    if value = cache.get(key)
      { :size => value.size, :object_type => 'string' }
    end
  end
  
end