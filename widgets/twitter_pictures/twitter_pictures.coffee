class Dashing.TwitterPictures extends Dashing.Widget

  ready: ->
    @currentIndex = 0
    @pictureElem = $(@node).find('.twitter-picture-container')
    @nextPicture()
    @startCarousel()

  deDupUrls: (data) ->
    urls = []
    i = 0
    while i < @get('tweets').length
      if @get('tweets')[i].url in urls
        @get('tweets').splice(i,1)
      else
        urls.push(@get('tweets')[i].url)
        i++

  onData: (data) ->
    @currentIndex = 0
    if data and data.tweets.length > 0
      @set('item', data.tweets[@currentIndex])
      @deDupUrls(data)
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
