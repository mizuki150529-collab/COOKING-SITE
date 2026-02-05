class Post < ApplicationRecord
  belongs_to :user

  #tweetsテーブルから中間テーブルに対する関連付け
  has_many :post_tag_relations, dependent: :destroy
  #tweetsテーブルから中間テーブルを介してTagsテーブルへの関連付け
  has_many :posts, through: :post_tag_relations, dependent: :destroy
  has_many :cooking_logs, dependent: :destroy
  has_one_attached :image
end
