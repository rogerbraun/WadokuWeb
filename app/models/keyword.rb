class Keyword < ActiveRecord::Base
  
  belongs_to :entry 

  def method_missing(m, *args, &block)
    entry.send(m, *args, &block)
  end
end
