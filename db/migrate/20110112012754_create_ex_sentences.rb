class CreateExSentences < ActiveRecord::Migration
  def self.up
    create_table :ex_sentences do |t|
      t.integer :tatoeba_id
      t.string :lang
      t.text :content

      t.timestamps
    end

    create_table :translation_equivalents, :id => false do |t|
      t.integer :ex_sentence_id
      t.integer :translation_id
    end

  end

  def self.down
    drop_table :ex_sentences
    drop_table :translation_equivalents
  end
end
