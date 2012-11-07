window.remove_fields = (link) ->
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide().next().show();
  $(link).trigger("fields:removed")

window.add_fields = (link, is_collection, association, content) ->
  new_id = new Date().getTime();
  regexp = new RegExp("@new_" + association + "@", "g");
  $(link).before(content.replace(regexp, new_id));
  $(link).trigger("fields:added")
  if !is_collection
    $(link).hide()