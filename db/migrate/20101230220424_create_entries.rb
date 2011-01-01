class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.integer :wadoku_id
      t.string :romaji
      t.string :writing
      t.string :kana
      t.text :definition

      t.timestamps
    end
  end

  def self.down
    drop_table :entries
  end
end
