$(function(){
  
  $('form a.remove_nested_fields').live('click', function() {
    var hidden_field = $(this).prev('input[type=hidden]')[0];
    if(hidden_field) {
     hidden_field.value = '1';
     $(this).closest('.form-row').hide(); 
    } else {
      $(this).closest('.form-row').remove();      
    }
    return false;
  });

});