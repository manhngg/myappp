document.addEventListener('turbolinks:load', function () {
  $('#notify').on('click', function() {
    $.ajax({
      url: '/admin/notifications/update',
      type: 'PUT',
      dataType: 'JSON',
      success: function() {
        $('#notify-count').text(0);
      }
    });
  });

  $('#search').on('keydown', function (e) {
    var search_input = $('#text_input').val();
    if (e.keyCode == 13 && search_input.length === 0) {
      e.preventDefault();
    }
  });

  $('#coupon-input').on('keyup', function(e) {
    var get_coupon_input = $('#coupon-input').val();
    var locale;

    if (get_coupon_input.length !== 0 && e.keyCode == 13) {
      var current_url = document.URL;
      locale = current_url.match('/vi/') ? '/vi/' : '/en';
      $.ajax({
        url: locale + '/discounts/' + get_coupon_input,
        method: 'PUT',
        dataType: 'JSON',
        success: function() {
          location.reload();
        },
        error: function(){
          location.reload();
          $('#alert').removeClass('hidden');
        }
      });
    }
  });

  $('#discount').on('click', function () {
    var get_coupon_input = $('#coupon-input').val();
    var locale;

    if (get_coupon_input.length !== 0) {
      var current_url = document.URL;
      locale = current_url.match('/vi/') ? '/vi/' : '/en';
      $.ajax({
        url: locale + '/discounts/' + get_coupon_input,
        method: 'PUT',
        dataType: 'JSON',
        success: function () {
          location.reload();
        },
        error: function () {
          location.reload();
          $('#alert').removeClass('hidden');
        }
      });
    }
  });
});
