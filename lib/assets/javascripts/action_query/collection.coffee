@ActionQuery ?= {}
class @ActionQuery.$Collection extends Array
  constructor: (@klass,@$promise) ->
    @$promise.then @__initializeRecords__.bind(@)
  __initializeRecords__: (records) ->
    for record in records
      rec = new @klass
      rec.$promise = @$promise
      rec.__processResponse__(record)
      @push(rec)
