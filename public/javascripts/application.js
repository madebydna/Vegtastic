function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
}

function add_fields(link, association) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  //$(link).parent().before(content.replace(regexp, new_id));
  $(link).before(nested_form.replace(regexp, new_id) );
}

$(function(){
  $('form a.remove_nested_fields').live('click', function() {
    var hidden_field = $(this).prev('input[type=hidden]')[0];
    if(hidden_field) {
      hidden_field.value = '1';
    }
    $(this).closest('.fields').remove();
    return false;
  });

});