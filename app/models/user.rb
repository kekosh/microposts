class User < ActiveRecord::Base
  #コールバック(保存前に処理を実行)
  before_save { self.email = self.email.downcase }
  
  validates :name, presence: true, length:{maximum:50}
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length:{maximum:255},
                    format:{ with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
                    
  has_secure_password
  
  validates :address, length: { minimum: 3, maximum: 100 },
                      allow_blank: true, on: :update
                      
  validates :age, numericality: {
            only_integer: true, greater_than_or_equal_to: 1,
            less_than: 120 }, allow_blank: true, on: :update
            
  validates :remarks, length: { minimum: 2, maximum: 200 },
                      allow_blank: true, on: :update
                      
  #id一つに付き複数のデータと紐づく。
  has_many :microposts
  
  has_many :following_relationships, class_name: "Relationship",
                                    foreign_key: "follower_id",
                                    dependent: :destroy
                                    
  has_many :following_users, through: :following_relationships, source: :followed
  
  has_many :follower_relationships, class_name: "Relationship",
                                    foreign_key: "followed_id",
                                    dependent: :destroy
  
  has_many :follower_users, through: :follower_relationships, source: :follower
  
  #ユーザーを検索し、未フォローの場合はフォローを追加する
  def follow(other_user)
    following_relationships.find_or_create_by(followed_id: other_user.id)
  end
  
  #フォローしているユーザーならば削除する
  def unfollow(other_user)
    following_relationship = following_relationships.find_by(followed_id: other_user.id)
    following_relationship.destroy if following_relationship
  end
  
  #ユーザーをフォローしているか確認
  def following?(other_user)
    following_users.include?(other_user)
  end
end
