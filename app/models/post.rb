class Post < ApplicationRecord
  belongs_to :user

  #tweetsテーブルから中間テーブルに対する関連付け
  has_many :cooking_logs, dependent: :destroy
  has_one_attached :image
end
