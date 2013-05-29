# SnippetTree Events
# ------------------
# Check that SnippetTree raises events properly

describe "SnippetTree (Events) ->", ->

  beforeEach ->
    @tree = new SnippetTree()
    @expectSnippetAdded = test.createCallbackMonitor(@tree.snippetAdded)
    @expectSnippetRemoved = test.createCallbackMonitor(@tree.snippetRemoved)
    @expectSnippetMoved = test.createCallbackMonitor(@tree.snippetMoved)


  it "should raise snippetAdded event", ->
    snippet = test.getH1Snippet()

    @expectSnippetRemoved 0, =>
      @expectSnippetMoved 0, =>
        @expectSnippetAdded 1, =>
          @tree.append(snippet)


  describe "SnippetTree with two snippets (Events) ->", ->

    beforeEach ->
      @snippetA = test.getH1Snippet()
      @snippetB = test.getH1Snippet()
      @tree.append(@snippetA).append(@snippetB)


    it "should raise snippetRemoved event", ->
      @expectSnippetAdded 0, =>
        @expectSnippetMoved 0, =>
          @expectSnippetRemoved 1, =>
            @snippetB.remove()

    it "should raise snippetMoved event", ->
      @expectSnippetMoved 2, =>
        @snippetB.up()
        @snippetA.up()

    it "should not raise snippetMoved event if snippet did not move", ->
      @expectSnippetMoved 0, =>
        @snippetA.up()
