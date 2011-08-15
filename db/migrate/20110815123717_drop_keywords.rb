class DropKeywords < ActiveRecord::Migration
  def self.up
    drop_table :keywords
  end

  def self.down
    create_table :keywords do |t|
      t.string :word
      t.integer :entry_id
      
      t.timestamps
    end

    add_index :keywords, :word
  end
end
