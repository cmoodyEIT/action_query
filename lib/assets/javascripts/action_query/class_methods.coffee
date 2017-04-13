@ActionQuery ?= {}
class @ActionQuery.$ClassMethods
  methods: (args) ->
    @_createMethod(name,details) for name,details of args
  _createMethod: (name,details) ->
    @::__routes__ ||= []
    @::__routes__.merge(details)
    @[name] = (params) ->
      params = {id: params} if !isNaN(params)
      params ||= {}
      params.format ||= 'json'
      paths = []
      for route in details
        continue unless route.requirements.subtract(Object.keys(params)).length == 0
        path = route.path
        for key,val of params
          path = path.replace(":#{key}",val)
        path = path.replace /\(.*\)/, (match) ->
          return '' if match.indexOf(':') >= 0
          return match[1..-2]
        paths.push(weight: route.requirements.length, path: path, verb: route.verb, method: route.method)
      weight = paths.pluck('weight').max()
      path = (paths.filter (path) -> path.weight == weight).first()
      if @_isCollection(path,params)
        @_fetchCollection(path,params)
      else
        @_sendRequest(path,params)

  _isCollection: (route,params) ->
    !params.id && route.verb.toUpperCase() != 'POST'

  _fetchCollection: (details,params) ->
    data = {}
    data[@name.underscore()] = params
    promise = $.ajax(
      url: details.path
      method: details.verb
      data: data
    )
    return new ActionQuery.$Collection(@,promise)

  _sendRequest: (details,params) ->
    data = {}
    data[@name.underscore()] = params
    newRec = new @
    newRec.$promise = $.ajax(
      url: details.path
      method: details.verb
      data: data
    )
    .then newRec.__processResponse__.bind(newRec)
    return newRec
