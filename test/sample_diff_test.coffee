SampleDiff = require '../src/sample_diff'

path         = require 'path'
difflet      = require('difflet')
_            = require 'underscore'

fetch_item_id_func = (line1) ->
                _.each(Array(8), -> Array(Math.pow(10, 7)).join("=").length) # mimic slow cpu
                JSON.parse(line1)['id']

opts = {
            "fetch_item_id_func" : (line1) -> fetch_item_id_func(line1),
            "diff_items_func"    : (a, b)  -> console.log(difflet.compare(JSON.parse(a), JSON.parse(b)), "\n"),
        }

exports.SampleDiffTest =

    "same test": (test) ->
        fileA = "#{path.join(__dirname, 'fileA.txt')}"
        fileB = "#{path.join(__dirname, 'fileB.txt')}"

        @same_checker = new SampleDiff(
                                                fileB, fileA,
                                                3, opts
                                               )
        @same_checker.run(
            (is_same) ->
                test.equal(is_same, true)
                test.done()
        )


    "diff test": (test) ->
        fileA = "#{path.join(__dirname, 'fileA.txt')}"
        fileC = "#{path.join(__dirname, 'fileC.txt')}"

        @diff_checker = new SampleDiff(
                                                fileC, fileA,
                                                3, opts
                                               )
        @diff_checker.run(
          (is_same) ->
            test.equal(is_same, false)
            test.done()
        )