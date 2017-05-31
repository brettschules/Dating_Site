class Event < ApplicationRecord
  belongs_to :host, :class_name => User
  has_many :event_users
  has_many :users, through: :event_users
 #has_and_belongs_to_many :users
end
