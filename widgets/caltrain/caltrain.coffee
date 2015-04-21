class Dashing.Caltrain extends Dashing.PivotalLifeWidget
  ready: =>
  onData: (snapshot) =>
    departures = {}
    for departure in snapshot.data
      departures[departure.direction] ||= []
      departures[departure.direction].push(departure)
      departures[departure.direction].sort((left,right) ->
        left.minutes - right.minutes
      )

    departures.NB = departures.NB.slice(0, 4)
    departures.SB = departures.SB.slice(0, 4)

    this.set("departures", departures)
