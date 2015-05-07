class CreateExampleSentences < ActiveRecord::Migration
  def change
    create_table :example_sentences do |t|
      t.text :content
      t.integer :article_id

      t.timestamps
    end
  end
end
