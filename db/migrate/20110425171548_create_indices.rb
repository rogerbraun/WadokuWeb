class CreateIndices < ActiveRecord::Migration
  def self.up
    create_table :indices do |t|
      t.string :query

      t.timestamps
    end
  end

  def self.down
    drop_table :indices
  end
end
