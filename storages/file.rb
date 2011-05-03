require "pathname"

class Boo::File < Boo::Storage
  
  def initialize(root)
    @root = Pathname.new(root)
  end
  
  def get(key)
    if File.directory?(@root + key)
      {:data_type => 'dir', :content => strip_dotes(Dir.entries(@root + key)) }
    elsif File.file?(@root + key)
      {:data_type => 'file', :content => File.open(@root + key, 'r:utf-8', &:read) }
    else
      nil
    end
  end
  
  def put(key, content)
    if content.is_a?(String)
      File.open(@root + key, 'w+:utf-8') { |f| f.write(content) }
      true
    elsif content.is_a?(StringIO)
      File.open(@root + key, 'w+:utf-8') do |f| 
        p 'in parts'
        while part = content.read(1024)
          f.write(part)
        end
      end
      true
    elsif content.is_a?(Array)
      FileUtils.mkdir_p(@root + key)
      true
    end
  end
  
  def delete(key)
    FileUtils.rm_r(@root + key)
    true
  end
  
  def size_of(key)
    File.stat(@root + key).size
  end
  
  def stat(key)
    filestat = File.stat(@root + key)
    {
      :access_time => filestat.atime,
      :create_time => filestat.ctime,
      :modifi_time => filestat.mtime,
      :object_type => filestat.directory? ? 'dir' : 'file',
      :executable  => filestat.executable?,
      :size        => filestat.size
    }
  end
  
  def strip_dotes(list)
    list.select {|f| f != '.' && f != '..'}
  end
  
end