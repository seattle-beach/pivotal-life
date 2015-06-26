class Dashing.PivotTexts extends Dashing.Widget
  ready: =>
    @currentRandomMessageIdx = 0
    setInterval(@rotate, 8000)
    @rotate()

  onData: (data) =>
    @set('phoneNumberForTextMessages', data.phone_number_for_text_messages)
    @rotate()

  rotate: =>
    @currentRandomMessageIdx = ((@currentRandomMessageIdx + 1) % @get('pivot_texts').length)
    @set('item', @get('pivot_texts')[@currentRandomMessageIdx])
