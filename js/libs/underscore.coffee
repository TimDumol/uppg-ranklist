(->
  n = this
  t = n._
  r = {}
  e = Array::
  u = Object::
  i = Function::
  a = e.push
  o = e.slice
  c = e.concat
  l = u.toString
  f = u.hasOwnProperty
  s = e.forEach
  p = e.map
  v = e.reduce
  h = e.reduceRight
  g = e.filter
  d = e.every
  m = e.some
  y = e.indexOf
  b = e.lastIndexOf
  x = Array.isArray
  _ = Object.keys
  j = i.bind
  w = (n) ->
    (if n instanceof w then n else (if this instanceof w then (@_wrapped = n
    undefined
    ) else new w(n)))

  (if "undefined" isnt typeof exports then ("undefined" isnt typeof module and module.exports and (exports = module.exports = w)
  exports._ = w
  ) else n._ = w)
  w.VERSION = "1.4.3"

  A = w.each = w.forEach = (n, t, e) ->
    unless null is n
      if s and n.forEach is s
        n.forEach t, e
      else if n.length is +n.length
        u = 0
        i = n.length

        while i > u
          return  if t.call(e, n[u], u, n) is r
          u++
      else
        for a of n
          return  if w.has(n, a) and t.call(e, n[a], a, n) is r

  w.map = w.collect = (n, t, r) ->
    e = []
    (if null is n then e else (if p and n.map is p then n.map(t, r) else (A(n, (n, u, i) ->
      e[e.length] = t.call(r, n, u, i)
    )
    e
    )))

  O = "Reduce of empty array with no initial value"
  w.reduce = w.foldl = w.inject = (n, t, r, e) ->
    u = arguments_.length > 2
    if null is n and (n = [])
    v and n.reduce is v
      return e and (t = w.bind(t, e))
      (if u then n.reduce(t, r) else n.reduce(t))
    throw new TypeError(O)  if A(n, (n, i, a) ->
      (if u then r = t.call(e, r, n, i, a) else (r = n
      u = not 0
      ))
    )
    not u

    r

  w.reduceRight = w.foldr = (n, t, r, e) ->
    u = arguments_.length > 2
    if null is n and (n = [])
    h and n.reduceRight is h
      return e and (t = w.bind(t, e))
      (if u then n.reduceRight(t, r) else n.reduceRight(t))
    i = n.length
    if i isnt +i
      a = w.keys(n)
      i = a.length
    throw new TypeError(O)  if A(n, (o, c, l) ->
      c = (if a then a[--i] else --i)
      (if u then r = t.call(e, r, n[c], c, l) else (r = n[c]
      u = not 0
      ))
    )
    not u

    r

  w.find = w.detect = (n, t, r) ->
    e = undefined
    E(n, (n, u, i) ->
      (if t.call(r, n, u, i) then (e = n
      not 0
      ) else undefined)
    )
    e

  w.filter = w.select = (n, t, r) ->
    e = []
    (if null is n then e else (if g and n.filter is g then n.filter(t, r) else (A(n, (n, u, i) ->
      t.call(r, n, u, i) and (e[e.length] = n)
    )
    e
    )))

  w.reject = (n, t, r) ->
    w.filter n, ((n, e, u) ->
      not t.call(r, n, e, u)
    ), r

  w.every = w.all = (n, t, e) ->
    t or (t = w.identity)
    u = not 0
    (if null is n then u else (if d and n.every is d then n.every(t, e) else (A(n, (n, i, a) ->
      (if (u = u and t.call(e, n, i, a)) then undefined else r)
    )
    !!u
    )))


  E = w.some = w.any = (n, t, e) ->
    t or (t = w.identity)
    u = not 1
    (if null is n then u else (if m and n.some is m then n.some(t, e) else (A(n, (n, i, a) ->
      (if u or (u = t.call(e, n, i, a)) then r else undefined)
    )
    !!u
    )))

  w.contains = w.include = (n, t) ->
    (if null is n then not 1 else (if y and n.indexOf is y then -1 isnt n.indexOf(t) else E(n, (n) ->
      n is t
    )))

  w.invoke = (n, t) ->
    r = o.call(arguments_, 2)
    w.map n, (n) ->
      ((if w.isFunction(t) then t else n[t])).apply n, r


  w.pluck = (n, t) ->
    w.map n, (n) ->
      n[t]


  w.where = (n, t) ->
    (if w.isEmpty(t) then [] else w.filter(n, (n) ->
      for r of t
        return not 1  if t[r] isnt n[r]
      not 0
    ))

  w.max = (n, t, r) ->
    return Math.max.apply(Math, n)  if not t and w.isArray(n) and n[0] is +n[0] and 65535 > n.length
    return -1 / 0  if not t and w.isEmpty(n)
    e =
      computed: -1 / 0
      value: -1 / 0

    A(n, (n, u, i) ->
      a = (if t then t.call(r, n, u, i) else n)
      a >= e.computed and (e =
        value: n
        computed: a
      )
    )
    e.value

  w.min = (n, t, r) ->
    return Math.min.apply(Math, n)  if not t and w.isArray(n) and n[0] is +n[0] and 65535 > n.length
    return 1 / 0  if not t and w.isEmpty(n)
    e =
      computed: 1 / 0
      value: 1 / 0

    A(n, (n, u, i) ->
      a = (if t then t.call(r, n, u, i) else n)
      e.computed > a and (e =
        value: n
        computed: a
      )
    )
    e.value

  w.shuffle = (n) ->
    t = undefined
    r = 0
    e = []
    A(n, (n) ->
      t = w.random(r++)
      e[r - 1] = e[t]
      e[t] = n
    )
    e


  F = (n) ->
    (if w.isFunction(n) then n else (t) ->
      t[n]
    )

  w.sortBy = (n, t, r) ->
    e = F(t)
    w.pluck w.map(n, (n, t, u) ->
      value: n
      index: t
      criteria: e.call(r, n, t, u)
    ).sort((n, t) ->
      r = n.criteria
      e = t.criteria
      if r isnt e
        return 1  if r > e or undefined is r
        return -1  if e > r or undefined is e
      (if n.index < t.index then -1 else 1)
    ), "value"

  k = (n, t, r, e) ->
    u = {}
    i = F(t or w.identity)
    A(n, (t, a) ->
      o = i.call(r, t, a, n)
      e u, o, t
    )
    u

  w.groupBy = (n, t, r) ->
    k n, t, r, (n, t, r) ->
      ((if w.has(n, t) then n[t] else n[t] = [])).push r


  w.countBy = (n, t, r) ->
    k n, t, r, (n, t) ->
      w.has(n, t) or (n[t] = 0)
      n[t]++


  w.sortedIndex = (n, t, r, e) ->
    r = (if null is r then w.identity else F(r))
    u = r.call(e, t)
    i = 0
    a = n.length

    while a > i
      o = i + a >>> 1
      (if u > r.call(e, n[o]) then i = o + 1 else a = o)
    i

  w.toArray = (n) ->
    (if n then (if w.isArray(n) then o.call(n) else (if n.length is +n.length then w.map(n, w.identity) else w.values(n))) else [])

  w.size = (n) ->
    (if null is n then 0 else (if n.length is +n.length then n.length else w.keys(n).length))

  w.first = w.head = w.take = (n, t, r) ->
    (if null is n then undefined else (if null is t or r then n[0] else o.call(n, 0, t)))

  w.initial = (n, t, r) ->
    o.call n, 0, n.length - ((if null is t or r then 1 else t))

  w.last = (n, t, r) ->
    (if null is n then undefined else (if null is t or r then n[n.length - 1] else o.call(n, Math.max(n.length - t, 0))))

  w.rest = w.tail = w.drop = (n, t, r) ->
    o.call n, (if null is t or r then 1 else t)

  w.compact = (n) ->
    w.filter n, w.identity


  R = (n, t, r) ->
    A(n, (n) ->
      (if w.isArray(n) then (if t then a.apply(r, n) else R(n, t, r)) else r.push(n))
    )
    r

  w.flatten = (n, t) ->
    R n, t, []

  w.without = (n) ->
    w.difference n, o.call(arguments_, 1)

  w.uniq = w.unique = (n, t, r, e) ->
    w.isFunction(t) and (e = r
    r = t
    t = not 1
    )
    u = (if r then w.map(n, r, e) else n)
    i = []
    a = []
    A(u, (r, e) ->
      ((if t then e and a[a.length - 1] is r else w.contains(a, r))) or (a.push(r)
      i.push(n[e])
      )
    )
    i

  w.union = ->
    w.uniq c.apply(e, arguments_)

  w.intersection = (n) ->
    t = o.call(arguments_, 1)
    w.filter w.uniq(n), (n) ->
      w.every t, (t) ->
        w.indexOf(t, n) >= 0



  w.difference = (n) ->
    t = c.apply(e, o.call(arguments_, 1))
    w.filter n, (n) ->
      not w.contains(t, n)


  w.zip = ->
    n = o.call(arguments_)
    t = w.max(w.pluck(n, "length"))
    r = Array(t)
    e = 0

    while t > e
      r[e] = w.pluck(n, "" + e)
      e++
    r

  w.object = (n, t) ->
    return {}  if null is n
    r = {}
    e = 0
    u = n.length

    while u > e
      (if t then r[n[e]] = t[e] else r[n[e][0]] = n[e][1])
      e++
    r

  w.indexOf = (n, t, r) ->
    return -1  if null is n
    e = 0
    u = n.length
    if r
      unless "number" is typeof r
        return e = w.sortedIndex(n, t)
        (if n[e] is t then e else -1)
      e = (if 0 > r then Math.max(0, u + r) else r)
    return n.indexOf(t, r)  if y and n.indexOf is y
    while u > e
      return e  if n[e] is t
      e++
    -1

  w.lastIndexOf = (n, t, r) ->
    return -1  if null is n
    e = null isnt r
    return (if e then n.lastIndexOf(t, r) else n.lastIndexOf(t))  if b and n.lastIndexOf is b
    u = (if e then r else n.length)

    while u--
      return u  if n[u] is t
    -1

  w.range = (n, t, r) ->
    1 >= arguments_.length and (t = n or 0
    n = 0
    )
    r = arguments_[2] or 1

    e = Math.max(Math.ceil((t - n) / r), 0)
    u = 0
    i = Array(e)

    while e > u
      i[u++] = n
      n += r
    i


  I = ->

  w.bind = (n, t) ->
    r = undefined
    e = undefined
    return j.apply(n, o.call(arguments_, 1))  if n.bind is j and j
    throw new TypeError  unless w.isFunction(n)
    r = o.call(arguments_, 2)
    e = ->
      return n.apply(t, r.concat(o.call(arguments_)))  unless this instanceof e
      I:: = n::
      u = new I
      I:: = null
      i = n.apply(u, r.concat(o.call(arguments_)))
      (if Object(i) is i then i else u)

  w.bindAll = (n) ->
    t = o.call(arguments_, 1)
    0 is t.length and (t = w.functions(n))
    A(t, (t) ->
      n[t] = w.bind(n[t], n)
    )
    n

  w.memoize = (n, t) ->
    r = {}
    t or (t = w.identity)
    ->
      e = t.apply(this, arguments_)
      (if w.has(r, e) then r[e] else r[e] = n.apply(this, arguments_))

  w.delay = (n, t) ->
    r = o.call(arguments_, 2)
    setTimeout (->
      n.apply null, r
    ), t

  w.defer = (n) ->
    w.delay.apply w, [n, 1].concat(o.call(arguments_, 1))

  w.throttle = (n, t) ->
    r = undefined
    e = undefined
    u = undefined
    i = undefined
    a = 0
    o = ->
      a = new Date
      u = null
      i = n.apply(r, e)

    ->
      c = new Date
      l = t - (c - a)
      r = this
      e = arguments_
      (if 0 >= l then (clearTimeout(u)
      u = null
      a = c
      i = n.apply(r, e)
      ) else u or (u = setTimeout(o, l)))
      i

  w.debounce = (n, t, r) ->
    e = undefined
    u = undefined
    ->
      i = this
      a = arguments_
      o = ->
        e = null
        r or (u = n.apply(i, a))

      c = r and not e
      clearTimeout(e)
      e = setTimeout(o, t)
      c and (u = n.apply(i, a))
      u

  w.once = (n) ->
    t = undefined
    r = not 1
    ->
      (if r then t else (r = not 0
      t = n.apply(this, arguments_)
      n = null
      t
      ))

  w.wrap = (n, t) ->
    ->
      r = [n]
      a.apply(r, arguments_)
      t.apply(this, r)

  w.compose = ->
    n = arguments_
    ->
      t = arguments_
      r = n.length - 1

      while r >= 0
        t = [n[r].apply(this, t)]
        r--
      t[0]

  w.after = (n, t) ->
    (if 0 >= n then t() else ->
      (if 1 > --n then t.apply(this, arguments_) else undefined)
    )

  w.keys = _ or (n) ->
    throw new TypeError("Invalid object")  if n isnt Object(n)
    t = []
    for r of n
      w.has(n, r) and (t[t.length] = r)
    t

  w.values = (n) ->
    t = []
    for r of n
      w.has(n, r) and t.push(n[r])
    t

  w.pairs = (n) ->
    t = []
    for r of n
      w.has(n, r) and t.push([r, n[r]])
    t

  w.invert = (n) ->
    t = {}
    for r of n
      w.has(n, r) and (t[n[r]] = r)
    t

  w.functions = w.methods = (n) ->
    t = []
    for r of n
      w.isFunction(n[r]) and t.push(r)
    t.sort()

  w.extend = (n) ->
    A(o.call(arguments_, 1), (t) ->
      if t
        for r of t
          n[r] = t[r]
    )
    n

  w.pick = (n) ->
    t = {}
    r = c.apply(e, o.call(arguments_, 1))
    A(r, (r) ->
      r of n and (t[r] = n[r])
    )
    t

  w.omit = (n) ->
    t = {}
    r = c.apply(e, o.call(arguments_, 1))
    for u of n
      w.contains(r, u) or (t[u] = n[u])
    t

  w.defaults = (n) ->
    A(o.call(arguments_, 1), (t) ->
      if t
        for r of t
          null is n[r] and (n[r] = t[r])
    )
    n

  w.clone = (n) ->
    (if w.isObject(n) then (if w.isArray(n) then n.slice() else w.extend({}, n)) else n)

  w.tap = (n, t) ->
    t(n)
    n


  S = (n, t, r, e) ->
    return 0 isnt n or 1 / n is 1 / t  if n is t
    return n is t  if null is n or null is t
    n instanceof w and (n = n._wrapped)
    t instanceof w and (t = t._wrapped)

    u = l.call(n)
    return not 1  unless u is l.call(t)
    switch u
      when "[object String]"
        return n is t + ""
      when "[object Number]"
        return (if n isnt +n then t isnt +t else (if 0 is n then 1 / n is 1 / t else n is +t))
      when "[object Date]", "[object Boolean]"
        return +n is +t
      when "[object RegExp]"
        return n.source is t.source and n.global is t.global and n.multiline is t.multiline and n.ignoreCase is t.ignoreCase
    return not 1  if "object" isnt typeof n or "object" isnt typeof t
    i = r.length

    while i--
      return e[i] is t  if r[i] is n
    r.push(n)
    e.push(t)

    a = 0
    o = not 0
    if "[object Array]" is u
      while a-- and (o = S(n[a], t[a], r, e))  if a = n.length
      o = a is t.length
    else
      c = n.constructor
      f = t.constructor
      return not 1  if c isnt f and not (w.isFunction(c) and c instanceof c and w.isFunction(f) and f instanceof f)
      for s of n
        break  if w.has(n, s) and (a++
        not (o = w.has(t, s) and S(n[s], t[s], r, e))
        )
      if o
        for s of t
          break  if w.has(t, s) and not a--
        o = not a
    r.pop()
    e.pop()
    o

  w.isEqual = (n, t) ->
    S n, t, [], []

  w.isEmpty = (n) ->
    return not 0  if null is n
    return 0 is n.length  if w.isArray(n) or w.isString(n)
    for t of n
      return not 1  if w.has(n, t)
    not 0

  w.isElement = (n) ->
    not (not n or 1 isnt n.nodeType)

  w.isArray = x or (n) ->
    "[object Array]" is l.call(n)

  w.isObject = (n) ->
    n is Object(n)

  A(["Arguments", "Function", "String", "Number", "Date", "RegExp"], (n) ->
    w["is" + n] = (t) ->
      l.call(t) is "[object " + n + "]"
  )
  w.isArguments(arguments_) or (w.isArguments = (n) ->
    not (not n or not w.has(n, "callee"))
  )
  w.isFunction = (n) ->
    "function" is typeof n

  w.isFinite = (n) ->
    isFinite(n) and not isNaN(parseFloat(n))

  w.isNaN = (n) ->
    w.isNumber(n) and n isnt +n

  w.isBoolean = (n) ->
    n is not 0 or n is not 1 or "[object Boolean]" is l.call(n)

  w.isNull = (n) ->
    null is n

  w.isUndefined = (n) ->
    undefined is n

  w.has = (n, t) ->
    f.call n, t

  w.noConflict = ->
    n._ = t
    this

  w.identity = (n) ->
    n

  w.times = (n, t, r) ->
    e = Array(n)
    u = 0

    while n > u
      e[u] = t.call(r, u)
      u++
    e

  w.random = (n, t) ->
    null is t and (t = n
    n = 0
    )
    n + (0 | Math.random() * (t - n + 1))


  T = escape:
    "&": "&amp;"
    "<": "&lt;"
    ">": "&gt;"
    "\"": "&quot;"
    "'": "&#x27;"
    "/": "&#x2F;"

  T.unescape = w.invert(T.escape)
  M =
    escape: RegExp("[" + w.keys(T.escape).join("") + "]", "g")
    unescape: RegExp("(" + w.keys(T.unescape).join("|") + ")", "g")

  w.each(["escape", "unescape"], (n) ->
    w[n] = (t) ->
      (if null is t then "" else ("" + t).replace(M[n], (t) ->
        T[n][t]
      ))
  )
  w.result = (n, t) ->
    return null  if null is n
    r = n[t]
    (if w.isFunction(r) then r.call(n) else r)

  w.mixin = (n) ->
    A w.functions(n), (t) ->
      r = w[t] = n[t]
      w::[t] = ->
        n = [@_wrapped]
        a.apply(n, arguments_)
        z.call(this, r.apply(w, n))



  N = 0
  w.uniqueId = (n) ->
    t = "" + ++N
    (if n then n + t else t)

  w.templateSettings =
    evaluate: /<%([\s\S]+?)%>/g
    interpolate: /<%=([\s\S]+?)%>/g
    escape: /<%-([\s\S]+?)%>/g


  q = /(.)^/
  B =
    "'": "'"
    "\\": "\\"
    "\r": "r"
    "\n": "n"
    "\t": "t"
    " ": "u2028"
    " ": "u2029"

  D = /\\|'|\r|\n|\t|\u2028|\u2029/g
  w.template = (n, t, r) ->
    r = w.defaults({}, r, w.templateSettings)
    e = RegExp([(r.escape or q).source, (r.interpolate or q).source, (r.evaluate or q).source].join("|") + "|$", "g")
    u = 0
    i = "__p+='"
    n.replace(e, (t, r, e, a, o) ->
      i += n.slice(u, o).replace(D, (n) ->
        "\\" + B[n]
      )
      r and (i += "'+\n((__t=(" + r + "))==null?'':_.escape(__t))+\n'")
      e and (i += "'+\n((__t=(" + e + "))==null?'':__t)+\n'")
      a and (i += "';\n" + a + "\n__p+='")
      u = o + t.length
      t
    )
    i += "';\n"
    r.variable or (i = "with(obj||{}){\n" + i + "}\n")
    i = "var __t,__p='',__j=Array.prototype.join,print=function(){__p+=__j.call(arguments,'');};\n" + i + "return __p;\n"

    try
      a = Function(r.variable or "obj", "_", i)
    catch o
      throw o.source = i
      o
    return a(t, w)  if t
    c = (n) ->
      a.call this, n, w

    c.source = "function(" + (r.variable or "obj") + "){\n" + i + "}"
    c

  w.chain = (n) ->
    w(n).chain()


  z = (n) ->
    (if @_chain then w(n).chain() else n)

  w.mixin(w)
  A(["pop", "push", "reverse", "shift", "sort", "splice", "unshift"], (n) ->
    t = e[n]
    w::[n] = ->
      r = @_wrapped
      t.apply(r, arguments_)
      "shift" isnt n and "splice" isnt n or 0 isnt r.length or delete r[0]

      z.call(this, r)
  )
  A(["concat", "join", "slice"], (n) ->
    t = e[n]
    w::[n] = ->
      z.call this, t.apply(@_wrapped, arguments_)
  )
  w.extend(w::,
    chain: ->
      @_chain = not 0
      this

    value: ->
      @_wrapped
  )
).call this
