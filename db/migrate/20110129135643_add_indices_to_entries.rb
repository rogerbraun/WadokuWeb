class AddIndicesToEntries < ActiveRecord::Migration
  def self.up
    add_index :entries, [:romaji, :writing, :kana] 
  end

  def self.down
    remove_index :entries, [:romaji, :writing, :kana] 
  end
end
