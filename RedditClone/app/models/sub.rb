class Sub < ApplicationRecord

  validates :title, :description, presence: true

  has_many :posts

  belongs_to :moderator,
  primary_key: :id,
  foreign_key: :moderator_id,
  class_name: :User

end
