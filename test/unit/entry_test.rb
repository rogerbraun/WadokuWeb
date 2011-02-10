require 'test_helper'

class EntryTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "All Entries should parse" do
    Entry.all.each do |entry| 
      assert_true entry.parse
    end
  end
end
