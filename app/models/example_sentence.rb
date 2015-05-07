class ExampleSentence < ActiveRecord::Base
  attr_accessible :article_id, :content

  belongs_to :article

  validates :content, presence: true
end
