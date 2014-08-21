class Dashing.TwitterPictures extends Dashing.Widget

  ready: ->
    @currentIndex = 0
    @pictureElem = $(@node).find('.twitter-picture-container')
    @nextPicture()
    @startCarousel()

  onData: (data) ->
    @currentIndex = 0

  startCarousel: ->
    setInterval(@nextPicture, 8000)

  nextPicture: =>
    urls = @get('urls')
    if urls
      @pictureElem.fadeOut =>
        @currentIndex = (@currentIndex + 1) % urls.length
        @set 'url', urls[@currentIndex]
        @pictureElem.fadeIn()


