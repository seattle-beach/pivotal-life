class Dashing.PivotFaces extends Dashing.Widget

  ready: =>
    @randomOrNewPivot = 1
    @currentNewFaceIdx = 0
    @currentRandomFaceIdx = -1
    setInterval(@rotate, 10000)


  onData: (data) =>
    @set('item', data.new_faces[0])

  rotate: =>
    @swapRandomFace()

    @randomOrNewPivot++

  swapRandomFace: ->
    @currentRandomFaceIdx = ((@currentRandomFaceIdx + 1) % @get('random_faces').length)
    @set('item', @get('random_faces')[@currentRandomFaceIdx])

