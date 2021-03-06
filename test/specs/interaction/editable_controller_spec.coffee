EditableController = require('../../../src/interaction/editable_controller')

describe 'editableController', ->

  # Helpers
  # -------

  triggerEditableEvent = (eventName, args...) ->
    func = @withContext(this[eventName])
    func.apply(this, args)


  # Spec
  # ----

  beforeEach ->
    { @renderer, @snippetTree } = getInstances('page', 'renderer')

    @editableController = new EditableController(@renderer.renderingContainer)
    @editableController.triggerEditableEvent = triggerEditableEvent
    @editable = @editableController.editable


  describe 'selection event', ->

    beforeEach ->
      @title = test.getTemplate('title').createView()
      @elem = @title.$html[0]


    it 'fires and finds snippet event', ->
      foundSnippet = undefined

      @editableController.selection.add (snippet, element, selection) ->
        foundSnippet = snippet
        expect.element

      @editableController.triggerEditableEvent('selectionChanged', @elem, undefined)
      expect(foundSnippet.model).to.equal(@title.model)


  describe 'enter event', ->

    beforeEach ->
      @title = test.createSnippet('title', 'A')
      @snippetTree.append(@title)


    it 'inserts a second element', ->
      @editableController.insert(@title.createView())
      expect(@snippetTree.toJson().content.length).to.equal(2)


    it 'inserts the default paragraph element', ->
      expect(@snippetTree.design.paragraphSnippet).to.equal('text')
      @editableController.insert(@title.createView())
      expect(@renderer.snippetTree.toJson().content[1].identifier).to.equal('test.text')


    it 'inserts the paragraph snippet defined by the design', ->
      @snippetTree.design.paragraphSnippet = 'title'
      @editableController.insert(@title.createView())
      expect(@renderer.snippetTree.toJson().content[1].identifier).to.equal('test.title')


  describe 'split event', ->

    beforeEach ->
      @title = test.createSnippet('title', 'A')
      @snippetTree.append(@title)

      @before = document.createDocumentFragment()
      @before.appendChild( $('<span>hey</span>')[0] )
      @after = document.createDocumentFragment()
      @after.appendChild( $('<span>there</span>')[0] )


    it 'inserts a second element', ->
      @editableController.split(@title.createView(), 'title', @before, @after)
      content = @snippetTree.toJson().content
      expect(content.length).to.equal(2)
      expect(content[0].content.title).to.equal('<span>hey</span>')
      expect(content[1].content.title).to.equal('<span>there</span>')


