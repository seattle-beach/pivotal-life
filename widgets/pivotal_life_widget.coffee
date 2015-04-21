class Dashing.PivotalLifeWidget extends Dashing.Widget
  @accessor 'updatedAtMessage', ->
    if updatedAt = @get('updatedAt')
      timestamp = new Date(updatedAt * 1000)
      updatedTime = moment(timestamp);
      "Last updated at #{updatedTime.format('h:mm A')}"
