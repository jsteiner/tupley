jQuery ->
  $('#new_task #task_name').focus()

  $('#flash div').delay(2000).fadeOut 2000, ->
    $(@).remove()

  $('.delete-link').click ->
    $(@).hide()
    $(@).siblings('.delete-confirmation').show()
    false

  $('.cancel-link').click ->
    delete_confirmation = $(@).parent()
    delete_confirmation.hide()
    delete_confirmation.siblings('.delete-link').show()
    false

  $('.destroy-link').click ->
    $destroyLink = @
    $(@).parents('.task').fadeOut 300, ->
      $.ajax
        url: $destroyLink.href
        type: 'delete'
        success: =>
          $(@).remove()
        error: ->
          $errorMessage = $('<div id="flash_error">')
          $errorMessage.text('Task failed to delete. Refresh the page and try again.')
          $('#flash').append $errorMessage
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
