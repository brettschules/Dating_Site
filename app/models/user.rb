class User < ApplicationRecord
  has_secure_password

  has_many :events, through: :event_users
  has_many :event_users

  before_save { self.email = email.downcase }

  validates :first_name,  presence: true, length: { maximum: 50 }
  validates :last_name,  presence: true, length: { maximum: 50 }
  validates :gender, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                          format: { with: VALID_EMAIL_REGEX },
                          uniqueness: { case_sensitive: false }

  validates :password, length: { minimum: 6 }


  validates :birthday, presence: true

  validate :checkage?


  def checkage?
    if (Time.now.yday < self.birthday.yday)
      unless 18 <= (Time.now.year - self.birthday.year - 1)
        errors.add(:birthday, "User is not over 18")
      end
    else
      unless 18 <= Time.now.year - self.birthday.year
        errors.add(:birthday, "User is not over 18")
      end
    end
  end

  def to_s
    "#{first_name} #{last_name}"
  end


end
