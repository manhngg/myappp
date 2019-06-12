class Notification < ApplicationRecord
  scope :unread_notification, ->{where read_at: nil}
  scope :desc, ->{order created_at: :desc}
end
