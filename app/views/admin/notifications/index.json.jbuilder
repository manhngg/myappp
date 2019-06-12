json.notifications do
  json.array! @notifications do |notify|
    json.id notify.id
    json.content t(notify.content)
    json.url notify.order_url
    json.time notify.created_at.strftime("%H:%M %d/%m/%Y")
    json.readed notify.readed
  end
end

json.unread @unread_messages.size
json.name current_user.name
