module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :admin_user

    def connect
      self.admin_user = find_verified_user
    end

    private

    def find_verified_user
      admin_user = env["warden"].user

      return admin_user if admin_user && admin_user.admin?
      reject_unauthorized_connection
    end
  end
end
