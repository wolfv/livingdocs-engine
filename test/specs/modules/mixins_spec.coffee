mixins = require('../../../src/modules/mixins')

describe "mixins util", ->

  beforeEach ->
    @Indestructible =
      destroy: ->
        "nope"


  it "returns a function with a prototype", ->
    mixinClass = mixins @Indestructible
    expect( $.isFunction(mixinClass) ).to.be.true
    expect( mixinClass::destroy ).to.exist


  it "generally works", ->

    # class witch uses the mixin
    class Superhero extends mixins @Indestructible

      attackWithLaserbeam: ->
        @destroy()

    rudolf = new Superhero()
    expect( rudolf ).to.exist
    expect( rudolf.destroy ).to.exist
    expect( rudolf.attackWithLaserbeam() ).to.equal("nope")

