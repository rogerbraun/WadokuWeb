// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :default
//

$(window).scroll(function() {
  if ($(window).scrollTop() > ($(document).height() - $(window).height()) - 100) {
    loadNewEntries();
  }
});

function loadNewEntries() {
  if($(".loader").size() == 0) {
    last_result = $(".results:last");
    next_page = last_result.data("next-page");
    image = $("<img class='loader' src='/images/ajax-loader.gif' />")
    
    if (next_page.indexOf("none") == -1) { 
      last_result.after(image);
      $("<div/>").load(next_page + " .results" , function() {
      last_result.after($(this).children());
      $(".loader").remove();
      });
    }
  }
}
