@ActionQuery ?= {}
class ActionQuery.$PrivateMethods
  __processResponse__: (response) ->
    for key,val of response
      @[key] = val
      @["$#{key}Was"] = val
  format: 'json'
  __destroy__: ->
    route = @__selectRoute__('destroy')
    return @$promise unless route
    return @$promise if @$destroyed
    for key in Object.keys @
      continue unless key.match(/^\$.*Was$/)
      @[key] = null
    @$destroyed = true
    @id = null
    @$promise = $.ajax(
      url: route.path
      method: route.verb
    )
  __save__: ->
    method = if @id then 'update' else 'create'
    route = @__selectRoute__(method)
    data = @__sanitizeParams__()
    # Make sure there is a route
    return @$promise unless route
    # Make sure on update that keys are more than just format
    return @$promise if method == 'update' && Object.keys(data[@constructor.name.underscore()]).length <= 1

    @$destroyed = false
    @$promise = $.ajax(
      url: route.path
      method: route.verb
      data: data
    )
    .then @__processResponse__.bind(@)
  __selectRoute__: (method) ->
    routes = []
    for route in @__routes__.filter((route) -> route.method == method)
      continue unless route.requirements.subtract(Object.keys(@)).length == 0
      path = route.path
      for key,val of @
        path = path.replace(":#{key}",val)
      path = path.replace /\(.*\)/, (match) ->
        return '' if match.indexOf(':') >= 0
        return match[1..-2]
      routes.push(weight: route.requirements.length, path: path, verb: route.verb)
    weight = routes.pluck('weight').max()
    (routes.filter (route) -> route.weight == weight).first()
  __sanitizeParams__: ->
    data = {}
    data[@constructor.name.underscore()] = {}
    for key,val of @
      continue if key[0] in ['$','_'] || key == 'constructor'
      continue if @[key] == @["$#{key}Was"]
      data[@constructor.name.underscore()][key] = val
    data
