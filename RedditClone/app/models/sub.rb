class Sub < ApplicationRecord

  validates :moderator, :title, :description, presence: true

  belongs_to :moderator,
  primary_key: :id,
  foreign_key: :moderator_id,
  class_name: :User

end
