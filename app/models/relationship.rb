class Relationship < ActiveRecord::Base
  #実体のない仮想的なテーブル(モデル)
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
end
