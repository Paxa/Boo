class Boo::Router
  
  def initialize(map)
    @map = map
  end
  
  def process(q_string, &block)
    parts = q_string.split("/")
    parts.shift if parts.first == ''

    resource = @map
    
    if parts.empty?
      return block.call(@map[:root], "")
    end
    
    while current = parts.shift.to_sym
      if resource[current].is_a?(Hash)
        resource = resource[current]
      elsif resource[current]
        return block.call(resource[current], parts.join("/"))
      elsif resource[:root]
        return block.call(resource[:root], ([current] + parts).join("/"))
      else
        raise Boo::NotFound
      end
    end
  end
  
end