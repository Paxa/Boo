require 'tokyo_tyrant'

class Boo::TokyoTyrant < Boo::Storage
  
  def initialize(host, port)
    @host = host
    @port = port
  end
  
  def db
    @db ||= TokyoTyrant::DB.new(@host, @port.to_i)
  end
  
  def get(key)
    if value = db[key]
      {:data_type => 'string', :content => value }
    else
      nil
    end
  end
  
  def put(key, content)
    db[key] = content
    true
  end
  
  def delete(key)
    db.delete(key)
    true
  end
  
  def size_of(key)
    db[key].size
  end
  
  def stat(key)
    if value = db[key]
      { :size => value.size, :object_type => 'string' }
    end
  end
  
end