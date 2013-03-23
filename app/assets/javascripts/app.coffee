jQuery ->
  $('#new_task #task_name').focus()

  $('.delete-link').click ->
    $(@).hide()
    $(@).siblings('.delete-confirmation').show()
    false

  $('.cancel-link').click ->
    delete_confirmation = $(@).parent()
    delete_confirmation.hide()
    delete_confirmation.siblings('.delete-link').show()
    false
