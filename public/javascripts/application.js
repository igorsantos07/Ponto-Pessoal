$(document).ready(function() {


$('table.history.daily td.time').click(function() {
  var $cell = $(this)
  if ($cell.attr('editing')) {
    return;
  }
  else {
    $cell.attr('editing', true)

    var value = $cell.html().trim()
    if (value == '---') return;

    var form    = document.createElement('form'),
        period  = $cell.attr('data-period')
    form.action = '/workday/edit/'+period+'/'+$cell.parent('tr').attr('data-day')
    if (period == 'lunch') {
      var go      = document.createElement('input'),
          back    = document.createElement('input'),
          values  = value.split('~').map(function(v) {return v.trim()})

      go.name = 'go_lunch'; go.type = 'text'; go.value = values[0]
      back.name = 'back_lunch'; back.type = 'text'; back.value = values[1]

      var submit = document.createElement('input'); submit.type = 'submit'; submit.style = 'display: none'
      $(form).append(go).append('~').append(back).append(submit)
      var main_input = go
    }
    else {
      var main_input = document.createElement('input')
      main_input.name = period
      main_input.type = 'text'
      main_input.value = value
      $(form).append(main_input)
    }
    $cell.html('').append(form)
    main_input.focus()
  }
})

$('table.history.daily form').live('submit', function(e) {
  e.preventDefault()
  var $form   = $(this),
      fields  = $form.find('input[type=text]'),
      url     = $form.attr('action')

  var data = {}
  fields.each(function(i, field) {
    data[field.name] = field.value
  })

  $.ajax(url, {
    async: false,
    dataType: 'json',
    type: 'post',
    context: $form,
    data: data,
    success: function(data, status, xhr) {
      var content
      if (data.field == 'lunch')
        content = data.workday.go_lunch+' ~ '+data.workday.back_lunch
      else
        content = data.workday.enter

      $form.parent('td').html(content).removeAttr('editing')
    },
    error: function(xhr, status, error) {
      alert('fuck!')
    }
  })
})


})