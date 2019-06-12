$(document).ready(function() {
  $(document).on('click', '.unread', function() {
    var id = $(this).children(0).attr('id');
    $.ajax({
      url: '/admin/notifications/update',
      data: {'unread': id},
      method: 'PUT',
      dataType: 'JSON',
    });
  });
});

document.addEventListener('turbolinks:load', function () {
  $('#mark').on('click', function (e) {
    e.stopPropagation();
    $.ajax({
      url: '/admin/notifications/update',
      data: {'unread': 'all'},
      method: 'PUT',
      dataType: 'JSON',
      success: function () {
        $('.notification-item').removeClass('unread');
      }
    });
  });
});
