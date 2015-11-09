describe("Twitter widget", =>
  pictures = undefined

  beforeEach(=>
    pictures = new Dashing.TwitterPictures()
  )

  it("displays correct image url when tweets exist", =>
    setDataOnWidget(pictures, {tweets: [{
      'url': 'https://upload.wikimedia.org/wikipedia/en/b/bd/GoPivotal_logo.png',
      'hashtag': 'pivotallife',
      'user_name': 'aaravindan'
    }]})
    expect(pictures.get("tweets").length).toEqual(1)
    expect(pictures.get("item")).not.toBeUndefined()
    expect(pictures.get("item").url).toEqual('https://upload.wikimedia.org/wikipedia/en/b/bd/GoPivotal_logo.png')
  )

  it("displays placeholder image when no tweets found", =>
    setDataOnWidget(pictures, {tweets: []})
    expect(pictures.get("tweets").length).toEqual(0)
    expect(pictures.get("item")).not.toBeUndefined()
    expect(pictures.get("item").url).toEqual('/assets/pivotal_squirrel.png')
  )

  it("skips retweeted images", =>
    setDataOnWidget(pictures, {tweets: [{
      'url': 'https://upload.wikimedia.org/wikipedia/en/b/bd/GoPivotal_logo.png',
      'hashtag': 'pivotallife',
      'user_name': 'djoyahoy'
    },
    {
      'url': 'https://upload.wikimedia.org/wikipedia/en/b/bd/GoPivotal_logo.png',
      'hashtag': 'pivotallife',
      'user_name': 'aaravindan'
    },
    {
      'url': 'https://plugins.cloudfoundry.org/ui/images/cloud-foundry-logo.png',
      'hashtag': 'pivotallife',
      'user_name': 'aaravindan'
    }]})
    expect(pictures.get("tweets").length).toEqual(2)
    expect(pictures.get("tweets")[0].url).toEqual('https://upload.wikimedia.org/wikipedia/en/b/bd/GoPivotal_logo.png')
    expect(pictures.get("tweets")[1].url).toEqual('https://plugins.cloudfoundry.org/ui/images/cloud-foundry-logo.png')
  )
)
