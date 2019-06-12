module Admin
  class NotificationsController < Admin::BaseController
    before_action :force_json
    before_action :unread_messages

    def index
      @notifications = Notification.desc.all
    end

    # rubocop:disable Rails/SkipsModelValidations

    def update
      if params_unread
        handle_params_unread_exist
      else
        unread_messages.update_all read_at: Time.zone.now
        return_json
      end
    end

    private

    def unread_messages
      @unread_messages ||= Notification.unread_notification
    end

    def unread_message
      Notification.find_by id: params_unread if params_unread
    end

    def params_unread
      params[:unread]
    end

    def return_json
      render json: {success: true}
    end

    def handle_params_unread_exist
      if params[:unread] == "all"
        Notification.update_all readed: true
        return_json
      else
        unread_message.update_attributes readed: true
      end
    end

    def admin_user
      current_user.admin?
    end
  end
end
