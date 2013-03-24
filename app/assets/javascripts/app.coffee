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

  $('.edit-link').click ->
    $('.edit_task').hide()
    $('.task-content').show()
    $task = $(@).parents('.task')
    $task.children('.task-content').hide()
    $task.children('.edit_task').show()
    false

  $('.cancel-edit-link').click ->
    $('.edit_task').hide()
    $('.task-content').show()
    false

  $('.set-default-tags').click ->
    $(@).hide()
    $(@).siblings('.edit_user').show()
    false

  $('.cancel-set-default-tags').click ->
    default_tags_form = $(@).parent()
    default_tags_form.hide()
    default_tags_form.siblings('.set-default-tags').show()
    false
