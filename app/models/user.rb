class User < ApplicationRecord
  has_secure_password

  has_many :event_users
  has_many :events, through: :event_users

  has_many :likes, class_name: "Match", foreign_key: :likes_id
  has_many :liked, class_name: "Match", foreign_key: :liked_id

  #has_and_belongs_to_many :events
  #wont need above lines with this code
  #can also delete event_user model with this. Table should be named "events_users" plural and plural

  before_save { self.email = email.downcase }

  validates :first_name,  presence: true, length: { maximum: 50 }
  validates :last_name,  presence: true, length: { maximum: 50 }

  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # validates :email, presence: true, length: { maximum: 255 },
  #                         format: { with: VALID_EMAIL_REGEX },
  #                         uniqueness: { case_sensitive: false }

  validates :password, length: { minimum: 6 }


  validates :birthday, presence: true

  validate :checkage?

  validate :gendercheck

  def gendercheck
    unless self.mgender == true || self.fgender == true|| self.qgender == true
      errors.add(:base, "Please Specify a Gender")
    end
  end

  def checkage?
    if self.birthday
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
  end

  def to_s
    "#{first_name} #{last_name}"
  end

  def gender
    if mgender == true && fgender == true
      "Trans"
    elsif mgender == true
      "Male"
    elsif fgender == true
      "Female"
    elsif qgender == true
      "Non-binary"
    end
  end

  def age
    if Time.now.yday < self.birthday.yday
      Time.now.year - self.birthday.year - 1
    else
      Time.now.year - self.birthday.year
    end
  end

  def feet_height
    if self.height
      feet = self.height/12
      inches = self.height%12
      "#{feet}'#{inches}"
    end
  end


end
