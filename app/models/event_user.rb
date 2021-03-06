class EventUser < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validate :exists?


  def exists?

    if self.event.host_id && EventUser.where(user_id: self.user.id, event_id: self.event.id).any?
      errors.add(:base, "You cannot attend the same event twice")
    end
  end
end
