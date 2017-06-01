class Match < ApplicationRecord
  belongs_to :liked, class_name: "User"
  belongs_to :likes, class_name: "User"
end
