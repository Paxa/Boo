require "tmpdir"

class Boo::TmpDir < Boo::File
  
  def initialize()
    @dir = Dir.mktmpdir
    puts "TmpDir at #{@dir}"
    @root = Pathname.new(@dir)
  end

end