class Post < ApplicationRecord
  validates :title, :content, presence: true

  belongs_to :sub

  belongs_to :author,
  primary_key: :id,
  foreign_key: :author_id,
  class_name: :User

end
