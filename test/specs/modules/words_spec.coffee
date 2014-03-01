words = require('../../../src/modules/words')

describe "words util", ->

  describe "humanize", ->

    it "works with camel case", ->
      expect(words.humanize("camelCase")).to.equal("Camel Case")

    it "trims the input", ->
      expect(words.humanize(" camelCase   ")).to.equal("Camel Case")


  describe "titleize", ->

    it "converts first letters to uppercase", ->
      expect(words.titleize("my fair lady")).to.equal("My Fair Lady")


  describe "capitalize", ->

    it "converts first letters to uppercase", ->
      expect(words.capitalize("a sentence")).to.equal("A sentence")


  describe "prefix", ->

    it "adds a prefix to a string", ->
      expect(words.prefix("ms-", "word")).to.equal("ms-word")


    it "does not add a prefix twice", ->
      expect(words.prefix("ms-", "ms-word")).to.equal("ms-word")


  describe "snakeCase", ->

    it "converts to snakeCase", ->
      expect(words.snakeCase("snakeCase")).to.equal("snake-case")


  describe "camelize", ->

    it "converts to camelCase", ->
      expect(words.camelize("camel-case")).to.equal("camelCase")

    it "leaves camelCase string untouched", ->
      expect(words.camelize("camelCase")).to.equal("camelCase")

    it "removes unnecessary dashes", ->
      expect(words.camelize("camel--case")).to.equal("camelCase")
