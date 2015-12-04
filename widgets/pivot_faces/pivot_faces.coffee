class Dashing.PivotFaces extends Dashing.Widget

  ready: =>
    @currentRandomFaceIdx = 0
    setInterval(@rotate, 10000)


  onData: (data) =>
    #console.log(data.random_faces)
    @set('item', data.random_faces[0])

  rotate: =>
    @swapRandomFace()

  swapRandomFace: ->
    @currentRandomFaceIdx = ((@currentRandomFaceIdx + 1) % @get('random_faces').length)
    @set('item', @get('random_faces')[@currentRandomFaceIdx])

