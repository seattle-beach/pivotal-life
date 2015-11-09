class Dashing.TwitterPictures extends Dashing.Widget

  ready: ->
    @currentIndex = 0
    @pictureElem = $(@node).find('.twitter-picture-container')
    @nextPicture()
    @startCarousel()

  onData: (data) ->
    @currentIndex = 0
    if data and data.tweets.length > 0
      @set('item', data.tweets[@currentIndex])
    else
      placeholder = {
        'url': '/assets/pivotal_squirrel.png',
        'hashtag': 'pivotallife',
        'user_name': 'pivotal'
      }
      @set 'item', placeholder

  startCarousel: ->
    setInterval(@nextPicture, 8000)

  nextPicture: =>
    tweets = @get('tweets')
    if tweets and tweets.length > 0
      @pictureElem.fadeOut =>
        @currentIndex = (@currentIndex + 1) % tweets.length
        @set 'item', tweets[@currentIndex]
        @pictureElem.fadeIn()
