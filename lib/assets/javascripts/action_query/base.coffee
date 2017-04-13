# //= require_tree ./extensions
# //= require action_query/class_methods
# //= require action_query/private_methods
# //= require action_query/collection
@ActionQuery ?= {}
class ActionQuery.$Base extends Module
  @extend(ActionQuery.$ClassMethods)
  @include(ActionQuery.$PrivateMethods)
  $save: ->
    # Only trigger save after last action completed (can't create until new is done)
    # (can't update until create or update is done)
    @$promise.then @__save__.bind(@)
  $destroy: ->
    @$promise.then @__destroy__.bind(@)
