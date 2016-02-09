class Comment < ActiveRecord::Base
  validates :user_id, :book_id, :text, presence: true

  belongs_to :user
  belongs_to :book

  def created_at_for_display
    created_at.strftime("%Y-%m-%d %H:%M")
  end
end