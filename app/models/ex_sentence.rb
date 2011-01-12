class ExSentence < ActiveRecord::Base
  has_and_belongs_to_many :translations,
                          :class_name => "ExSentence",
                          :join_table => "translation_equivalents",
                          :foreign_key => "ex_sentence_id",
                          :association_foreign_key => "translation_id"
end
