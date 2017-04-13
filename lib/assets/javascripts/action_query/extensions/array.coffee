unless Array::includes
  Array::includes = (el) -> @indexOf(el) >= 0
unless Array::filter
  Array::filter = (fn) ->
    arr = []
    (arr.push(el) if fn(el)) for el in @
unless Array::intersection
  Array::intersection = (arr) ->
    @filter((el) -> arr.includes(el))
unless Array::intersects
  Array::intersects = (arr) ->
    @intersection(arr).length > 0
unless Array::subtract
  Array::subtract = (arr) ->
    @filter((el) -> !arr.includes(el))
unless Array::pluck
  Array::pluck = (keys...) ->
    keys = keys.flatten()
    arr = []
    for el in @
      arr.push(keys.map (key) -> el[key])
    return if keys.length == 1 then arr.flatten() else arr
unless Array::flatten
  Array::flatten = ->
    arr = []
    for l in @
      if Array.isArray(l)
        for i in l.flatten()
          arr.push i
      else
        arr.push l
    arr
unless Array::min
  Array::min        = -> return Math.min.apply(null,@)
  Array::max        = -> return Math.max.apply(null,@)
unless Array::first
  Array::first      = -> @[0]
  Array::last       = -> @[@length - 1]
unless Array::dup
  Array::dup        = -> return @slice(0)
  Array::empty      = -> @length == 0
  Array::present    = -> @length != 0
unless Array::merge
  Array::merge = (arr) ->
    @push(el) for el in arr
    @
