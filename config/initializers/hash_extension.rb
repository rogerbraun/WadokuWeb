module HashSubtree
  def subtree(sym)
    res = []
    self.keys.each do |key|
      if key == sym
        res << {key => self[key]}
      else
        if self[key].class == Hash
          self[key].extend(HashSubtree) unless self[key].respond_to?(:subtree)
          res << self[key].subtree(sym)
        elsif self[key].class == Array
          res << self[key].map{|x| x.subtree(sym)}
        end
      end  
    
    end
    res.flatten.compact
  end
end

class Hash
  include HashSubtree
end
