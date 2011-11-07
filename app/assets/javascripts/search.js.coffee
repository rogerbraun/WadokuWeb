$(".sub_entry_toggle").live "click", (event) -> 
  he_id = $(this).data("he-id")
  sub_entries = $(".sub_entries.he-id" + he_id)
  sub_entries.toggle() 
  return false
  
