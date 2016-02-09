class Book < ActiveRecord::Base
  validates :title, :author, presence: true

  has_many :comments

  def to_s
    title
  end
end