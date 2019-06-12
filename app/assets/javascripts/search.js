/* eslint-disable */
/* jshint ignore:start */
document.addEventListener("turbolinks:load", function () {
  $input = $("[data-behavior='autocomplete']")
  var options = {
    url: function (phrase) {
      return "/search.json?q=" + phrase;
    },

    getValue: "name",

    list: {
      onChooseEvent: function () {
        var url = $input.getSelectedItemData().url
        $input.val("")
        window.location = url
      }
    }
  };

  $input.easyAutocomplete(options);
});
/* jshint ignore:end */
