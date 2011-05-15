class CreateKeywords < ActiveRecord::Migration
  def self.up
    create_table :keywords do |t|
      t.string :word
      t.integer :entry_id
      
      t.timestamps
    end

    add_index :keywords, :word
  end

  def self.down
    drop_table :keywords
  end
end
