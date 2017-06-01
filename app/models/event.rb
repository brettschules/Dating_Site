class Event < ApplicationRecord
  belongs_to :host, :class_name => User
  has_many :event_users
  has_many :users, through: :event_users
 #has_and_belongs_to_many :users
#name, location, date, category, description, image_url
 validates :name, presence: true
 validates :date, presence: true
 validates :location, presence: true
 validates :category, presence: true
 validates :description, presence: true
 validates :host_id, presence: true
 
end
