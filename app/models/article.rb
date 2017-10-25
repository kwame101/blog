class Article < ApplicationRecord
  #relationship between comment model - an article to have one to many comments
  has_many :comments, dependent: :destroy

  #-check to see if title has a more than or equal
  #-to 5 letters
  validates :title, presence: true,
                    length: {
                      minimum:5
                    }
end
