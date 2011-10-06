// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :default
//

$(window).scroll(function() {
  if ($(window).scrollTop() == $(document).height() - $(window).height()) {
    loadNewEntries();
  }
});

function loadNewEntries() {
  last_result = $(".results:last");
  next_page = last_result.data("next-page");
  
  if (next_page.indexOf("none") == -1) { 
    $("<div/>").load(next_page + " .results" , function() {
    last_result.after($(this).children());
    });
  }
}
