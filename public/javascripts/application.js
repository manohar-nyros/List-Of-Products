$(function () {
  $('#lists th a, #lists .pagination ul li a').on('click',
    function () {
      $.getScript(this.href);
      return false;
    }
  );

$("#lists_search input").submit(function() {
    $.get($("#lists_search").attr("action"), $("#lists_search").serialize(), null, "script");
    return false;
  });
});