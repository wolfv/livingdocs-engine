base64Image = require('../../support/test_base64_image')

describe 'Title Snippet', ->

  beforeEach ->
    @title = test.getSnippet('title')


  it 'instantiates from template', ->
    expect(@title).to.exist


  it 'has an identifier', ->
    expect(@title.identifier).to.equal('test.title')


  it 'has an id', ->
    expect(@title.id).to.exist
    expect(@title.id).to.be.a('string')
    expect(@title.id).to.have.length.above(10)


  it 'has no containers', ->
    expect(@title.containers).not.to.exist


  it 'has no next or previous', ->
    expect(@title.next).not.to.exist
    expect(@title.previous).not.to.exist


  it 'has one editable named "title"', ->
    expect(@title.content).to.have.size(1)
    expect(@title.content).to.have.ownProperty('title')


  it 'title editable has no value at the beginning', ->
    expect(@title.content['title']).not.to.exist


  describe '#set()', ->

    it 'sets editable content', ->
      caption = 'Talk to the hand'
      @title.set('title', caption)
      expect(@title.get('title')).to.equal(caption)


describe 'Row Snippet', ->

  beforeEach ->
    @row = test.getSnippet('row')


  it 'has an identifier', ->
    expect(@row.identifier).to.equal('test.row')


  it 'has two containers named main and sidebar', ->
    expect( _.size(@row.containers)).to.equal(2)
    expect(@row.containers).to.have.ownProperty('main')
    expect(@row.containers).to.have.ownProperty('sidebar')


  it 'has no editables or images', ->
    expect(@row.content).not.to.exist


describe 'Container Snippet', ->

  beforeEach ->
    @container = test.getSnippet('container')


  it 'has named its unnamed container to the default', ->
    defaultName = config.directives.container.defaultName
    expect(@container.containers[defaultName]).to.exist


describe 'Image snippet', ->

  beforeEach ->
    @image = test.getSnippet('image')


  it 'has one image', ->
    expect(@image.content).to.have.ownProperty('image')


  it 'sets a base64 image', ->
    @image.directives.get('image').setBase64Image(base64Image)
    expect(@image.directives.get('image').base64Image).to.equal(base64Image)
    expect(@image.get('image')).to.equal(undefined)


  it 'resets a base64 image when the url is set', ->
    @image.directives.get('image').setBase64Image(base64Image)
    @image.set('image', 'http://www.lolcats.com/images/u/12/24/lolcatsdotcompromdate.jpg')
    expect(@image.directives.get('image').base64Image).to.be.undefined
    expect(@image.get('image')).to.equal('http://www.lolcats.com/images/u/12/24/lolcatsdotcompromdate.jpg')


describe 'Hero SnippetModel#style', ->

  beforeEach ->
    @hero = test.getSnippet('hero')


  it 'gets style "Extra Space', ->
    expect(@hero.getStyle('Extra Space')).to.be.undefined


  it 'sets style "Extra Space"', ->
    @hero.setStyle('Extra Space', 'extra-space')
    expect(@hero.styles['Extra Space']).to.equal('extra-space')


  it 'resets style "Extra Space" with "" (empty string)', ->
    @hero.setStyle('Extra Space', 'extra-space')
    @hero.setStyle('Extra Space', '')
    expect(@hero.styles['Extra Space']).to.equal('')


  it 'resets style "Extra Space" with null', ->
    @hero.setStyle('Extra Space', 'extra-space')
    @hero.setStyle('Extra Space', null)
    expect(@hero.styles['Extra Space']).to.be.null

  it 'sets style "Color"', ->
    @hero.setStyle('Color', 'color--blue')
    expect(@hero.styles['Color']).to.equal('color--blue')


  it 'gets previously set style "Extra Space', ->
    @hero.setStyle('Extra Space', 'extra-space')
    expect(@hero.styles['Extra Space']).to.equal('extra-space')


  it 'does not set style "Extra Space" with unknown class', ->
    @hero.setStyle('Extra Space', 'are-you-kidding-me')
    expect(@hero.styles['Extra Space']).to.be.undefined


  it 'does not set unspecified style "Conundrum"', ->
    @hero.setStyle('Conundrum', 'wtf')
    expect(@hero.styles['Conundrum']).to.be.undefined


describe 'Html snippet', ->

  beforeEach ->
    @image = test.getSnippet('html')


  it 'has one html field', ->
    expect(@image.content).to.have.ownProperty('html')


  describe 'with content', ->

    beforeEach ->
      @image.set('html', '<section>text</section>')

    it 'has the html field set in content', ->
      expect(@image.content['html']).to.equal('<section>text</section>')


    it 'can get the content', ->
      expect(@image.get('html')).to.equal('<section>text</section>')

