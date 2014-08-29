class Dashing.TwitterPictures extends Dashing.Widget

  ready: ->
    @currentIndex = 0
    @pictureElem = $(@node).find('.twitter-picture-container')
    @nextPicture()
    @startCarousel()

  onData: (data) ->
    @currentIndex = 0
    @set('item', data.tweets[@currentIndex])

  startCarousel: ->
    setInterval(@nextPicture, 8000)

  nextPicture: =>
    tweets = @get('tweets')
    if tweets
      @pictureElem.fadeOut =>
        @currentIndex = (@currentIndex + 1) % tweets.length
        @set 'item', tweets[@currentIndex]
        @pictureElem.fadeIn()


