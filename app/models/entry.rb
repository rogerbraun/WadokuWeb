class Entry < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 10
end
