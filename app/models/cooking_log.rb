class CookingLog < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :cooked_on, presence: true
end
