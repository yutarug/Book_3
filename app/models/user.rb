class User < ApplicationRecord
  
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :books, dependent: :destroy
         has_many :favorites, dependent: :destroy
         has_many :post_comments, dependent: :destroy
         attachment :profile_image
         has_many :relationships
         has_many :followings, through: :relationships, source: :follow #うまくいかなかったらsource: :followにする
         has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
         has_many :followers, through: :reverse_of_relationships, source: :user#うまくいかなかったらsource: :userにする

           validates :name,
           length: { minimum: 2, maximum: 20}
           validates :introduction,
           length: { maximum: 50}
         def follow(other_user)
            unless self == other_user
              self.relationships.find_or_create_by(follow_id: other_user.id)
            end
         end
         def unfollow(other_user)
            relationship = self.relationships.find_by(follow_id: other_user.id)
            relationship.destroy if relationship
         end
         def following?(other_user)
            self.followings.include?(other_user)
         end

         def self.search(method,word)
                if method == "1"
                        @users = User.where("name LIKE?","#{word}%")
                elsif method == "2"
                        @users = User.where("name LIKE?","%#{word}")
                elsif method == "3"
                        @users = User.where("#{word}")
                elsif method == "4"
                        @users = User.where("name LIKE?","%#{word}%")
                else
                        @users = User.all
                end
         end
end
