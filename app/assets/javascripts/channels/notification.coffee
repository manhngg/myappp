App.notification = App.cable.subscriptions.create "NotificationChannel",
  connected: ->

  disconnected: ->

  received: (data) ->
    request_notification()

$(document).on 'turbolinks:load', ->
  request_notification()

$(document).on 'ready', ->
  $('#notify').on 'click', ->
    $.ajax '/admin/notifications/update',
    type: 'PUT'
    dataType: 'JSON'
    success: () ->
      $('#notify-count').text(0)

request_notification = () ->
  locale = if document.URL.match('/en') then '/en/' else '/vi/'
  $.ajax locale + 'admin/notifications',
  type: 'GET',
  dataType: 'JSON',
  success:(data) ->
    notifications = $.map data.notifications, (notify) ->
      if notify.readed is true
        "<li class='notification-item'>
          <a class='notification-anchor' href=#{notify.url}>
            <p class='notification-user'>
              <strong>#{data.name}</strong> |
              <span class='timestamp'>#{notify.time}</span>
            </p>
            <p class='notification-type'>
              #{notify.content}
            </p>
          </a>
        </li>"
      else
        "<li class='notification-item unread'>
          <a class='notification-anchor' href=#{notify.url} id=#{notify.id}>
            <p class='notification-user'>
              <strong>#{data.name}</strong> |
              <span class='timestamp'>#{notify.time}</span>
            </p>
            <p class='notification-type'>
              #{notify.content}
            </p>
          </a>
        </li>"
    $('#notify-count').text(data.unread)
    $('#notify-list').html(notifications)
