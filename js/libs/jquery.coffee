#! jQuery v1.8.3 jquery.com | jquery.org/license 
((e, t) ->
  _ = (e) ->
    t = M[e] = {}
    v.each(e.split(y), (e, n) ->
      t[n] = not 0
    )
    t
  H = (e, n, r) ->
    if r is t and e.nodeType is 1
      i = "data-" + n.replace(P, "-$1").toLowerCase()
      r = e.getAttribute(i)
      if typeof r is "string"
        try
          r = (if r is "true" then not 0 else (if r is "false" then not 1 else (if r is "null" then null else (if +r + "" is r then +r else (if D.test(r) then v.parseJSON(r) else r)))))
        v.data e, n, r
      else
        r = t
    r
  B = (e) ->
    t = undefined
    for t of e
      continue  if t is "data" and v.isEmptyObject(e[t])
      return not 1  if t isnt "toJSON"
    not 0
  et = ->
    not 1
  tt = ->
    not 0
  ut = (e) ->
    not e or not e.parentNode or e.parentNode.nodeType is 11
  at = (e, t) ->
    loop
      e = e[t]
      break unless e and e.nodeType isnt 1
    e
  ft = (e, t, n) ->
    t = t or 0
    if v.isFunction(t)
      return v.grep(e, (e, r) ->
        i = !!t.call(e, r, e)
        i is n
      )
    if t.nodeType
      return v.grep(e, (e, r) ->
        e is t is n
      )
    if typeof t is "string"
      r = v.grep(e, (e) ->
        e.nodeType is 1
      )
      return v.filter(t, r, not n)  if it.test(t)
      t = v.filter(t, r)
    v.grep e, (e, r) ->
      v.inArray(e, t) >= 0 is n

  lt = (e) ->
    t = ct.split("|")
    n = e.createDocumentFragment()
    n.createElement t.pop()  while t.length  if n.createElement
    n
  Lt = (e, t) ->
    e.getElementsByTagName(t)[0] or e.appendChild(e.ownerDocument.createElement(t))
  At = (e, t) ->
    return  if t.nodeType isnt 1 or not v.hasData(e)
    n = undefined
    r = undefined
    i = undefined
    s = v._data(e)
    o = v._data(t, s)
    u = s.events
    if u
      delete o.handle

      o.events = {}

      for n of u
        r = 0
        i = u[n].length

        while r < i
          v.event.add t, n, u[n][r]
          r++
    o.data and (o.data = v.extend({}, o.data))
  Ot = (e, t) ->
    n = undefined
    return  if t.nodeType isnt 1
    t.clearAttributes and t.clearAttributes()
    t.mergeAttributes and t.mergeAttributes(e)
    n = t.nodeName.toLowerCase()
    (if n is "object" then (t.parentNode and (t.outerHTML = e.outerHTML)
    v.support.html5Clone and e.innerHTML and not v.trim(t.innerHTML) and (t.innerHTML = e.innerHTML)
    ) else (if n is "input" and Et.test(e.type) then (t.defaultChecked = t.checked = e.checked
    t.value isnt e.value and (t.value = e.value)
    ) else (if n is "option" then t.selected = e.defaultSelected else (if n is "input" or n is "textarea" then t.defaultValue = e.defaultValue else n is "script" and t.text isnt e.text and (t.text = e.text)))))
    t.removeAttribute(v.expando)
  Mt = (e) ->
    (if typeof e.getElementsByTagName isnt "undefined" then e.getElementsByTagName("*") else (if typeof e.querySelectorAll isnt "undefined" then e.querySelectorAll("*") else []))
  _t = (e) ->
    Et.test(e.type) and (e.defaultChecked = e.checked)
  Qt = (e, t) ->
    return t  if t of e
    n = t.charAt(0).toUpperCase() + t.slice(1)
    r = t
    i = Jt.length
    while i--
      t = Jt[i] + n
      return t  if t of e
    r
  Gt = (e, t) ->
    e = t or e
    v.css(e, "display") is "none" or not v.contains(e.ownerDocument, e)
  Yt = (e, t) ->
    n = undefined
    r = undefined
    i = []
    s = 0
    o = e.length
    while s < o
      n = e[s]
      continue  unless n.style
      i[s] = v._data(n, "olddisplay")
      (if t then (not i[s] and n.style.display is "none" and (n.style.display = "")
      n.style.display is "" and Gt(n) and (i[s] = v._data(n, "olddisplay", nn(n.nodeName)))
      ) else (r = Dt(n, "display")
      not i[s] and r isnt "none" and v._data(n, "olddisplay", r)
      ))
      s++
    s = 0
    while s < o
      n = e[s]
      continue  unless n.style
      n.style.display = (if t then i[s] or "" else "none")  if not t or n.style.display is "none" or n.style.display is ""
      s++
    e
  Zt = (e, t, n) ->
    r = Rt.exec(t)
    (if r then Math.max(0, r[1] - (n or 0)) + (r[2] or "px") else t)
  en = (e, t, n, r) ->
    i = (if n is ((if r then "border" else "content")) then 4 else (if t is "width" then 1 else 0))
    s = 0
    while i < 4
      n is "margin" and (s += v.css(e, n + $t[i], not 0))
      (if r then (n is "content" and (s -= parseFloat(Dt(e, "padding" + $t[i])) or 0)
      n isnt "margin" and (s -= parseFloat(Dt(e, "border" + $t[i] + "Width")) or 0)
      ) else (s += parseFloat(Dt(e, "padding" + $t[i])) or 0
      n isnt "padding" and (s += parseFloat(Dt(e, "border" + $t[i] + "Width")) or 0)
      ))
      i += 2
    s
  tn = (e, t, n) ->
    r = (if t is "width" then e.offsetWidth else e.offsetHeight)
    i = not 0
    s = v.support.boxSizing and v.css(e, "boxSizing") is "border-box"
    if r <= 0 or not r?
      r = Dt(e, t)
      r = e.style[t]  if r < 0 or not r?
      return r  if Ut.test(r)
      i = s and (v.support.boxSizingReliable or r is e.style[t])
      r = parseFloat(r) or 0
    r + en(e, t, n or ((if s then "border" else "content")), i) + "px"
  nn = (e) ->
    return Wt[e]  if Wt[e]
    t = v("<" + e + ">").appendTo(i.body)
    n = t.css("display")
    t.remove()
    if n is "none" or n is ""
      Pt = i.body.appendChild(Pt or v.extend(i.createElement("iframe"),
        frameBorder: 0
        width: 0
        height: 0
      ))
      if not Ht or not Pt.createElement
        Ht = (Pt.contentWindow or Pt.contentDocument).document
        Ht.write("<!doctype html><html><body>")
        Ht.close()
      t = Ht.body.appendChild(Ht.createElement(e))
      n = Dt(t, "display")
      i.body.removeChild(Pt)
    Wt[e] = n
    n
  fn = (e, t, n, r) ->
    i = undefined
    if v.isArray(t)
      v.each t, (t, i) ->
        (if n or sn.test(e) then r(e, i) else fn(e + "[" + ((if typeof i is "object" then t else "")) + "]", i, n, r))

    else if not n and v.type(t) is "object"
      for i of t
        fn e + "[" + i + "]", t[i], n, r
    else
      r e, t
  Cn = (e) ->
    (t, n) ->
      typeof t isnt "string" and (n = t
      t = "*"
      )
      r = undefined
      i = undefined
      s = undefined
      o = t.toLowerCase().split(y)
      u = 0
      a = o.length
      if v.isFunction(n)
        while u < a
          r = o[u]
          s = /^\+/.test(r)
          s and (r = r.substr(1) or "*")
          i = e[r] = e[r] or []
          i[(if s then "unshift" else "push")](n)
          u++
  kn = (e, n, r, i, s, o) ->
    s = s or n.dataTypes[0]
    o = o or {}
    o[s] = not 0

    u = undefined
    a = e[s]
    f = 0
    l = (if a then a.length else 0)
    c = e is Sn
    while f < l and (c or not u)
      u = a[f](n, r, i)
      typeof u is "string" and ((if not c or o[u] then u = t else (n.dataTypes.unshift(u)
      u = kn(e, n, r, i, u, o)
      )))
      f++
    (c or not u) and not o["*"] and (u = kn(e, n, r, i, "*", o))
    u
  Ln = (e, n) ->
    r = undefined
    i = undefined
    s = v.ajaxSettings.flatOptions or {}
    for r of n
      n[r] isnt t and (((if s[r] then e else i or (i = {})))[r] = n[r])
    i and v.extend(not 0, e, i)
  An = (e, n, r) ->
    i = undefined
    s = undefined
    o = undefined
    u = undefined
    a = e.contents
    f = e.dataTypes
    l = e.responseFields
    for s of l
      s of r and (n[l[s]] = r[s])
    while f[0] is "*"
      f.shift()
      i is t and (i = e.mimeType or n.getResponseHeader("content-type"))
    if i
      for s of a
        if a[s] and a[s].test(i)
          f.unshift s
          break
    unless f[0] of r
      for s of r
        if not f[0] or e.converters[s + " " + f[0]]
          o = s
          break
        u or (u = s)
      o = o or u
    if o
      o isnt f[0] and f.unshift(o)
      r[o]
  On = (e, t) ->
    n = undefined
    r = undefined
    i = undefined
    s = undefined
    o = e.dataTypes.slice()
    u = o[0]
    a = {}
    f = 0
    e.dataFilter and (t = e.dataFilter(t, e.dataType))
    if o[1]
      for n of e.converters
        a[n.toLowerCase()] = e.converters[n]
    while i = o[++f]
      if i isnt "*"
        if u isnt "*" and u isnt i
          n = a[u + " " + i] or a["* " + i]
          unless n
            for r of a
              s = r.split(" ")
              if s[1] is i
                n = a[u + " " + s[0]] or a["* " + s[0]]
                if n
                  (if n is not 0 then n = a[r] else a[r] isnt not 0 and (i = s[0]
                  o.splice(f--, 0, i)
                  ))
                  break
          if n isnt not 0
            if n and e["throws"]
              t = n(t)
            else
              try
                t = n(t)
              catch l
                return (
                  state: "parsererror"
                  error: (if n then l else "No conversion from " + u + " to " + i)
                )
        u = i
    state: "success"
    data: t
  Fn = ->
    try
      return new e.XMLHttpRequest
  In = ->
    try
      return new e.ActiveXObject("Microsoft.XMLHTTP")
  $n = ->
    setTimeout(->
      qn = t
    , 0)
    qn = v.now()
  Jn = (e, t) ->
    v.each t, (t, n) ->
      r = (Vn[t] or []).concat(Vn["*"])
      i = 0
      s = r.length
      while i < s
        return  if r[i].call(e, t, n)
        i++

  Kn = (e, t, n) ->
    r = undefined
    i = 0
    s = 0
    o = Xn.length
    u = v.Deferred().always(->
      delete a.elem
    )
    a = ->
      t = qn or $n()
      n = Math.max(0, f.startTime + f.duration - t)
      r = n / f.duration or 0
      i = 1 - r
      s = 0
      o = f.tweens.length
      while s < o
        f.tweens[s].run i
        s++
      u.notifyWith(e, [f, i, n])
      (if i < 1 and o then n else (u.resolveWith(e, [f])
      not 1
      ))

    f = u.promise(
      elem: e
      props: v.extend({}, t)
      opts: v.extend(not 0,
        specialEasing: {}
      , n)
      originalProperties: t
      originalOptions: n
      startTime: qn or $n()
      duration: n.duration
      tweens: []
      createTween: (t, n, r) ->
        i = v.Tween(e, f.opts, t, n, f.opts.specialEasing[t] or f.opts.easing)
        f.tweens.push(i)
        i

      stop: (t) ->
        n = 0
        r = (if t then f.tweens.length else 0)
        while n < r
          f.tweens[n].run 1
          n++
        (if t then u.resolveWith(e, [f, t]) else u.rejectWith(e, [f, t]))
        this
    )
    l = f.props
    Qn l, f.opts.specialEasing
    while i < o
      r = Xn[i].call(f, e, l, f.opts)
      return r  if r
      i++
    Jn(f, l)
    v.isFunction(f.opts.start) and f.opts.start.call(e, f)
    v.fx.timer(v.extend(a,
      anim: f
      queue: f.opts.queue
      elem: e
    ))
    f.progress(f.opts.progress).done(f.opts.done, f.opts.complete).fail(f.opts.fail).always(f.opts.always)
  Qn = (e, t) ->
    n = undefined
    r = undefined
    i = undefined
    s = undefined
    o = undefined
    for n of e
      r = v.camelCase(n)
      i = t[r]
      s = e[n]
      v.isArray(s) and (i = s[1]
      s = e[n] = s[0]
      )
      n isnt r and (e[r] = s
      delete e[n]

      )
      o = v.cssHooks[r]

      if o and "expand" of o
        s = o.expand(s)
        delete e[r]


        for n of s
          n of e or (e[n] = s[n]
          t[n] = i
          )
      else
        t[r] = i
  Gn = (e, t, n) ->
    r = undefined
    i = undefined
    s = undefined
    o = undefined
    u = undefined
    a = undefined
    f = undefined
    l = undefined
    c = undefined
    h = this
    p = e.style
    d = {}
    m = []
    g = e.nodeType and Gt(e)
    n.queue or (l = v._queueHooks(e, "fx")
    not l.unqueued? and (l.unqueued = 0
    c = l.empty.fire
    l.empty.fire = ->
      l.unqueued or c()

    )
    l.unqueued++
    h.always(->
      h.always ->
        l.unqueued--
        v.queue(e, "fx").length or l.empty.fire()

    )
    )
    e.nodeType is 1 and ("height" of t or "width" of t) and (n.overflow = [p.overflow, p.overflowX, p.overflowY]
    v.css(e, "display") is "inline" and v.css(e, "float") is "none" and ((if not v.support.inlineBlockNeedsLayout or nn(e.nodeName) is "inline" then p.display = "inline-block" else p.zoom = 1))
    )
    n.overflow and (p.overflow = "hidden"
    v.support.shrinkWrapBlocks or h.done(->
      p.overflow = n.overflow[0]
      p.overflowX = n.overflow[1]
      p.overflowY = n.overflow[2]
    )
    )

    for r of t
      s = t[r]
      if Un.exec(s)
        delete t[r]

        a = a or s is "toggle"

        continue  if s is ((if g then "hide" else "show"))
        m.push r
    o = m.length
    if o
      u = v._data(e, "fxshow") or v._data(e, "fxshow", {})
      "hidden" of u and (g = u.hidden)
      a and (u.hidden = not g)
      (if g then v(e).show() else h.done(->
        v(e).hide()
      ))
      h.done(->
        t = undefined
        v.removeData e, "fxshow", not 0
        for t of d
          v.style e, t, d[t]
      )

      r = 0
      while r < o
        i = m[r]
        f = h.createTween(i, (if g then u[i] else 0))
        d[i] = u[i] or v.style(e, i)
        i of u or (u[i] = f.start
        g and (f.end = f.start
        f.start = (if i is "width" or i is "height" then 1 else 0)
        )
        )
        r++
  Yn = (e, t, n, r, i) ->
    new Yn::init(e, t, n, r, i)
  Zn = (e, t) ->
    n = undefined
    r = height: e
    i = 0
    t = (if t then 1 else 0)
    while i < 4
      n = $t[i]
      r["margin" + n] = r["padding" + n] = e
      i += 2 - t
    t and (r.opacity = r.width = e)
    r
  tr = (e) ->
    (if v.isWindow(e) then e else (if e.nodeType is 9 then e.defaultView or e.parentWindow else not 1))
  n = undefined
  r = undefined
  i = e.document
  s = e.location
  o = e.navigator
  u = e.jQuery
  a = e.$
  f = Array::push
  l = Array::slice
  c = Array::indexOf
  h = Object::toString
  p = Object::hasOwnProperty
  d = String::trim
  v = (e, t) ->
    new v.fn.init(e, t, n)

  m = /[\-+]?(?:\d*\.|)\d+(?:[eE][\-+]?\d+|)/.source
  g = /\S/
  y = /\s+/
  b = /^[\s\uFEFF\xA0]+|[\s\uFEFF\xA0]+$/g
  w = /^(?:[^#<]*(<[\w\W]+>)[^>]*$|#([\w\-]*)$)/
  E = /^<(\w+)\s*\/?>(?:<\/\1>|)$/
  S = /^[\],:{}\s]*$/
  x = /(?:^|:|,)(?:\s*\[)+/g
  T = /\\(?:["\\\/bfnrt]|u[\da-fA-F]{4})/g
  N = /"[^"\\\r\n]*"|true|false|null|-?(?:\d\d*\.|)\d+(?:[eE][\-+]?\d+|)/g
  C = /^-ms-/
  k = /-([\da-z])/g
  L = (e, t) ->
    (t + "").toUpperCase()

  A = ->
    (if i.addEventListener then (i.removeEventListener("DOMContentLoaded", A, not 1)
    v.ready()
    ) else i.readyState is "complete" and (i.detachEvent("onreadystatechange", A)
    v.ready()
    ))

  O = {}
  v.fn = v:: =
    constructor: v
    init: (e, n, r) ->
      s = undefined
      o = undefined
      u = undefined
      a = undefined
      return this  unless e
      if e.nodeType
        return @context = this[0] = e
        @length = 1
        this
      if typeof e is "string"
        (if e.charAt(0) is "<" and e.charAt(e.length - 1) is ">" and e.length >= 3 then s = [null, e, null] else s = w.exec(e))
        if s and (s[1] or not n)
          if s[1]
            return n = (if n instanceof v then n[0] else n)
            a = (if n and n.nodeType then n.ownerDocument or n else i)
            e = v.parseHTML(s[1], a, not 0)
            E.test(s[1]) and v.isPlainObject(n) and @attr.call(e, n, not 0)
            v.merge(this, e)
          o = i.getElementById(s[2])
          if o and o.parentNode
            return r.find(e)  if o.id isnt s[2]
            @length = 1
            this[0] = o
          return @context = i
          @selector = e
          this
        return (if not n or n.jquery then (n or r).find(e) else @constructor(n).find(e))
      (if v.isFunction(e) then r.ready(e) else (e.selector isnt t and (@selector = e.selector
      @context = e.context
      )
      v.makeArray(e, this)
      ))

    selector: ""
    jquery: "1.8.3"
    length: 0
    size: ->
      @length

    toArray: ->
      l.call this

    get: (e) ->
      (if not e? then @toArray() else (if e < 0 then this[@length + e] else this[e]))

    pushStack: (e, t, n) ->
      r = v.merge(@constructor(), e)
      r.prevObject = this
      r.context = @context
      (if t is "find" then r.selector = @selector + ((if @selector then " " else "")) + n else t and (r.selector = @selector + "." + t + "(" + n + ")"))
      r

    each: (e, t) ->
      v.each this, e, t

    ready: (e) ->
      v.ready.promise().done(e)
      this

    eq: (e) ->
      e = +e
      (if e is -1 then @slice(e) else @slice(e, e + 1))

    first: ->
      @eq 0

    last: ->
      @eq -1

    slice: ->
      @pushStack l.apply(this, arguments_), "slice", l.call(arguments_).join(",")

    map: (e) ->
      @pushStack v.map(this, (t, n) ->
        e.call t, n, t
      )

    end: ->
      @prevObject or @constructor(null)

    push: f
    sort: [].sort
    splice: [].splice

  v.fn.init:: = v.fn
  v.extend = v.fn.extend = ->
    e = undefined
    n = undefined
    r = undefined
    i = undefined
    s = undefined
    o = undefined
    u = arguments_[0] or {}
    a = 1
    f = arguments_.length
    l = not 1
    typeof u is "boolean" and (l = u
    u = arguments_[1] or {}
    a = 2
    )
    typeof u isnt "object" and not v.isFunction(u) and (u = {})
    f is a and (u = this
    --a
    )

    while a < f
      if (e = arguments_[a])?
        for n of e
          r = u[n]
          i = e[n]

          continue  if u is i
          (if l and i and (v.isPlainObject(i) or (s = v.isArray(i))) then ((if s then (s = not 1
          o = (if r and v.isArray(r) then r else [])
          ) else o = (if r and v.isPlainObject(r) then r else {}))
          u[n] = v.extend(l, o, i)
          ) else i isnt t and (u[n] = i))
      a++
    u

  v.extend(
    noConflict: (t) ->
      e.$ is v and (e.$ = a)
      t and e.jQuery is v and (e.jQuery = u)
      v

    isReady: not 1
    readyWait: 1
    holdReady: (e) ->
      (if e then v.readyWait++ else v.ready(not 0))

    ready: (e) ->
      return  if (if e is not 0 then --v.readyWait else v.isReady)
      return setTimeout(v.ready, 1)  unless i.body
      v.isReady = not 0
      return  if e isnt not 0 and --v.readyWait > 0
      r.resolveWith(i, [v])
      v.fn.trigger and v(i).trigger("ready").off("ready")

    isFunction: (e) ->
      v.type(e) is "function"

    isArray: Array.isArray or (e) ->
      v.type(e) is "array"

    isWindow: (e) ->
      e? and e is e.window

    isNumeric: (e) ->
      not isNaN(parseFloat(e)) and isFinite(e)

    type: (e) ->
      (if not e? then String(e) else O[h.call(e)] or "object")

    isPlainObject: (e) ->
      return not 1  if not e or v.type(e) isnt "object" or e.nodeType or v.isWindow(e)
      try
        return not 1  if e.constructor and not p.call(e, "constructor") and not p.call(e.constructor::, "isPrototypeOf")
      catch n
        return not 1
      r = undefined
      for r of e

      r is t or p.call(e, r)

    isEmptyObject: (e) ->
      t = undefined
      for t of e
        return not 1
      not 0

    error: (e) ->
      throw new Error(e)

    parseHTML: (e, t, n) ->
      r = undefined
      (if not e or typeof e isnt "string" then null else (typeof t is "boolean" and (n = t
      t = 0
      )
      t = t or i
      (if (r = E.exec(e)) then [t.createElement(r[1])] else (r = v.buildFragment([e], t, (if n then null else []))
      v.merge([], ((if r.cacheable then v.clone(r.fragment) else r.fragment)).childNodes)
      ))
      ))

    parseJSON: (t) ->
      return null  if not t or typeof t isnt "string"
      t = v.trim(t)
      return e.JSON.parse(t)  if e.JSON and e.JSON.parse
      return (new Function("return " + t))()  if S.test(t.replace(T, "@").replace(N, "]").replace(x, ""))
      v.error "Invalid JSON: " + t

    parseXML: (n) ->
      r = undefined
      i = undefined
      return null  if not n or typeof n isnt "string"
      try
        (if e.DOMParser then (i = new DOMParser
        r = i.parseFromString(n, "text/xml")
        ) else (r = new ActiveXObject("Microsoft.XMLDOM")
        r.async = "false"
        r.loadXML(n)
        ))
      catch s
        r = t
      (not r or not r.documentElement or r.getElementsByTagName("parsererror").length) and v.error("Invalid XML: " + n)
      r

    noop: ->

    globalEval: (t) ->
      t and g.test(t) and (e.execScript or (t) ->
        e.eval.call e, t
      )(t)

    camelCase: (e) ->
      e.replace(C, "ms-").replace k, L

    nodeName: (e, t) ->
      e.nodeName and e.nodeName.toLowerCase() is t.toLowerCase()

    each: (e, n, r) ->
      i = undefined
      s = 0
      o = e.length
      u = o is t or v.isFunction(e)
      if r
        if u
          for i of e
            break  if n.apply(e[i], r) is not 1
        else
          while s < o
            break  if n.apply(e[s++], r) is not 1
      else if u
        for i of e
          break  if n.call(e[i], i, e[i]) is not 1
      else
        while s < o
          break  if n.call(e[s], s, e[s++]) is not 1
      e

    trim: (if d and not d.call("﻿ ") then (e) ->
      (if not e? then "" else d.call(e))
     else (e) ->
      (if not e? then "" else (e + "").replace(b, ""))
    )
    makeArray: (e, t) ->
      n = undefined
      r = t or []
      e? and (n = v.type(e)
      (if not e.length? or n is "string" or n is "function" or n is "regexp" or v.isWindow(e) then f.call(r, e) else v.merge(r, e))
      )
      r

    inArray: (e, t, n) ->
      r = undefined
      if t
        return c.call(t, e, n)  if c
        r = t.length
        n = (if n then (if n < 0 then Math.max(0, r + n) else n) else 0)

        while n < r
          return n  if n of t and t[n] is e
          n++
      -1

    merge: (e, n) ->
      r = n.length
      i = e.length
      s = 0
      if typeof r is "number"
        while s < r
          e[i++] = n[s]
          s++
      else
        e[i++] = n[s++]  while n[s] isnt t
      e.length = i
      e

    grep: (e, t, n) ->
      r = undefined
      i = []
      s = 0
      o = e.length
      n = !!n
      while s < o
        r = !!t(e[s], s)
        n isnt r and i.push(e[s])
        s++
      i

    map: (e, n, r) ->
      i = undefined
      s = undefined
      o = []
      u = 0
      a = e.length
      f = e instanceof v or a isnt t and typeof a is "number" and (a > 0 and e[0] and e[a - 1] or a is 0 or v.isArray(e))
      if f
        while u < a
          i = n(e[u], u, r)
          i? and (o[o.length] = i)
          u++
      else
        for s of e
          i = n(e[s], s, r)
          i? and (o[o.length] = i)
      o.concat.apply [], o

    guid: 1
    proxy: (e, n) ->
      r = undefined
      i = undefined
      s = undefined
      typeof n is "string" and (r = e[n]
      n = e
      e = r
      )
      (if v.isFunction(e) then (i = l.call(arguments_, 2)
      s = ->
        e.apply n, i.concat(l.call(arguments_))

      s.guid = e.guid = e.guid or v.guid++
      s
      ) else t)

    access: (e, n, r, i, s, o, u) ->
      a = undefined
      f = not r?
      l = 0
      c = e.length
      if r and typeof r is "object"
        for l of r
          v.access e, n, l, r[l], 1, o, i
        s = 1
      else if i isnt t
        a = u is t and v.isFunction(i)
        f and ((if a then (a = n
        n = (e, t, n) ->
          a.call v(e), n

        ) else (n.call(e, i)
        n = null
        )))

        if n
          while l < c
            n e[l], r, (if a then i.call(e[l], l, n(e[l], r)) else i), u
            l++
        s = 1
      (if s then e else (if f then n.call(e) else (if c then n(e[0], r) else o)))

    now: ->
      (new Date).getTime()
  )
  v.ready.promise = (t) ->
    unless r
      r = v.Deferred()
      if i.readyState is "complete"
        setTimeout v.ready, 1
      else unless i.addEventListener
        i.attachEvent("onreadystatechange", A)
        e.attachEvent("onload", v.ready)

        n = not 1
        try
          n = not e.frameElement? and i.documentElement
        n and n.doScroll and o = ->
          unless v.isReady
            try
              n.doScroll "left"
            catch e
              return setTimeout(o, 50)
            v.ready()
        ()
    r.promise t

  v.each("Boolean Number String Function Array Date RegExp Object".split(" "), (e, t) ->
    O["[object " + t + "]"] = t.toLowerCase()
  )
  n = v(i)

  M = {}
  v.Callbacks = (e) ->
    e = (if typeof e is "string" then M[e] or _(e) else v.extend({}, e))
    n = undefined
    r = undefined
    i = undefined
    s = undefined
    o = undefined
    u = undefined
    a = []
    f = not e.once and []
    l = (t) ->
      n = e.memory and t
      r = not 0
      u = s or 0
      s = 0
      o = a.length
      i = not 0

      while a and u < o
        if a[u].apply(t[0], t[1]) is not 1 and e.stopOnFalse
          n = not 1
          break
        u++
      i = not 1
      a and ((if f then f.length and l(f.shift()) else (if n then a = [] else c.disable())))

    c =
      add: ->
        if a
          t = a.length
          (r = (t) ->
            v.each t, (t, n) ->
              i = v.type(n)
              (if i is "function" then (not e.unique or not c.has(n)) and a.push(n) else n and n.length and i isnt "string" and r(n))

          )(arguments_)
          (if i then o = a.length else n and (s = t
          l(n)
          ))
        this

      remove: ->
        a and v.each(arguments_, (e, t) ->
          n = undefined
          while (n = v.inArray(t, a, n)) > -1
            a.splice(n, 1)
            i and (n <= o and o--
            n <= u and u--
            )
        )
        this

      has: (e) ->
        v.inArray(e, a) > -1

      empty: ->
        a = []
        this

      disable: ->
        a = f = n = t
        this

      disabled: ->
        not a

      lock: ->
        f = t
        n or c.disable()
        this

      locked: ->
        not f

      fireWith: (e, t) ->
        t = t or []
        t = [e, (if t.slice then t.slice() else t)]
        a and (not r or f) and ((if i then f.push(t) else l(t)))
        this

      fire: ->
        c.fireWith(this, arguments_)
        this

      fired: ->
        !!r

    c

  v.extend(
    Deferred: (e) ->
      t = [["resolve", "done", v.Callbacks("once memory"), "resolved"], ["reject", "fail", v.Callbacks("once memory"), "rejected"], ["notify", "progress", v.Callbacks("memory")]]
      n = "pending"
      r =
        state: ->
          n

        always: ->
          i.done(arguments_).fail(arguments_)
          this

        then: ->
          e = arguments_
          v.Deferred((n) ->
            v.each(t, (t, r) ->
              s = r[0]
              o = e[t]
              i[r[1]] (if v.isFunction(o) then ->
                e = o.apply(this, arguments_)
                (if e and v.isFunction(e.promise) then e.promise().done(n.resolve).fail(n.reject).progress(n.notify) else n[s + "With"]((if this is i then n else this), [e]))
               else n[s])
              )
            e = null
            ).promise()

        promise: (e) ->
          (if e? then v.extend(e, r) else r)

      i = {}
      r.pipe = r.then
      v.each(t, (e, s) ->
        o = s[2]
        u = s[3]
        r[s[1]] = o.add
        u and o.add(->
          n = u
        , t[e ^ 1][2].disable, t[2][2].lock)
        i[s[0]] = o.fire
        i[s[0] + "With"] = o.fireWith
      )
      r.promise(i)
      e and e.call(i, i)
      i

    when: (e) ->
      t = 0
      n = l.call(arguments_)
      r = n.length
      i = (if r isnt 1 or e and v.isFunction(e.promise) then r else 0)
      s = (if i is 1 then e else v.Deferred())
      o = (e, t, n) ->
        (r) ->
          t[e] = this
          n[e] = (if arguments_.length > 1 then l.call(arguments_) else r)
          (if n is u then s.notifyWith(t, n) else --i or s.resolveWith(t, n))

      u = undefined
      a = undefined
      f = undefined
      if r > 1
        u = new Array(r)
        a = new Array(r)
        f = new Array(r)

        while t < r
          (if n[t] and v.isFunction(n[t].promise) then n[t].promise().done(o(t, f, n)).fail(s.reject).progress(o(t, a, u)) else --i)
          t++
      i or s.resolveWith(f, n)
      s.promise()
  )
  v.support = ->
    t = undefined
    n = undefined
    r = undefined
    s = undefined
    o = undefined
    u = undefined
    a = undefined
    f = undefined
    l = undefined
    c = undefined
    h = undefined
    p = i.createElement("div")
    p.setAttribute("className", "t")
    p.innerHTML = "  <link/><table></table><a href='/a'>a</a><input type='checkbox'/>"
    n = p.getElementsByTagName("*")
    r = p.getElementsByTagName("a")[0]

    return {}  if not n or not r or not n.length
    s = i.createElement("select")
    o = s.appendChild(i.createElement("option"))
    u = p.getElementsByTagName("input")[0]
    r.style.cssText = "top:1px;float:left;opacity:.5"
    t =
      leadingWhitespace: p.firstChild.nodeType is 3
      tbody: not p.getElementsByTagName("tbody").length
      htmlSerialize: !!p.getElementsByTagName("link").length
      style: /top/.test(r.getAttribute("style"))
      hrefNormalized: r.getAttribute("href") is "/a"
      opacity: /^0.5/.test(r.style.opacity)
      cssFloat: !!r.style.cssFloat
      checkOn: u.value is "on"
      optSelected: o.selected
      getSetAttribute: p.className isnt "t"
      enctype: !!i.createElement("form").enctype
      html5Clone: i.createElement("nav").cloneNode(not 0).outerHTML isnt "<:nav></:nav>"
      boxModel: i.compatMode is "CSS1Compat"
      submitBubbles: not 0
      changeBubbles: not 0
      focusinBubbles: not 1
      deleteExpando: not 0
      noCloneEvent: not 0
      inlineBlockNeedsLayout: not 1
      shrinkWrapBlocks: not 1
      reliableMarginRight: not 0
      boxSizingReliable: not 0
      pixelPosition: not 1

    u.checked = not 0
    t.noCloneChecked = u.cloneNode(not 0).checked
    s.disabled = not 0
    t.optDisabled = not o.disabled

    try
      delete p.test
    catch d
      t.deleteExpando = not 1
    not p.addEventListener and p.attachEvent and p.fireEvent and (p.attachEvent("onclick", h = ->
      t.noCloneEvent = not 1
    )
    p.cloneNode(not 0).fireEvent("onclick")
    p.detachEvent("onclick", h)
    )
    u = i.createElement("input")
    u.value = "t"
    u.setAttribute("type", "radio")
    t.radioValue = u.value is "t"
    u.setAttribute("checked", "checked")
    u.setAttribute("name", "t")
    p.appendChild(u)
    a = i.createDocumentFragment()
    a.appendChild(p.lastChild)
    t.checkClone = a.cloneNode(not 0).cloneNode(not 0).lastChild.checked
    t.appendChecked = u.checked
    a.removeChild(u)
    a.appendChild(p)

    if p.attachEvent
      for l of
        submit: not 0
        change: not 0
        focusin: not 0
        f = "on" + l
        c = f of p
        c or (p.setAttribute(f, "return;")
        c = typeof p[f] is "function"
        )
        t[l + "Bubbles"] = c
    v(->
      n = undefined
      r = undefined
      s = undefined
      o = undefined
      u = "padding:0;margin:0;border:0;display:block;overflow:hidden;"
      a = i.getElementsByTagName("body")[0]
      return  unless a
      n = i.createElement("div")
      n.style.cssText = "visibility:hidden;border:0;width:0;height:0;position:static;top:0;margin-top:1px"
      a.insertBefore(n, a.firstChild)
      r = i.createElement("div")
      n.appendChild(r)
      r.innerHTML = "<table><tr><td></td><td>t</td></tr></table>"
      s = r.getElementsByTagName("td")
      s[0].style.cssText = "padding:0;margin:0;border:0;display:none"
      c = s[0].offsetHeight is 0
      s[0].style.display = ""
      s[1].style.display = "none"
      t.reliableHiddenOffsets = c and s[0].offsetHeight is 0
      r.innerHTML = ""
      r.style.cssText = "box-sizing:border-box;-moz-box-sizing:border-box;-webkit-box-sizing:border-box;padding:1px;border:1px;display:block;width:4px;margin-top:1%;position:absolute;top:1%;"
      t.boxSizing = r.offsetWidth is 4
      t.doesNotIncludeMarginInBodyOffset = a.offsetTop isnt 1
      e.getComputedStyle and (t.pixelPosition = (e.getComputedStyle(r, null) or {}).top isnt "1%"
      t.boxSizingReliable = (e.getComputedStyle(r, null) or width: "4px").width is "4px"
      o = i.createElement("div")
      o.style.cssText = r.style.cssText = u
      o.style.marginRight = o.style.width = "0"
      r.style.width = "1px"
      r.appendChild(o)
      t.reliableMarginRight = not parseFloat((e.getComputedStyle(o, null) or {}).marginRight)
      )
      typeof r.style.zoom isnt "undefined" and (r.innerHTML = ""
      r.style.cssText = u + "width:1px;padding:1px;display:inline;zoom:1"
      t.inlineBlockNeedsLayout = r.offsetWidth is 3
      r.style.display = "block"
      r.style.overflow = "visible"
      r.innerHTML = "<div></div>"
      r.firstChild.style.width = "5px"
      t.shrinkWrapBlocks = r.offsetWidth isnt 3
      n.style.zoom = 1
      )
      a.removeChild(n)
      n = r = s = o = null
    )
    a.removeChild(p)
    n = r = s = o = u = a = p = null
    t
  ()

  D = /(?:\{[\s\S]*\}|\[[\s\S]*\])$/
  P = /([A-Z])/g
  v.extend(
    cache: {}
    deletedIds: []
    uuid: 0
    expando: "jQuery" + (v.fn.jquery + Math.random()).replace(/\D/g, "")
    noData:
      embed: not 0
      object: "clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
      applet: not 0

    hasData: (e) ->
      e = (if e.nodeType then v.cache[e[v.expando]] else e[v.expando])
      !!e and not B(e)

    data: (e, n, r, i) ->
      return  unless v.acceptData(e)
      s = undefined
      o = undefined
      u = v.expando
      a = typeof n is "string"
      f = e.nodeType
      l = (if f then v.cache else e)
      c = (if f then e[u] else e[u] and u)
      return  if (not c or not l[c] or not i and not l[c].data) and a and r is t
      c or ((if f then e[u] = c = v.deletedIds.pop() or v.guid++ else c = u))
      l[c] or (l[c] = {}
      f or (l[c].toJSON = v.noop)
      )

      (if i then l[c] = v.extend(l[c], n) else l[c].data = v.extend(l[c].data, n))  if typeof n is "object" or typeof n is "function"
      s = l[c]
      i or (s.data or (s.data = {})
      s = s.data
      )
      r isnt t and (s[v.camelCase(n)] = r)
      (if a then (o = s[n]
      not o? and (o = s[v.camelCase(n)])
      ) else o = s)
      o

    removeData: (e, t, n) ->
      return  unless v.acceptData(e)
      r = undefined
      i = undefined
      s = undefined
      o = e.nodeType
      u = (if o then v.cache else e)
      a = (if o then e[v.expando] else v.expando)
      return  unless u[a]
      if t
        r = (if n then u[a] else u[a].data)
        if r
          v.isArray(t) or ((if t of r then t = [t] else (t = v.camelCase(t)
          (if t of r then t = [t] else t = t.split(" "))
          )))
          i = 0
          s = t.length

          while i < s
            delete r[t[i]]
            i++
          return  unless ((if n then B else v.isEmptyObject))(r)
      unless n
        delete u[a].data

        return  unless B(u[a])
      (if o then v.cleanData([e], not 0) else (if v.support.deleteExpando or u isnt u.window then delete u[a]
       else u[a] = null))

    _data: (e, t, n) ->
      v.data e, t, n, not 0

    acceptData: (e) ->
      t = e.nodeName and v.noData[e.nodeName.toLowerCase()]
      not t or t isnt not 0 and e.getAttribute("classid") is t
  )
  v.fn.extend(
    data: (e, n) ->
      r = undefined
      i = undefined
      s = undefined
      o = undefined
      u = undefined
      a = this[0]
      f = 0
      l = null
      if e is t
        if @length
          l = v.data(a)
          if a.nodeType is 1 and not v._data(a, "parsedAttrs")
            s = a.attributes
            u = s.length
            while f < u
              o = s[f].name
              o.indexOf("data-") or (o = v.camelCase(o.substring(5))
              H(a, o, l[o])
              )
              f++
            v._data a, "parsedAttrs", not 0
        return l
      (if typeof e is "object" then @each(->
        v.data this, e
      ) else (r = e.split(".", 2)
      r[1] = (if r[1] then "." + r[1] else "")
      i = r[1] + "!"
      v.access(this, (n) ->
        if n is t
          return l = @triggerHandler("getData" + i, [r[0]])
          l is t and a and (l = v.data(a, e)
          l = H(a, e, l)
          )
          (if l is t and r[1] then @data(r[0]) else l)
        r[1] = n
        @each(->
          t = v(this)
          t.triggerHandler("setData" + i, r)
          v.data(this, e, n)
          t.triggerHandler("changeData" + i, r)
        )
      , null, n, arguments_.length > 1, null, not 1)
      ))

    removeData: (e) ->
      @each ->
        v.removeData this, e

  )
  v.extend(
    queue: (e, t, n) ->
      r = undefined
      if e
        t = (t or "fx") + "queue"
        r = v._data(e, t)
        n and ((if not r or v.isArray(n) then r = v._data(e, t, v.makeArray(n)) else r.push(n)))
        r or []

    dequeue: (e, t) ->
      t = t or "fx"
      n = v.queue(e, t)
      r = n.length
      i = n.shift()
      s = v._queueHooks(e, t)
      o = ->
        v.dequeue e, t

      i is "inprogress" and (i = n.shift()
      r--
      )
      i and (t is "fx" and n.unshift("inprogress")
      delete s.stop

      i.call(e, o, s)
      )
      not r and s and s.empty.fire()

    _queueHooks: (e, t) ->
      n = t + "queueHooks"
      v._data(e, n) or v._data(e, n,
        empty: v.Callbacks("once memory").add(->
          v.removeData(e, t + "queue", not 0)
          v.removeData(e, n, not 0)
        )
      )
  )
  v.fn.extend(
    queue: (e, n) ->
      r = 2
      typeof e isnt "string" and (n = e
      e = "fx"
      r--
      )
      (if arguments_.length < r then v.queue(this[0], e) else (if n is t then this else @each(->
        t = v.queue(this, e, n)
        v._queueHooks(this, e)
        e is "fx" and t[0] isnt "inprogress" and v.dequeue(this, e)
      )))

    dequeue: (e) ->
      @each ->
        v.dequeue this, e


    delay: (e, t) ->
      e = (if v.fx then v.fx.speeds[e] or e else e)
      t = t or "fx"
      @queue(t, (t, n) ->
        r = setTimeout(t, e)
        n.stop = ->
          clearTimeout r
      )

    clearQueue: (e) ->
      @queue e or "fx", []

    promise: (e, n) ->
      r = undefined
      i = 1
      s = v.Deferred()
      o = this
      u = @length
      a = ->
        --i or s.resolveWith(o, [o])

      typeof e isnt "string" and (n = e
      e = t
      )
      e = e or "fx"

      while u--
        r = v._data(o[u], e + "queueHooks")
        r and r.empty and (i++
        r.empty.add(a)
        )
      a()
      s.promise(n)
  )

  j = undefined
  F = undefined
  I = undefined
  q = /[\t\r\n]/g
  R = /\r/g
  U = /^(?:button|input)$/i
  z = /^(?:button|input|object|select|textarea)$/i
  W = /^a(?:rea|)$/i
  X = /^(?:autofocus|autoplay|async|checked|controls|defer|disabled|hidden|loop|multiple|open|readonly|required|scoped|selected)$/i
  V = v.support.getSetAttribute
  v.fn.extend(
    attr: (e, t) ->
      v.access this, v.attr, e, t, arguments_.length > 1

    removeAttr: (e) ->
      @each ->
        v.removeAttr this, e


    prop: (e, t) ->
      v.access this, v.prop, e, t, arguments_.length > 1

    removeProp: (e) ->
      e = v.propFix[e] or e
      @each(->
        try
          this[e] = t
          delete this[e]
      )

    addClass: (e) ->
      t = undefined
      n = undefined
      r = undefined
      i = undefined
      s = undefined
      o = undefined
      u = undefined
      if v.isFunction(e)
        return @each((t) ->
          v(this).addClass e.call(this, t, @className)
        )
      if e and typeof e is "string"
        t = e.split(y)
        n = 0
        r = @length

        while n < r
          i = this[n]
          if i.nodeType is 1
            unless not i.className and t.length is 1
              s = " " + i.className + " "
              o = 0
              u = t.length

              while o < u
                s.indexOf(" " + t[o] + " ") < 0 and (s += t[o] + " ")
                o++
              i.className = v.trim(s)
          n++
      this

    removeClass: (e) ->
      n = undefined
      r = undefined
      i = undefined
      s = undefined
      o = undefined
      u = undefined
      a = undefined
      if v.isFunction(e)
        return @each((t) ->
          v(this).removeClass e.call(this, t, @className)
        )
      if e and typeof e is "string" or e is t
        n = (e or "").split(y)
        u = 0
        a = @length

        while u < a
          i = this[u]
          if i.nodeType is 1 and i.className
            r = (" " + i.className + " ").replace(q, " ")
            s = 0
            o = n.length

            while s < o
              r = r.replace(" " + n[s] + " ", " ")  while r.indexOf(" " + n[s] + " ") >= 0
              s++
            i.className = (if e then v.trim(r) else "")
          u++
      this

    toggleClass: (e, t) ->
      n = typeof e
      r = typeof t is "boolean"
      (if v.isFunction(e) then @each((n) ->
        v(this).toggleClass e.call(this, n, @className, t), t
      ) else @each(->
        if n is "string"
          i = undefined
          s = 0
          o = v(this)
          u = t
          a = e.split(y)
          while i = a[s++]
            u = (if r then u else not o.hasClass(i))
            o[(if u then "addClass" else "removeClass")](i)
        else if n is "undefined" or n is "boolean"
          @className and v._data(this, "__className__", @className)
          @className = (if @className or e is not 1 then "" else v._data(this, "__className__") or "")
      ))

    hasClass: (e) ->
      t = " " + e + " "
      n = 0
      r = @length
      while n < r
        return not 0  if this[n].nodeType is 1 and (" " + this[n].className + " ").replace(q, " ").indexOf(t) >= 0
        n++
      not 1

    val: (e) ->
      n = undefined
      r = undefined
      i = undefined
      s = this[0]
      unless arguments_.length
        if s
          return n = v.valHooks[s.type] or v.valHooks[s.nodeName.toLowerCase()]
          (if n and "get" of n and (r = n.get(s, "value")) isnt t then r else (r = s.value
          (if typeof r is "string" then r.replace(R, "") else (if not r? then "" else r))
          ))
        return
      i = v.isFunction(e)
      @each((r) ->
        s = undefined
        o = v(this)
        return  if @nodeType isnt 1
        (if i then s = e.call(this, r, o.val()) else s = e)
        (if not s? then s = "" else (if typeof s is "number" then s += "" else v.isArray(s) and (s = v.map(s, (e) ->
          (if not e? then "" else e + "")
        ))))
        n = v.valHooks[@type] or v.valHooks[@nodeName.toLowerCase()]

        @value = s  if not n or ("set" not of n) or n.set(this, s, "value") is t
      )
  )
  v.extend(
    valHooks:
      option:
        get: (e) ->
          t = e.attributes.value
          (if not t or t.specified then e.value else e.text)

      select:
        get: (e) ->
          t = undefined
          n = undefined
          r = e.options
          i = e.selectedIndex
          s = e.type is "select-one" or i < 0
          o = (if s then null else [])
          u = (if s then i + 1 else r.length)
          a = (if i < 0 then u else (if s then i else 0))
          while a < u
            n = r[a]
            if (n.selected or a is i) and ((if v.support.optDisabled then not n.disabled else n.getAttribute("disabled") is null)) and (not n.parentNode.disabled or not v.nodeName(n.parentNode, "optgroup"))
              t = v(n).val()
              return t  if s
              o.push t
            a++
          o

        set: (e, t) ->
          n = v.makeArray(t)
          v(e).find("option").each(->
            @selected = v.inArray(v(this).val(), n) >= 0
          )
          n.length or (e.selectedIndex = -1)
          n

    attrFn: {}
    attr: (e, n, r, i) ->
      s = undefined
      o = undefined
      u = undefined
      a = e.nodeType
      return  if not e or a is 3 or a is 8 or a is 2
      return v(e)[n](r)  if i and v.isFunction(v.fn[n])
      return v.prop(e, n, r)  if typeof e.getAttribute is "undefined"
      u = a isnt 1 or not v.isXMLDoc(e)
      u and (n = n.toLowerCase()
      o = v.attrHooks[n] or ((if X.test(n) then F else j))
      )

      if r isnt t
        if r is null
          v.removeAttr e, n
          return
        return (if o and "set" of o and u and (s = o.set(e, r, n)) isnt t then s else (e.setAttribute(n, r + "")
        r
        ))
      (if o and "get" of o and u and (s = o.get(e, n)) isnt null then s else (s = e.getAttribute(n)
      (if s is null then t else s)
      ))

    removeAttr: (e, t) ->
      n = undefined
      r = undefined
      i = undefined
      s = undefined
      o = 0
      if t and e.nodeType is 1
        r = t.split(y)
        while o < r.length
          i = r[o]
          i and (n = v.propFix[i] or i
          s = X.test(i)
          s or v.attr(e, i, "")
          e.removeAttribute((if V then i else n))
          s and n of e and (e[n] = not 1)
          )
          o++

    attrHooks:
      type:
        set: (e, t) ->
          if U.test(e.nodeName) and e.parentNode
            v.error "type property can't be changed"
          else if not v.support.radioValue and t is "radio" and v.nodeName(e, "input")
            n = e.value
            e.setAttribute("type", t)
            n and (e.value = n)
            t

      value:
        get: (e, t) ->
          (if j and v.nodeName(e, "button") then j.get(e, t) else (if t of e then e.value else null))

        set: (e, t, n) ->
          return j.set(e, t, n)  if j and v.nodeName(e, "button")
          e.value = t

    propFix:
      tabindex: "tabIndex"
      readonly: "readOnly"
      for: "htmlFor"
      class: "className"
      maxlength: "maxLength"
      cellspacing: "cellSpacing"
      cellpadding: "cellPadding"
      rowspan: "rowSpan"
      colspan: "colSpan"
      usemap: "useMap"
      frameborder: "frameBorder"
      contenteditable: "contentEditable"

    prop: (e, n, r) ->
      i = undefined
      s = undefined
      o = undefined
      u = e.nodeType
      return  if not e or u is 3 or u is 8 or u is 2
      o = u isnt 1 or not v.isXMLDoc(e)
      o and (n = v.propFix[n] or n
      s = v.propHooks[n]
      )
      (if r isnt t then (if s and "set" of s and (i = s.set(e, r, n)) isnt t then i else e[n] = r) else (if s and "get" of s and (i = s.get(e, n)) isnt null then i else e[n]))

    propHooks:
      tabIndex:
        get: (e) ->
          n = e.getAttributeNode("tabindex")
          (if n and n.specified then parseInt(n.value, 10) else (if z.test(e.nodeName) or W.test(e.nodeName) and e.href then 0 else t))
  )
  F =
    get: (e, n) ->
      r = undefined
      i = v.prop(e, n)
      (if i is not 0 or typeof i isnt "boolean" and (r = e.getAttributeNode(n)) and r.nodeValue isnt not 1 then n.toLowerCase() else t)

    set: (e, t, n) ->
      r = undefined
      (if t is not 1 then v.removeAttr(e, n) else (r = v.propFix[n] or n
      r of e and (e[r] = not 0)
      e.setAttribute(n, n.toLowerCase())
      ))
      n

  V or (I =
    name: not 0
    id: not 0
    coords: not 0

  j = v.valHooks.button =
    get: (e, n) ->
      r = undefined
      r = e.getAttributeNode(n)
      (if r and ((if I[n] then r.value isnt "" else r.specified)) then r.value else t)

    set: (e, t, n) ->
      r = e.getAttributeNode(n)
      r or (r = i.createAttribute(n)
      e.setAttributeNode(r)
      )
      r.value = t + ""

  v.each(["width", "height"], (e, t) ->
    v.attrHooks[t] = v.extend(v.attrHooks[t],
      set: (e, n) ->
        if n is ""
          e.setAttribute(t, "auto")
          n
    )
  )
  v.attrHooks.contenteditable =
    get: j.get
    set: (e, t, n) ->
      t is "" and (t = "false")
      j.set(e, t, n)

  )
  v.support.hrefNormalized or v.each(["href", "src", "width", "height"], (e, n) ->
    v.attrHooks[n] = v.extend(v.attrHooks[n],
      get: (e) ->
        r = e.getAttribute(n, 2)
        (if r is null then t else r)
    )
  )
  v.support.style or (v.attrHooks.style =
    get: (e) ->
      e.style.cssText.toLowerCase() or t

    set: (e, t) ->
      e.style.cssText = t + ""
  )
  v.support.optSelected or (v.propHooks.selected = v.extend(v.propHooks.selected,
    get: (e) ->
      t = e.parentNode
      t and (t.selectedIndex
      t.parentNode and t.parentNode.selectedIndex
      )
      null
  ))
  v.support.enctype or (v.propFix.enctype = "encoding")
  v.support.checkOn or v.each(["radio", "checkbox"], ->
    v.valHooks[this] = get: (e) ->
      (if e.getAttribute("value") is null then "on" else e.value)
  )
  v.each(["radio", "checkbox"], ->
    v.valHooks[this] = v.extend(v.valHooks[this],
      set: (e, t) ->
        e.checked = v.inArray(v(e).val(), t) >= 0  if v.isArray(t)
    )
  )

  $ = /^(?:textarea|input|select)$/i
  J = /^([^\.]*|)(?:\.(.+)|)$/
  K = /(?:^|\s)hover(\.\S+|)\b/
  Q = /^key/
  G = /^(?:mouse|contextmenu)|click/
  Y = /^(?:focusinfocus|focusoutblur)$/
  Z = (e) ->
    (if v.event.special.hover then e else e.replace(K, "mouseenter$1 mouseleave$1"))

  v.event =
    add: (e, n, r, i, s) ->
      o = undefined
      u = undefined
      a = undefined
      f = undefined
      l = undefined
      c = undefined
      h = undefined
      p = undefined
      d = undefined
      m = undefined
      g = undefined
      return  if e.nodeType is 3 or e.nodeType is 8 or not n or not r or not (o = v._data(e))
      r.handler and (d = r
      r = d.handler
      s = d.selector
      )
      r.guid or (r.guid = v.guid++)
      a = o.events
      a or (o.events = a = {})
      u = o.handle
      u or (o.handle = u = (e) ->
        (if typeof v is "undefined" or !!e and v.event.triggered is e.type then t else v.event.dispatch.apply(u.elem, arguments_))

      u.elem = e
      )
      n = v.trim(Z(n)).split(" ")

      f = 0
      while f < n.length
        l = J.exec(n[f]) or []
        c = l[1]
        h = (l[2] or "").split(".").sort()
        g = v.event.special[c] or {}
        c = ((if s then g.delegateType else g.bindType)) or c
        g = v.event.special[c] or {}
        p = v.extend(
          type: c
          origType: l[1]
          data: i
          handler: r
          guid: r.guid
          selector: s
          needsContext: s and v.expr.match.needsContext.test(s)
          namespace: h.join(".")
        , d)
        m = a[c]

        unless m
          m = a[c] = []
          m.delegateCount = 0

          (if e.addEventListener then e.addEventListener(c, u, not 1) else e.attachEvent and e.attachEvent("on" + c, u))  if not g.setup or g.setup.call(e, i, h, u) is not 1
        g.add and (g.add.call(e, p)
        p.handler.guid or (p.handler.guid = r.guid)
        )
        (if s then m.splice(m.delegateCount++, 0, p) else m.push(p))
        v.event.global[c] = not 0
        f++
      e = null

    global: {}
    remove: (e, t, n, r, i) ->
      s = undefined
      o = undefined
      u = undefined
      a = undefined
      f = undefined
      l = undefined
      c = undefined
      h = undefined
      p = undefined
      d = undefined
      m = undefined
      g = v.hasData(e) and v._data(e)
      return  if not g or not (h = g.events)
      t = v.trim(Z(t or "")).split(" ")
      s = 0
      while s < t.length
        o = J.exec(t[s]) or []
        u = a = o[1]
        f = o[2]

        unless u
          for u of h
            v.event.remove e, u + t[s], n, r, not 0
          continue
        p = v.event.special[u] or {}
        u = ((if r then p.delegateType else p.bindType)) or u
        d = h[u] or []
        l = d.length
        f = (if f then new RegExp("(^|\\.)" + f.split(".").sort().join("\\.(?:.*\\.|)") + "(\\.|$)") else null)

        c = 0
        while c < d.length
          m = d[c]
          (i or a is m.origType) and (not n or n.guid is m.guid) and (not f or f.test(m.namespace)) and (not r or r is m.selector or r is "**" and m.selector) and (d.splice(c--, 1)
          m.selector and d.delegateCount--
          p.remove and p.remove.call(e, m)
          )
          c++
        d.length is 0 and l isnt d.length and ((not p.teardown or p.teardown.call(e, f, g.handle) is not 1) and v.removeEvent(e, u, g.handle)
        delete h[u]

        )
        s++
      v.isEmptyObject(h) and (delete g.handle

      v.removeData(e, "events", not 0)
      )

    customEvent:
      getData: not 0
      setData: not 0
      changeData: not 0

    trigger: (n, r, s, o) ->
      if not s or s.nodeType isnt 3 and s.nodeType isnt 8
        u = undefined
        a = undefined
        f = undefined
        l = undefined
        c = undefined
        h = undefined
        p = undefined
        d = undefined
        m = undefined
        g = undefined
        y = n.type or n
        b = []
        return  if Y.test(y + v.event.triggered)
        y.indexOf("!") >= 0 and (y = y.slice(0, -1)
        a = not 0
        )
        y.indexOf(".") >= 0 and (b = y.split(".")
        y = b.shift()
        b.sort()
        )

        return  if (not s or v.event.customEvent[y]) and not v.event.global[y]
        n = (if typeof n is "object" then (if n[v.expando] then n else new v.Event(y, n)) else new v.Event(y))
        n.type = y
        n.isTrigger = not 0
        n.exclusive = a
        n.namespace = b.join(".")
        n.namespace_re = (if n.namespace then new RegExp("(^|\\.)" + b.join("\\.(?:.*\\.|)") + "(\\.|$)") else null)
        h = (if y.indexOf(":") < 0 then "on" + y else "")

        unless s
          u = v.cache
          for f of u
            u[f].events and u[f].events[y] and v.event.trigger(n, r, u[f].handle.elem, not 0)
          return
        n.result = t
        n.target or (n.target = s)
        r = (if r? then v.makeArray(r) else [])
        r.unshift(n)
        p = v.event.special[y] or {}

        return  if p.trigger and p.trigger.apply(s, r) is not 1
        m = [[s, p.bindType or y]]
        if not o and not p.noBubble and not v.isWindow(s)
          g = p.delegateType or y
          l = (if Y.test(g + y) then s else s.parentNode)

          c = s
          while l
            m.push([l, g])
            c = l
            l = l.parentNode
          c is (s.ownerDocument or i) and m.push([c.defaultView or c.parentWindow or e, g])
        f = 0
        while f < m.length and not n.isPropagationStopped()
          l = m[f][0]
          n.type = m[f][1]
          d = (v._data(l, "events") or {})[n.type] and v._data(l, "handle")
          d and d.apply(l, r)
          d = h and l[h]
          d and v.acceptData(l) and d.apply and d.apply(l, r) is not 1 and n.preventDefault()
          f++
        return n.type = y
        not o and not n.isDefaultPrevented() and (not p._default or p._default.apply(s.ownerDocument, r) is not 1) and (y isnt "click" or not v.nodeName(s, "a")) and v.acceptData(s) and h and s[y] and (y isnt "focus" and y isnt "blur" or n.target.offsetWidth isnt 0) and not v.isWindow(s) and (c = s[h]
        c and (s[h] = null)
        v.event.triggered = y
        s[y]()
        v.event.triggered = t
        c and (s[h] = c)
        )
        n.result
      return

    dispatch: (n) ->
      n = v.event.fix(n or e.event)
      r = undefined
      i = undefined
      s = undefined
      o = undefined
      u = undefined
      a = undefined
      f = undefined
      c = undefined
      h = undefined
      p = undefined
      d = (v._data(this, "events") or {})[n.type] or []
      m = d.delegateCount
      g = l.call(arguments_)
      y = not n.exclusive and not n.namespace
      b = v.event.special[n.type] or {}
      w = []
      g[0] = n
      n.delegateTarget = this

      return  if b.preDispatch and b.preDispatch.call(this, n) is not 1
      if m and (not n.button or n.type isnt "click")
        s = n.target
        while s isnt this
          if s.disabled isnt not 0 or n.type isnt "click"
            u = {}
            f = []

            r = 0
            while r < m
              c = d[r]
              h = c.selector
              u[h] is t and (u[h] = (if c.needsContext then v(h, this).index(s) >= 0 else v.find(h, this, null, [s]).length))
              u[h] and f.push(c)
              r++
            f.length and w.push(
              elem: s
              matches: f
            )
          s = s.parentNode or this
      d.length > m and w.push(
        elem: this
        matches: d.slice(m)
      )
      r = 0
      while r < w.length and not n.isPropagationStopped()
        a = w[r]
        n.currentTarget = a.elem

        i = 0
        while i < a.matches.length and not n.isImmediatePropagationStopped()
          c = a.matches[i]
          if y or not n.namespace and not c.namespace or n.namespace_re and n.namespace_re.test(c.namespace)
            n.data = c.data
            n.handleObj = c
            o = ((v.event.special[c.origType] or {}).handle or c.handler).apply(a.elem, g)
            o isnt t and (n.result = o
            o is not 1 and (n.preventDefault()
            n.stopPropagation()
            )
            )
          i++
        r++
      b.postDispatch and b.postDispatch.call(this, n)
      n.result

    props: "attrChange attrName relatedNode srcElement altKey bubbles cancelable ctrlKey currentTarget eventPhase metaKey relatedTarget shiftKey target timeStamp view which".split(" ")
    fixHooks: {}
    keyHooks:
      props: "char charCode key keyCode".split(" ")
      filter: (e, t) ->
        not e.which? and (e.which = (if t.charCode? then t.charCode else t.keyCode))
        e

    mouseHooks:
      props: "button buttons clientX clientY fromElement offsetX offsetY pageX pageY screenX screenY toElement".split(" ")
      filter: (e, n) ->
        r = undefined
        s = undefined
        o = undefined
        u = n.button
        a = n.fromElement
        not e.pageX? and n.clientX? and (r = e.target.ownerDocument or i
        s = r.documentElement
        o = r.body
        e.pageX = n.clientX + (s and s.scrollLeft or o and o.scrollLeft or 0) - (s and s.clientLeft or o and o.clientLeft or 0)
        e.pageY = n.clientY + (s and s.scrollTop or o and o.scrollTop or 0) - (s and s.clientTop or o and o.clientTop or 0)
        )
        not e.relatedTarget and a and (e.relatedTarget = (if a is e.target then n.toElement else a))
        not e.which and u isnt t and (e.which = (if u & 1 then 1 else (if u & 2 then 3 else (if u & 4 then 2 else 0))))
        e

    fix: (e) ->
      return e  if e[v.expando]
      t = undefined
      n = undefined
      r = e
      s = v.event.fixHooks[e.type] or {}
      o = (if s.props then @props.concat(s.props) else @props)
      e = v.Event(r)
      t = o.length
      while t
        n = o[--t]
        e[n] = r[n]
      e.target or (e.target = r.srcElement or i)
      e.target.nodeType is 3 and (e.target = e.target.parentNode)
      e.metaKey = !!e.metaKey
      (if s.filter then s.filter(e, r) else e)

    special:
      load:
        noBubble: not 0

      focus:
        delegateType: "focusin"

      blur:
        delegateType: "focusout"

      beforeunload:
        setup: (e, t, n) ->
          v.isWindow(this) and (@onbeforeunload = n)

        teardown: (e, t) ->
          @onbeforeunload is t and (@onbeforeunload = null)

    simulate: (e, t, n, r) ->
      i = v.extend(new v.Event, n,
        type: e
        isSimulated: not 0
        originalEvent: {}
      )
      (if r then v.event.trigger(i, null, t) else v.event.dispatch.call(t, i))
      i.isDefaultPrevented() and n.preventDefault()

  v.event.handle = v.event.dispatch
  v.removeEvent = (if i.removeEventListener then (e, t, n) ->
    e.removeEventListener and e.removeEventListener(t, n, not 1)
   else (e, t, n) ->
    r = "on" + t
    e.detachEvent and (typeof e[r] is "undefined" and (e[r] = null)
    e.detachEvent(r, n)
    )
  )
  v.Event = (e, t) ->
    return new v.Event(e, t)  unless this instanceof v.Event
    (if e and e.type then (@originalEvent = e
    @type = e.type
    @isDefaultPrevented = (if e.defaultPrevented or e.returnValue is not 1 or e.getPreventDefault and e.getPreventDefault() then tt else et)
    ) else @type = e)
    t and v.extend(this, t)
    @timeStamp = e and e.timeStamp or v.now()
    this[v.expando] = not 0

  v.Event:: =
    preventDefault: ->
      @isDefaultPrevented = tt
      e = @originalEvent
      return  unless e
      (if e.preventDefault then e.preventDefault() else e.returnValue = not 1)

    stopPropagation: ->
      @isPropagationStopped = tt
      e = @originalEvent
      return  unless e
      e.stopPropagation and e.stopPropagation()
      e.cancelBubble = not 0

    stopImmediatePropagation: ->
      @isImmediatePropagationStopped = tt
      @stopPropagation()

    isDefaultPrevented: et
    isPropagationStopped: et
    isImmediatePropagationStopped: et

  v.each(
    mouseenter: "mouseover"
    mouseleave: "mouseout"
  , (e, t) ->
    v.event.special[e] =
      delegateType: t
      bindType: t
      handle: (e) ->
        n = undefined
        r = this
        i = e.relatedTarget
        s = e.handleObj
        o = s.selector
        if not i or i isnt r and not v.contains(r, i)
          e.type = s.origType
          n = s.handler.apply(this, arguments_)
          e.type = t
        n
  )
  v.support.submitBubbles or (v.event.special.submit =
    setup: ->
      return not 1  if v.nodeName(this, "form")
      v.event.add this, "click._submit keypress._submit", (e) ->
        n = e.target
        r = (if v.nodeName(n, "input") or v.nodeName(n, "button") then n.form else t)
        r and not v._data(r, "_submit_attached") and (v.event.add(r, "submit._submit", (e) ->
          e._submit_bubble = not 0
        )
        v._data(r, "_submit_attached", not 0)
        )


    postDispatch: (e) ->
      e._submit_bubble and (delete e._submit_bubble

      @parentNode and not e.isTrigger and v.event.simulate("submit", @parentNode, e, not 0)
      )

    teardown: ->
      return not 1  if v.nodeName(this, "form")
      v.event.remove this, "._submit"
  )
  v.support.changeBubbles or (v.event.special.change =
    setup: ->
      if $.test(@nodeName)
        if @type is "checkbox" or @type is "radio"
          v.event.add(this, "propertychange._change", (e) ->
            e.originalEvent.propertyName is "checked" and (@_just_changed = not 0)
          )
          v.event.add(this, "click._change", (e) ->
            @_just_changed and not e.isTrigger and (@_just_changed = not 1)
            v.event.simulate("change", this, e, not 0)
          )
        return not 1
      v.event.add this, "beforeactivate._change", (e) ->
        t = e.target
        $.test(t.nodeName) and not v._data(t, "_change_attached") and (v.event.add(t, "change._change", (e) ->
          @parentNode and not e.isSimulated and not e.isTrigger and v.event.simulate("change", @parentNode, e, not 0)
        )
        v._data(t, "_change_attached", not 0)
        )


    handle: (e) ->
      t = e.target
      e.handleObj.handler.apply this, arguments_  if this isnt t or e.isSimulated or e.isTrigger or t.type isnt "radio" and t.type isnt "checkbox"

    teardown: ->
      v.event.remove(this, "._change")
      not $.test(@nodeName)
  )
  v.support.focusinBubbles or v.each(
    focus: "focusin"
    blur: "focusout"
  , (e, t) ->
    n = 0
    r = (e) ->
      v.event.simulate t, e.target, v.event.fix(e), not 0

    v.event.special[t] =
      setup: ->
        n++ is 0 and i.addEventListener(e, r, not 0)

      teardown: ->
        --n is 0 and i.removeEventListener(e, r, not 0)
  )
  v.fn.extend(
    on: (e, n, r, i, s) ->
      o = undefined
      u = undefined
      if typeof e is "object"
        typeof n isnt "string" and (r = r or n
        n = t
        )
        for u of e
          @on u, n, r, e[u], s
        return this
      (if not r? and not i? then (i = n
      r = n = t
      ) else not i? and ((if typeof n is "string" then (i = r
      r = t
      ) else (i = r
      r = n
      n = t
      ))))
      if i is not 1
        i = et
      else return this  unless i
      s is 1 and (o = i
      i = (e) ->
        v().off(e)
        o.apply(this, arguments_)

      i.guid = o.guid or (o.guid = v.guid++)
      )
      @each(->
        v.event.add this, e, i, r, n
      )

    one: (e, t, n, r) ->
      @on e, t, n, r, 1

    off: (e, n, r) ->
      i = undefined
      s = undefined
      if e and e.preventDefault and e.handleObj
        return i = e.handleObj
        v(e.delegateTarget).off((if i.namespace then i.origType + "." + i.namespace else i.origType), i.selector, i.handler)
        this
      if typeof e is "object"
        for s of e
          @off s, n, e[s]
        return this
      if n is not 1 or typeof n is "function"
        r = n
        n = t
      r is not 1 and (r = et)
      @each(->
        v.event.remove this, e, r, n
      )

    bind: (e, t, n) ->
      @on e, null, t, n

    unbind: (e, t) ->
      @off e, null, t

    live: (e, t, n) ->
      v(@context).on(e, @selector, t, n)
      this

    die: (e, t) ->
      v(@context).off(e, @selector or "**", t)
      this

    delegate: (e, t, n, r) ->
      @on t, e, n, r

    undelegate: (e, t, n) ->
      (if arguments_.length is 1 then @off(e, "**") else @off(t, e or "**", n))

    trigger: (e, t) ->
      @each ->
        v.event.trigger e, t, this


    triggerHandler: (e, t) ->
      v.event.trigger e, t, this[0], not 0  if this[0]

    toggle: (e) ->
      t = arguments_
      n = e.guid or v.guid++
      r = 0
      i = (n) ->
        i = (v._data(this, "lastToggle" + e.guid) or 0) % r
        v._data(this, "lastToggle" + e.guid, i + 1)
        n.preventDefault()
        t[i].apply(this, arguments_) or not 1

      i.guid = n
      t[r++].guid = n  while r < t.length
      @click i

    hover: (e, t) ->
      @mouseenter(e).mouseleave t or e
  )
  v.each("blur focus focusin focusout load resize scroll unload click dblclick mousedown mouseup mousemove mouseover mouseout mouseenter mouseleave change select submit keydown keypress keyup error contextmenu".split(" "), (e, t) ->
    v.fn[t] = (e, n) ->
      not n? and (n = e
      e = null
      )
      (if arguments_.length > 0 then @on(t, null, e, n) else @trigger(t))

    Q.test(t) and (v.event.fixHooks[t] = v.event.keyHooks)
    G.test(t) and (v.event.fixHooks[t] = v.event.mouseHooks)
  )
  (e, t) ->
    nt = (e, t, n, r) ->
      n = n or []
      t = t or g

      i = undefined
      s = undefined
      a = undefined
      f = undefined
      l = t.nodeType
      return n  if not e or typeof e isnt "string"
      return []  if l isnt 1 and l isnt 9
      a = o(t)
      if not a and not r
        if i = R.exec(e)
          if f = i[1]
            if l is 9
              s = t.getElementById(f)
              return n  if not s or not s.parentNode
              if s.id is f
                return n.push(s)
                n
            else if t.ownerDocument and (s = t.ownerDocument.getElementById(f)) and u(t, s) and s.id is f
              return n.push(s)
              n
          else
            if i[2]
              return S.apply(n, x.call(t.getElementsByTagName(e), 0))
              n
            if (f = i[3]) and Z and t.getElementsByClassName
              return S.apply(n, x.call(t.getElementsByClassName(f), 0))
              n
      vt e.replace(j, "$1"), t, n, r, a
    rt = (e) ->
      (t) ->
        n = t.nodeName.toLowerCase()
        n is "input" and t.type is e
    it = (e) ->
      (t) ->
        n = t.nodeName.toLowerCase()
        (n is "input" or n is "button") and t.type is e
    st = (e) ->
      N (t) ->
        t = +t
        N((n, r) ->
          i = undefined
          s = e([], n.length, t)
          o = s.length
          n[i = s[o]] and (n[i] = not (r[i] = n[i]))  while o--
        )

    ot = (e, t, n) ->
      return n  if e is t
      r = e.nextSibling
      while r
        return -1  if r is t
        r = r.nextSibling
      1
    ut = (e, t) ->
      n = undefined
      r = undefined
      s = undefined
      o = undefined
      u = undefined
      a = undefined
      f = undefined
      l = L[d][e + " "]
      return (if t then 0 else l.slice(0))  if l
      u = e
      a = []
      f = i.preFilter

      while u
        if not n or (r = F.exec(u))
          r and (u = u.slice(r[0].length) or u)
          a.push(s = [])
        n = not 1
        if r = I.exec(u)
          s.push(n = new m(r.shift()))
          u = u.slice(n.length)
          n.type = r[0].replace(j, " ")
        for o of i.filter
          (r = J[o].exec(u)) and (not f[o] or (r = f[o](r))) and (s.push(n = new m(r.shift()))
          u = u.slice(n.length)
          n.type = o
          n.matches = r
          )
        break  unless n
      (if t then u.length else (if u then nt.error(e) else L(e, a).slice(0)))
    at = (e, t, r) ->
      i = t.dir
      s = r and t.dir is "parentNode"
      o = w++
      (if t.first then (t, n, r) ->
        return e(t, n, r)  if s or t.nodeType is 1  while t = t[i]
       else (t, r, u) ->
        unless u
          a = undefined
          f = b + " " + o + " "
          l = f + n
          while t = t[i]
            if s or t.nodeType is 1
              return t.sizset  if (a = t[d]) is l
              if typeof a is "string" and a.indexOf(f) is 0
                return t  if t.sizset
              else
                t[d] = l
                if e(t, r, u)
                  return t.sizset = not 0
                  t
                t.sizset = not 1
        else
          return t  if e(t, r, u)  if s or t.nodeType is 1  while t = t[i]
      )
    ft = (e) ->
      (if e.length > 1 then (t, n, r) ->
        i = e.length
        return not 1  unless e[i](t, n, r)  while i--
        not 0
       else e[0])
    lt = (e, t, n, r, i) ->
      s = undefined
      o = []
      u = 0
      a = e.length
      f = t?
      while u < a
        if s = e[u]
          if not n or n(s, r, i)
            o.push(s)
            f and t.push(u)
        u++
      o
    ct = (e, t, n, r, i, s) ->
      r and not r[d] and (r = ct(r))
      i and not i[d] and (i = ct(i, s))
      N((s, o, u, a) ->
        f = undefined
        l = undefined
        c = undefined
        h = []
        p = []
        d = o.length
        v = s or dt(t or "*", (if u.nodeType then [u] else u), [])
        m = (if e and (s or not t) then lt(v, h, e, u, a) else v)
        g = (if n then (if i or ((if s then e else d or r)) then [] else o) else m)
        n and n(m, g, u, a)
        if r
          f = lt(g, p)
          r(f, [], u, a)
          l = f.length

          g[p[l]] = not (m[p[l]] = c)  if c = f[l]  while l--
        if s
          if i or e
            if i
              f = []
              l = g.length

              (c = g[l]) and f.push(m[l] = c)  while l--
              i null, g = [], f, a
            l = g.length
            (c = g[l]) and (f = (if i then T.call(s, c) else h[l])) > -1 and (s[f] = not (o[f] = c))  while l--
        else
          g = lt((if g is o then g.splice(d, g.length) else g))
          (if i then i(null, o, g, a) else S.apply(o, g))
      )
    ht = (e) ->
      t = undefined
      n = undefined
      r = undefined
      s = e.length
      o = i.relative[e[0].type]
      u = o or i.relative[" "]
      a = (if o then 1 else 0)
      f = at((e) ->
        e is t
      , u, not 0)
      l = at((e) ->
        T.call(t, e) > -1
      , u, not 0)
      h = [(e, n, r) ->
        not o and (r or n isnt c) or ((if (t = n).nodeType then f(e, n, r) else l(e, n, r)))
      ]
      while a < s
        unless n = i.relative[e[a].type]
          n = i.filter[e[a].type].apply(null, e[a].matches)
          if n[d]
            r = ++a
            while r < s
              break  if i.relative[e[r].type]
              r++
            return ct(a > 1 and ft(h), a > 1 and e.slice(0, a - 1).join("").replace(j, "$1"), n, a < r and ht(e.slice(a, r)), r < s and ht(e = e.slice(r)), r < s and e.join(""))
          h.push n
        a++
      ft h
    pt = (e, t) ->
      r = t.length > 0
      s = e.length > 0
      o = (u, a, f, l, h) ->
        p = undefined
        d = undefined
        v = undefined
        m = []
        y = 0
        w = "0"
        x = u and []
        T = h?
        N = c
        C = u or s and i.find.TAG("*", h and a.parentNode or a)
        k = b += (if not N? then 1 else Math.E)
        T and (c = a isnt g and a
        n = o.el
        )
        while (p = C[w])?
          if s and p
            d = 0
            while v = e[d]
              if v(p, a, f)
                l.push p
                break
              d++
            T and (b = k
            n = ++o.el
            )
          r and ((p = not v and p) and y--
          u and x.push(p)
          )
          w++
        y += w
        if r and w isnt y
          d = 0
          while v = t[d]
            v x, m, a, f
            d++
          if u
            not x[w] and not m[w] and (m[w] = E.call(l))  while w--  if y > 0
            m = lt(m)
          S.apply(l, m)
          T and not u and m.length > 0 and y + t.length > 1 and nt.uniqueSort(l)
        T and (b = k
        c = N
        )
        x

      o.el = 0
      (if r then N(o) else o)
    dt = (e, t, n) ->
      r = 0
      i = t.length
      while r < i
        nt e, t[r], n
        r++
      n
    vt = (e, t, n, r, s) ->
      o = undefined
      u = undefined
      f = undefined
      l = undefined
      c = undefined
      h = ut(e)
      p = h.length
      if not r and h.length is 1
        u = h[0] = h[0].slice(0)
        if u.length > 2 and (f = u[0]).type is "ID" and t.nodeType is 9 and not s and i.relative[u[1].type]
          t = i.find.ID(f.matches[0].replace($, ""), t, s)[0]
          return n  unless t
          e = e.slice(u.shift().length)
        o = (if J.POS.test(e) then -1 else u.length - 1)
        while o >= 0
          f = u[o]
          break  if i.relative[l = f.type]
          if c = i.find[l]
            if r = c(f.matches[0].replace($, ""), z.test(u[0].type) and t.parentNode or t, s)
              u.splice(o, 1)
              e = r.length and u.join("")

              unless e
                return S.apply(n, x.call(r, 0))
                n
              break
          o--
      a(e, h)(r, t, s, n, z.test(e))
      n
    mt = ->
    n = undefined
    r = undefined
    i = undefined
    s = undefined
    o = undefined
    u = undefined
    a = undefined
    f = undefined
    l = undefined
    c = undefined
    h = not 0
    p = "undefined"
    d = ("sizcache" + Math.random()).replace(".", "")
    m = String
    g = e.document
    y = g.documentElement
    b = 0
    w = 0
    E = [].pop
    S = [].push
    x = [].slice
    T = [].indexOf or (e) ->
      t = 0
      n = @length
      while t < n
        return t  if this[t] is e
        t++
      -1

    N = (e, t) ->
      e[d] = not t? or t
      e

    C = ->
      e = {}
      t = []
      N ((n, r) ->
        t.push(n) > i.cacheLength and delete e[t.shift()]

        e[n + " "] = r
      ), e

    k = C()
    L = C()
    A = C()
    O = "[\\x20\\t\\r\\n\\f]"
    M = "(?:\\\\.|[-\\w]|[^\\x00-\\xa0])+"
    _ = M.replace("w", "w#")
    D = "([*^$|!~]?=)"
    P = "\\[" + O + "*(" + M + ")" + O + "*(?:" + D + O + "*(?:(['\"])((?:\\\\.|[^\\\\])*?)\\3|(" + _ + ")|)|)" + O + "*\\]"
    H = ":(" + M + ")(?:\\((?:(['\"])((?:\\\\.|[^\\\\])*?)\\2|([^()[\\]]*|(?:(?:" + P + ")|[^:]|\\\\.)*|.*))\\)|)"
    B = ":(even|odd|eq|gt|lt|nth|first|last)(?:\\(" + O + "*((?:-\\d)?\\d*)" + O + "*\\)|)(?=[^-]|$)"
    j = new RegExp("^" + O + "+|((?:^|[^\\\\])(?:\\\\.)*)" + O + "+$", "g")
    F = new RegExp("^" + O + "*," + O + "*")
    I = new RegExp("^" + O + "*([\\x20\\t\\r\\n\\f>+~])" + O + "*")
    q = new RegExp(H)
    R = /^(?:#([\w\-]+)|(\w+)|\.([\w\-]+))$/
    U = /^:not/
    z = /[\x20\t\r\n\f]*[+~]/
    W = /:not\($/
    X = /h\d/i
    V = /input|select|textarea|button/i
    $ = /\\(?!\\)/g
    J =
      ID: new RegExp("^#(" + M + ")")
      CLASS: new RegExp("^\\.(" + M + ")")
      NAME: new RegExp("^\\[name=['\"]?(" + M + ")['\"]?\\]")
      TAG: new RegExp("^(" + M.replace("w", "w*") + ")")
      ATTR: new RegExp("^" + P)
      PSEUDO: new RegExp("^" + H)
      POS: new RegExp(B, "i")
      CHILD: new RegExp("^:(only|nth|first|last)-child(?:\\(" + O + "*(even|odd|(([+-]|)(\\d*)n|)" + O + "*(?:([+-]|)" + O + "*(\\d+)|))" + O + "*\\)|)", "i")
      needsContext: new RegExp("^" + O + "*[>+~]|" + B, "i")

    K = (e) ->
      t = g.createElement("div")
      try
        return e(t)
      catch n
        return not 1
      finally
        t = null

    Q = K((e) ->
      e.appendChild(g.createComment(""))
      not e.getElementsByTagName("*").length
    )
    G = K((e) ->
      e.innerHTML = "<a href='#'></a>"
      e.firstChild and typeof e.firstChild.getAttribute isnt p and e.firstChild.getAttribute("href") is "#"
    )
    Y = K((e) ->
      e.innerHTML = "<select></select>"
      t = typeof e.lastChild.getAttribute("multiple")
      t isnt "boolean" and t isnt "string"
    )
    Z = K((e) ->
      e.innerHTML = "<div class='hidden e'></div><div class='hidden'></div>"
      (if not e.getElementsByClassName or not e.getElementsByClassName("e").length then not 1 else (e.lastChild.className = "e"
      e.getElementsByClassName("e").length is 2
      ))
    )
    et = K((e) ->
      e.id = d + 0
      e.innerHTML = "<a name='" + d + "'></a><div name='" + d + "'></div>"
      y.insertBefore(e, y.firstChild)

      t = g.getElementsByName and g.getElementsByName(d).length is 2 + g.getElementsByName(d + 0).length
      r = not g.getElementById(d)
      y.removeChild(e)
      t
    )
    try
      x.call(y.childNodes, 0)[0].nodeType
    catch tt
      x = (e) ->
        t = undefined
        n = []
        while t = this[e]
          n.push t
          e++
        n
    nt.matches = (e, t) ->
      nt e, null, null, t

    nt.matchesSelector = (e, t) ->
      nt(t, null, null, [e]).length > 0

    s = nt.getText = (e) ->
      t = undefined
      n = ""
      r = 0
      i = e.nodeType
      if i
        if i is 1 or i is 9 or i is 11
          return e.textContent  if typeof e.textContent is "string"
          e = e.firstChild
          while e
            n += s(e)
            e = e.nextSibling
        else return e.nodeValue  if i is 3 or i is 4
      else
        while t = e[r]
          n += s(t)
          r++
      n

    o = nt.isXML = (e) ->
      t = e and (e.ownerDocument or e).documentElement
      (if t then t.nodeName isnt "HTML" else not 1)

    u = nt.contains = (if y.contains then (e, t) ->
      n = (if e.nodeType is 9 then e.documentElement else e)
      r = t and t.parentNode
      e is r or !!(r and r.nodeType is 1 and n.contains and n.contains(r))
     else (if y.compareDocumentPosition then (e, t) ->
      t and !!(e.compareDocumentPosition(t) & 16)
     else (e, t) ->
      return not 0  if t is e  while t = t.parentNode
      not 1
    ))
    nt.attr = (e, t) ->
      n = undefined
      r = o(e)
      r or (t = t.toLowerCase())
      (if (n = i.attrHandle[t]) then n(e) else (if r or Y then e.getAttribute(t) else (n = e.getAttributeNode(t)
      (if n then (if typeof e[t] is "boolean" then (if e[t] then t else null) else (if n.specified then n.value else null)) else null)
      )))

    i = nt.selectors =
      cacheLength: 50
      createPseudo: N
      match: J
      attrHandle: (if G then {} else
        href: (e) ->
          e.getAttribute "href", 2

        type: (e) ->
          e.getAttribute "type"
      )
      find:
        ID: (if r then (e, t, n) ->
          if typeof t.getElementById isnt p and not n
            r = t.getElementById(e)
            (if r and r.parentNode then [r] else [])
         else (e, n, r) ->
          if typeof n.getElementById isnt p and not r
            i = n.getElementById(e)
            (if i then (if i.id is e or typeof i.getAttributeNode isnt p and i.getAttributeNode("id").value is e then [i] else t) else [])
        )
        TAG: (if Q then (e, t) ->
          t.getElementsByTagName e  if typeof t.getElementsByTagName isnt p
         else (e, t) ->
          n = t.getElementsByTagName(e)
          if e is "*"
            r = undefined
            i = []
            s = 0
            while r = n[s]
              r.nodeType is 1 and i.push(r)
              s++
            return i
          n
        )
        NAME: et and (e, t) ->
          t.getElementsByName name  if typeof t.getElementsByName isnt p

        CLASS: Z and (e, t, n) ->
          t.getElementsByClassName e  if typeof t.getElementsByClassName isnt p and not n

      relative:
        ">":
          dir: "parentNode"
          first: not 0

        " ":
          dir: "parentNode"

        "+":
          dir: "previousSibling"
          first: not 0

        "~":
          dir: "previousSibling"

      preFilter:
        ATTR: (e) ->
          e[1] = e[1].replace($, "")
          e[3] = (e[4] or e[5] or "").replace($, "")
          e[2] is "~=" and (e[3] = " " + e[3] + " ")
          e.slice(0, 4)

        CHILD: (e) ->
          e[1] = e[1].toLowerCase()
          (if e[1] is "nth" then (e[2] or nt.error(e[0])
          e[3] = +((if e[3] then e[4] + (e[5] or 1) else 2 * (e[2] is "even" or e[2] is "odd")))
          e[4] = +(e[6] + e[7] or e[2] is "odd")
          ) else e[2] and nt.error(e[0]))
          e

        PSEUDO: (e) ->
          t = undefined
          n = undefined
          return null  if J.CHILD.test(e[0])
          if e[3]
            e[2] = e[3]
          else if t = e[4]
            q.test(t) and (n = ut(t, not 0)) and (n = t.indexOf(")", t.length - n) - t.length) and (t = t.slice(0, n)
            e[0] = e[0].slice(0, n)
            )
            e[2] = t
          e.slice 0, 3

      filter:
        ID: (if r then (e) ->
          e = e.replace($, "")
          (t) ->
            t.getAttribute("id") is e
         else (e) ->
          e = e.replace($, "")
          (t) ->
            n = typeof t.getAttributeNode isnt p and t.getAttributeNode("id")
            n and n.value is e
        )
        TAG: (e) ->
          (if e is "*" then ->
            not 0
           else (e = e.replace($, "").toLowerCase()
          (t) ->
            t.nodeName and t.nodeName.toLowerCase() is e

          ))

        CLASS: (e) ->
          t = k[d][e + " "]
          t or (t = new RegExp("(^|" + O + ")" + e + "(" + O + "|$)")) and k(e, (e) ->
            t.test e.className or typeof e.getAttribute isnt p and e.getAttribute("class") or ""
          )

        ATTR: (e, t, n) ->
          (r, i) ->
            s = nt.attr(r, e)
            (if not s? then t is "!=" else (if t then (s += ""
            (if t is "=" then s is n else (if t is "!=" then s isnt n else (if t is "^=" then n and s.indexOf(n) is 0 else (if t is "*=" then n and s.indexOf(n) > -1 else (if t is "$=" then n and s.substr(s.length - n.length) is n else (if t is "~=" then (" " + s + " ").indexOf(n) > -1 else (if t is "|=" then s is n or s.substr(0, n.length + 1) is n + "-" else not 1)))))))
            ) else not 0))

        CHILD: (e, t, n, r) ->
          (if e is "nth" then (e) ->
            t = undefined
            i = undefined
            s = e.parentNode
            return not 0  if n is 1 and r is 0
            if s
              i = 0
              t = s.firstChild
              while t
                if t.nodeType is 1
                  i++
                  break  if e is t
                t = t.nextSibling
            i -= r
            i is n or i % n is 0 and i / n >= 0
           else (t) ->
            n = t
            switch e
              when "only", "first"
                return not 1  if n.nodeType is 1  while n = n.previousSibling
                return not 0  if e is "first"
                n = t
              when "last"
                return not 1  if n.nodeType is 1  while n = n.nextSibling
                not 0
          )

        PSEUDO: (e, t) ->
          n = undefined
          r = i.pseudos[e] or i.setFilters[e.toLowerCase()] or nt.error("unsupported pseudo: " + e)
          (if r[d] then r(t) else (if r.length > 1 then (n = [e, e, "", t]
          (if i.setFilters.hasOwnProperty(e.toLowerCase()) then N((e, n) ->
            i = undefined
            s = r(e, t)
            o = s.length
            while o--
              i = T.call(e, s[o])
              e[i] = not (n[i] = s[o])
          ) else (e) ->
            r e, 0, n
          )
          ) else r))

      pseudos:
        not: N((e) ->
          t = []
          n = []
          r = a(e.replace(j, "$1"))
          (if r[d] then N((e, t, n, i) ->
            s = undefined
            o = r(e, null, i, [])
            u = e.length
            e[u] = not (t[u] = s)  if s = o[u]  while u--
          ) else (e, i, s) ->
            t[0] = e
            r(t, null, s, n)
            not n.pop()
          )
        )
        has: N((e) ->
          (t) ->
            nt(e, t).length > 0
        )
        contains: N((e) ->
          (t) ->
            (t.textContent or t.innerText or s(t)).indexOf(e) > -1
        )
        enabled: (e) ->
          e.disabled is not 1

        disabled: (e) ->
          e.disabled is not 0

        checked: (e) ->
          t = e.nodeName.toLowerCase()
          t is "input" and !!e.checked or t is "option" and !!e.selected

        selected: (e) ->
          e.parentNode and e.parentNode.selectedIndex
          e.selected is not 0

        parent: (e) ->
          not i.pseudos.empty(e)

        empty: (e) ->
          t = undefined
          e = e.firstChild
          while e
            return not 1  if e.nodeName > "@" or (t = e.nodeType) is 3 or t is 4
            e = e.nextSibling
          not 0

        header: (e) ->
          X.test e.nodeName

        text: (e) ->
          t = undefined
          n = undefined
          e.nodeName.toLowerCase() is "input" and (t = e.type) is "text" and (not (n = e.getAttribute("type"))? or n.toLowerCase() is t)

        radio: rt("radio")
        checkbox: rt("checkbox")
        file: rt("file")
        password: rt("password")
        image: rt("image")
        submit: it("submit")
        reset: it("reset")
        button: (e) ->
          t = e.nodeName.toLowerCase()
          t is "input" and e.type is "button" or t is "button"

        input: (e) ->
          V.test e.nodeName

        focus: (e) ->
          t = e.ownerDocument
          e is t.activeElement and (not t.hasFocus or t.hasFocus()) and !!(e.type or e.href or ~e.tabIndex)

        active: (e) ->
          e is e.ownerDocument.activeElement

        first: st(->
          [0]
        )
        last: st((e, t) ->
          [t - 1]
        )
        eq: st((e, t, n) ->
          [(if n < 0 then n + t else n)]
        )
        even: st((e, t) ->
          n = 0

          while n < t
            e.push n
            n += 2
          e
        )
        odd: st((e, t) ->
          n = 1

          while n < t
            e.push n
            n += 2
          e
        )
        lt: st((e, t, n) ->
          r = (if n < 0 then n + t else n)

          while --r >= 0
            e.push r
          e
        )
        gt: st((e, t, n) ->
          r = (if n < 0 then n + t else n)

          while ++r < t
            e.push r
          e
        )

    f = (if y.compareDocumentPosition then (e, t) ->
      (if e is t then (l = not 0
      0
      ) else (if ((if not e.compareDocumentPosition or not t.compareDocumentPosition then e.compareDocumentPosition else e.compareDocumentPosition(t) & 4)) then -1 else 1))
     else (e, t) ->
      if e is t
        return l = not 0
        0
      return e.sourceIndex - t.sourceIndex  if e.sourceIndex and t.sourceIndex
      n = undefined
      r = undefined
      i = []
      s = []
      o = e.parentNode
      u = t.parentNode
      a = o
      return ot(e, t)  if o is u
      return -1  unless o
      return 1  unless u
      while a
        i.unshift(a)
        a = a.parentNode
      a = u
      while a
        s.unshift(a)
        a = a.parentNode
      n = i.length
      r = s.length

      f = 0

      while f < n and f < r
        return ot(i[f], s[f])  if i[f] isnt s[f]
        f++
      (if f is n then ot(e, s[f], -1) else ot(i[f], t, 1))
    )
    [0, 0].sort(f)
    h = not l
    nt.uniqueSort = (e) ->
      t = undefined
      n = []
      r = 1
      i = 0
      l = h
      e.sort(f)

      if l
        while t = e[r]
          t is e[r - 1] and (i = n.push(r))
          r++
        e.splice n[i], 1  while i--
      e

    nt.error = (e) ->
      throw new Error("Syntax error, unrecognized expression: " + e)

    a = nt.compile = (e, t) ->
      n = undefined
      r = []
      i = []
      s = A[d][e + " "]
      unless s
        t or (t = ut(e))
        n = t.length

        while n--
          s = ht(t[n])
          (if s[d] then r.push(s) else i.push(s))
        s = A(e, pt(i, r))
      s

    g.querySelectorAll and ->
      e = undefined
      t = vt
      n = /'|\\/g
      r = /\=[\x20\t\r\n\f]*([^'"\]]*)[\x20\t\r\n\f]*\]/g
      i = [":focus"]
      s = [":active"]
      u = y.matchesSelector or y.mozMatchesSelector or y.webkitMatchesSelector or y.oMatchesSelector or y.msMatchesSelector
      K((e) ->
        e.innerHTML = "<select><option selected=''></option></select>"
        e.querySelectorAll("[selected]").length or i.push("\\[" + O + "*(?:checked|disabled|ismap|multiple|readonly|selected|value)")
        e.querySelectorAll(":checked").length or i.push(":checked")
      )
      K((e) ->
        e.innerHTML = "<p test=''></p>"
        e.querySelectorAll("[test^='']").length and i.push("[*^$]=" + O + "*(?:\"\"|'')")
        e.innerHTML = "<input type='hidden'/>"
        e.querySelectorAll(":enabled").length or i.push(":enabled", ":disabled")
      )
      i = new RegExp(i.join("|"))
      vt = (e, r, s, o, u) ->
        if not o and not u and not i.test(e)
          a = undefined
          f = undefined
          l = not 0
          c = d
          h = r
          p = r.nodeType is 9 and e
          if r.nodeType is 1 and r.nodeName.toLowerCase() isnt "object"
            a = ut(e)
            (if (l = r.getAttribute("id")) then c = l.replace(n, "\\$&") else r.setAttribute("id", c))
            c = "[id='" + c + "'] "
            f = a.length

            a[f] = c + a[f].join("")  while f--
            h = z.test(e) and r.parentNode or r
            p = a.join(",")
          if p
            try
              return S.apply(s, x.call(h.querySelectorAll(p), 0))
              s
            finally
              l or r.removeAttribute("id")
        t e, r, s, o, u

      u and (K((t) ->
        e = u.call(t, "div")
        try
          u.call(t, "[test!='']:sizzle")
          s.push("!=", H)
      )
      s = new RegExp(s.join("|"))
      nt.matchesSelector = (t, n) ->
        n = n.replace(r, "='$1']")
        if not o(t) and not s.test(n) and not i.test(n)
          try
            a = u.call(t, n)
            return a  if a or e or t.document and t.document.nodeType isnt 11
        nt(n, null, null, [t]).length > 0

      )
    ()
    i.pseudos.nth = i.pseudos.eq
    i.filters = mt:: = i.pseudos
    i.setFilters = new mt
    nt.attr = v.attr
    v.find = nt
    v.expr = nt.selectors
    v.expr[":"] = v.expr.pseudos
    v.unique = nt.uniqueSort
    v.text = nt.getText
    v.isXMLDoc = nt.isXML
    v.contains = nt.contains
  (e)

  nt = /Until$/
  rt = /^(?:parents|prev(?:Until|All))/
  it = /^.[^:#\[\.,]*$/
  st = v.expr.match.needsContext
  ot =
    children: not 0
    contents: not 0
    next: not 0
    prev: not 0

  v.fn.extend(
    find: (e) ->
      t = undefined
      n = undefined
      r = undefined
      i = undefined
      s = undefined
      o = undefined
      u = this
      unless typeof e is "string"
        return v(e).filter(->
          t = 0
          n = u.length

          while t < n
            return not 0  if v.contains(u[t], this)
            t++
        )
      o = @pushStack("", "find", e)
      t = 0
      n = @length

      while t < n
        r = o.length
        v.find(e, this[t], o)

        if t > 0
          i = r
          while i < o.length
            s = 0
            while s < r
              if o[s] is o[i]
                o.splice i--, 1
                break
              s++
            i++
        t++
      o

    has: (e) ->
      t = undefined
      n = v(e, this)
      r = n.length
      @filter ->
        t = 0
        while t < r
          return not 0  if v.contains(this, n[t])
          t++


    not: (e) ->
      @pushStack ft(this, e, not 1), "not", e

    filter: (e) ->
      @pushStack ft(this, e, not 0), "filter", e

    is: (e) ->
      !!e and ((if typeof e is "string" then (if st.test(e) then v(e, @context).index(this[0]) >= 0 else v.filter(e, this).length > 0) else @filter(e).length > 0))

    closest: (e, t) ->
      n = undefined
      r = 0
      i = @length
      s = []
      o = (if st.test(e) or typeof e isnt "string" then v(e, t or @context) else 0)
      while r < i
        n = this[r]
        while n and n.ownerDocument and n isnt t and n.nodeType isnt 11
          if (if o then o.index(n) > -1 else v.find.matchesSelector(n, e))
            s.push n
            break
          n = n.parentNode
        r++
      s = (if s.length > 1 then v.unique(s) else s)
      @pushStack(s, "closest", e)

    index: (e) ->
      (if e then (if typeof e is "string" then v.inArray(this[0], v(e)) else v.inArray((if e.jquery then e[0] else e), this)) else (if this[0] and this[0].parentNode then @prevAll().length else -1))

    add: (e, t) ->
      n = (if typeof e is "string" then v(e, t) else v.makeArray((if e and e.nodeType then [e] else e)))
      r = v.merge(@get(), n)
      @pushStack (if ut(n[0]) or ut(r[0]) then r else v.unique(r))

    addBack: (e) ->
      @add (if not e? then @prevObject else @prevObject.filter(e))
  )
  v.fn.andSelf = v.fn.addBack
  v.each(
    parent: (e) ->
      t = e.parentNode
      (if t and t.nodeType isnt 11 then t else null)

    parents: (e) ->
      v.dir e, "parentNode"

    parentsUntil: (e, t, n) ->
      v.dir e, "parentNode", n

    next: (e) ->
      at e, "nextSibling"

    prev: (e) ->
      at e, "previousSibling"

    nextAll: (e) ->
      v.dir e, "nextSibling"

    prevAll: (e) ->
      v.dir e, "previousSibling"

    nextUntil: (e, t, n) ->
      v.dir e, "nextSibling", n

    prevUntil: (e, t, n) ->
      v.dir e, "previousSibling", n

    siblings: (e) ->
      v.sibling (e.parentNode or {}).firstChild, e

    children: (e) ->
      v.sibling e.firstChild

    contents: (e) ->
      (if v.nodeName(e, "iframe") then e.contentDocument or e.contentWindow.document else v.merge([], e.childNodes))
  , (e, t) ->
    v.fn[e] = (n, r) ->
      i = v.map(this, t, n)
      nt.test(e) or (r = n)
      r and typeof r is "string" and (i = v.filter(r, i))
      i = (if @length > 1 and not ot[e] then v.unique(i) else i)
      @length > 1 and rt.test(e) and (i = i.reverse())
      @pushStack(i, e, l.call(arguments_).join(","))
  )
  v.extend(
    filter: (e, t, n) ->
      n and (e = ":not(" + e + ")")
      (if t.length is 1 then (if v.find.matchesSelector(t[0], e) then [t[0]] else []) else v.find.matches(e, t))

    dir: (e, n, r) ->
      i = []
      s = e[n]
      while s and s.nodeType isnt 9 and (r is t or s.nodeType isnt 1 or not v(s).is(r))
        s.nodeType is 1 and i.push(s)
        s = s[n]
      i

    sibling: (e, t) ->
      n = []
      while e
        e.nodeType is 1 and e isnt t and n.push(e)
        e = e.nextSibling
      n
  )

  ct = "abbr|article|aside|audio|bdi|canvas|data|datalist|details|figcaption|figure|footer|header|hgroup|mark|meter|nav|output|progress|section|summary|time|video"
  ht = RegExp(" jQuery\\d+=\"(?:null|\\d+)\"", "g")
  pt = /^\s+/
  dt = /<(?!area|br|col|embed|hr|img|input|link|meta|param)(([\w:]+)[^>]*)\/>/g
  vt = /<([\w:]+)/
  mt = /<tbody/i
  gt = /<|&#?\w+;/
  yt = /<(?:script|style|link)/i
  bt = /<(?:script|object|embed|option|style)/i
  wt = new RegExp("<(?:" + ct + ")[\\s/>]", "i")
  Et = /^(?:checkbox|radio)$/
  St = /checked\s*(?:[^=]|=\s*.checked.)/i
  xt = /\/(java|ecma)script/i
  Tt = /^\s*<!(?:\[CDATA\[|\-\-)|[\]\-]{2}>\s*$/g
  Nt =
    option: [1, "<select multiple='multiple'>", "</select>"]
    legend: [1, "<fieldset>", "</fieldset>"]
    thead: [1, "<table>", "</table>"]
    tr: [2, "<table><tbody>", "</tbody></table>"]
    td: [3, "<table><tbody><tr>", "</tr></tbody></table>"]
    col: [2, "<table><tbody></tbody><colgroup>", "</colgroup></table>"]
    area: [1, "<map>", "</map>"]
    _default: [0, "", ""]

  Ct = lt(i)
  kt = Ct.appendChild(i.createElement("div"))
  Nt.optgroup = Nt.option
  Nt.tbody = Nt.tfoot = Nt.colgroup = Nt.caption = Nt.thead
  Nt.th = Nt.td
  v.support.htmlSerialize or (Nt._default = [1, "X<div>", "</div>"])
  v.fn.extend(
    text: (e) ->
      v.access this, ((e) ->
        (if e is t then v.text(this) else @empty().append((this[0] and this[0].ownerDocument or i).createTextNode(e)))
      ), null, e, arguments_.length

    wrapAll: (e) ->
      if v.isFunction(e)
        return @each((t) ->
          v(this).wrapAll e.call(this, t)
        )
      if this[0]
        t = v(e, this[0].ownerDocument).eq(0).clone(not 0)
        this[0].parentNode and t.insertBefore(this[0])
        t.map(->
          e = this
          e = e.firstChild  while e.firstChild and e.firstChild.nodeType is 1
          e
        ).append(this)
      this

    wrapInner: (e) ->
      (if v.isFunction(e) then @each((t) ->
        v(this).wrapInner e.call(this, t)
      ) else @each(->
        t = v(this)
        n = t.contents()
        (if n.length then n.wrapAll(e) else t.append(e))
      ))

    wrap: (e) ->
      t = v.isFunction(e)
      @each (n) ->
        v(this).wrapAll (if t then e.call(this, n) else e)


    unwrap: ->
      @parent().each(->
        v.nodeName(this, "body") or v(this).replaceWith(@childNodes)
      ).end()

    append: ->
      @domManip arguments_, not 0, (e) ->
        (@nodeType is 1 or @nodeType is 11) and @appendChild(e)


    prepend: ->
      @domManip arguments_, not 0, (e) ->
        (@nodeType is 1 or @nodeType is 11) and @insertBefore(e, @firstChild)


    before: ->
      unless ut(this[0])
        return @domManip(arguments_, not 1, (e) ->
          @parentNode.insertBefore e, this
        )
      if arguments_.length
        e = v.clean(arguments_)
        @pushStack v.merge(e, this), "before", @selector

    after: ->
      unless ut(this[0])
        return @domManip(arguments_, not 1, (e) ->
          @parentNode.insertBefore e, @nextSibling
        )
      if arguments_.length
        e = v.clean(arguments_)
        @pushStack v.merge(this, e), "after", @selector

    remove: (e, t) ->
      n = undefined
      r = 0
      while (n = this[r])?
        if not e or v.filter(e, [n]).length
          not t and n.nodeType is 1 and (v.cleanData(n.getElementsByTagName("*"))
          v.cleanData([n])
          )
          n.parentNode and n.parentNode.removeChild(n)
        r++
      this

    empty: ->
      e = undefined
      t = 0
      while (e = this[t])?
        e.nodeType is 1 and v.cleanData(e.getElementsByTagName("*"))
        e.removeChild e.firstChild  while e.firstChild
        t++
      this

    clone: (e, t) ->
      e = (if not e? then not 1 else e)
      t = (if not t? then e else t)
      @map(->
        v.clone this, e, t
      )

    html: (e) ->
      v.access this, ((e) ->
        n = this[0] or {}
        r = 0
        i = @length
        return (if n.nodeType is 1 then n.innerHTML.replace(ht, "") else t)  if e is t
        if typeof e is "string" and not yt.test(e) and (v.support.htmlSerialize or not wt.test(e)) and (v.support.leadingWhitespace or not pt.test(e)) and not Nt[(vt.exec(e) or ["", ""])[1].toLowerCase()]
          e = e.replace(dt, "<$1></$2>")
          try
            while r < i
              n = this[r] or {}
              n.nodeType is 1 and (v.cleanData(n.getElementsByTagName("*"))
              n.innerHTML = e
              )
              r++
            n = 0
        n and @empty().append(e)
      ), null, e, arguments_.length

    replaceWith: (e) ->
      (if ut(this[0]) then (if @length then @pushStack(v((if v.isFunction(e) then e() else e)), "replaceWith", e) else this) else (if v.isFunction(e) then @each((t) ->
        n = v(this)
        r = n.html()
        n.replaceWith e.call(this, t, r)
      ) else (typeof e isnt "string" and (e = v(e).detach())
      @each(->
        t = @nextSibling
        n = @parentNode
        v(this).remove()
        (if t then v(t).before(e) else v(n).append(e))
      )
      )))

    detach: (e) ->
      @remove e, not 0

    domManip: (e, n, r) ->
      e = [].concat.apply([], e)
      i = undefined
      s = undefined
      o = undefined
      u = undefined
      a = 0
      f = e[0]
      l = []
      c = @length
      if not v.support.checkClone and c > 1 and typeof f is "string" and St.test(f)
        return @each(->
          v(this).domManip e, n, r
        )
      if v.isFunction(f)
        return @each((i) ->
          s = v(this)
          e[0] = f.call(this, i, (if n then s.html() else t))
          s.domManip(e, n, r)
        )
      if this[0]
        i = v.buildFragment(e, this, l)
        o = i.fragment
        s = o.firstChild
        o.childNodes.length is 1 and (o = s)

        if s
          n = n and v.nodeName(s, "tr")
          u = i.cacheable or c - 1
          while a < c
            r.call (if n and v.nodeName(this[a], "table") then Lt(this[a], "tbody") else this[a]), (if a is u then o else v.clone(o, not 0, not 0))
            a++
        o = s = null
        l.length and v.each(l, (e, t) ->
          (if t.src then (if v.ajax then v.ajax(
            url: t.src
            type: "GET"
            dataType: "script"
            async: not 1
            global: not 1
            throws: not 0
          ) else v.error("no ajax")) else v.globalEval((t.text or t.textContent or t.innerHTML or "").replace(Tt, "")))
          t.parentNode and t.parentNode.removeChild(t)
        )
      this
  )
  v.buildFragment = (e, n, r) ->
    s = undefined
    o = undefined
    u = undefined
    a = e[0]
    n = n or i
    n = not n.nodeType and n[0] or n
    n = n.ownerDocument or n
    e.length is 1 and typeof a is "string" and a.length < 512 and n is i and a.charAt(0) is "<" and not bt.test(a) and (v.support.checkClone or not St.test(a)) and (v.support.html5Clone or not wt.test(a)) and (o = not 0
    s = v.fragments[a]
    u = s isnt t
    )
    s or (s = n.createDocumentFragment()
    v.clean(e, n, s, r)
    o and (v.fragments[a] = u and s)
    )

      fragment: s
      cacheable: o

  v.fragments = {}
  v.each(
    appendTo: "append"
    prependTo: "prepend"
    insertBefore: "before"
    insertAfter: "after"
    replaceAll: "replaceWith"
  , (e, t) ->
    v.fn[e] = (n) ->
      r = undefined
      i = 0
      s = []
      o = v(n)
      u = o.length
      a = @length is 1 and this[0].parentNode
      if (not a? or a and a.nodeType is 11 and a.childNodes.length is 1) and u is 1
        return o[t](this[0])
        this
      while i < u
        r = ((if i > 0 then @clone(not 0) else this)).get()
        v(o[i])[t](r)
        s = s.concat(r)
        i++
      @pushStack s, e, o.selector
  )
  v.extend(
    clone: (e, t, n) ->
      r = undefined
      i = undefined
      s = undefined
      o = undefined
      (if v.support.html5Clone or v.isXMLDoc(e) or not wt.test("<" + e.nodeName + ">") then o = e.cloneNode(not 0) else (kt.innerHTML = e.outerHTML
      kt.removeChild(o = kt.firstChild)
      ))
      if (not v.support.noCloneEvent or not v.support.noCloneChecked) and (e.nodeType is 1 or e.nodeType is 11) and not v.isXMLDoc(e)
        Ot(e, o)
        r = Mt(e)
        i = Mt(o)

        s = 0
        while r[s]
          i[s] and Ot(r[s], i[s])
          ++s
      if t
        At e, o
        if n
          r = Mt(e)
          i = Mt(o)

          s = 0
          while r[s]
            At r[s], i[s]
            ++s
      r = i = null
      o

    clean: (e, t, n, r) ->
      s = undefined
      o = undefined
      u = undefined
      a = undefined
      f = undefined
      l = undefined
      c = undefined
      h = undefined
      p = undefined
      d = undefined
      m = undefined
      g = undefined
      y = t is i and Ct
      b = []
      t = i  if not t or typeof t.createDocumentFragment is "undefined"
      s = 0
      while (u = e[s])?
        typeof u is "number" and (u += "")
        continue  unless u
        if typeof u is "string"
          if gt.test(u)
            y = y or lt(t)
            c = t.createElement("div")
            y.appendChild(c)
            u = u.replace(dt, "<$1></$2>")
            a = (vt.exec(u) or ["", ""])[1].toLowerCase()
            f = Nt[a] or Nt._default
            l = f[0]
            c.innerHTML = f[1] + u + f[2]

            c = c.lastChild  while l--
            unless v.support.tbody
              h = mt.test(u)
              p = (if a is "table" and not h then c.firstChild and c.firstChild.childNodes else (if f[1] is "<table>" and not h then c.childNodes else []))

              o = p.length - 1
              while o >= 0
                v.nodeName(p[o], "tbody") and not p[o].childNodes.length and p[o].parentNode.removeChild(p[o])
                --o
            not v.support.leadingWhitespace and pt.test(u) and c.insertBefore(t.createTextNode(pt.exec(u)[0]), c.firstChild)
            u = c.childNodes
            c.parentNode.removeChild(c)
        (if u.nodeType then b.push(u) else v.merge(b, u))
        s++
      c and (u = c = y = null)
      unless v.support.appendChecked
        s = 0
        while (u = b[s])?
          (if v.nodeName(u, "input") then _t(u) else typeof u.getElementsByTagName isnt "undefined" and v.grep(u.getElementsByTagName("input"), _t))
          s++
      if n
        m = (e) ->
          (if r then r.push((if e.parentNode then e.parentNode.removeChild(e) else e)) else n.appendChild(e))  if not e.type or xt.test(e.type)

        s = 0
        while (u = b[s])?
          if not v.nodeName(u, "script") or not m(u)
            n.appendChild(u)
            typeof u.getElementsByTagName isnt "undefined" and (g = v.grep(v.merge([], u.getElementsByTagName("script")), m)
            b.splice.apply(b, [s + 1, 0].concat(g))
            s += g.length
            )
          s++
      b

    cleanData: (e, t) ->
      n = undefined
      r = undefined
      i = undefined
      s = undefined
      o = 0
      u = v.expando
      a = v.cache
      f = v.support.deleteExpando
      l = v.event.special
      while (i = e[o])?
        if t or v.acceptData(i)
          r = i[u]
          n = r and a[r]

          if n
            if n.events
              for s of n.events
                (if l[s] then v.event.remove(i, s) else v.removeEvent(i, s, n.handle))
            a[r] and (delete a[r]

            (if f then delete i[u]
             else (if i.removeAttribute then i.removeAttribute(u) else i[u] = null))
            v.deletedIds.push(r)
            )
        o++
  )
  ->
    e = undefined
    t = undefined
    v.uaMatch = (e) ->
      e = e.toLowerCase()
      t = /(chrome)[ \/]([\w.]+)/.exec(e) or /(webkit)[ \/]([\w.]+)/.exec(e) or /(opera)(?:.*version|)[ \/]([\w.]+)/.exec(e) or /(msie) ([\w.]+)/.exec(e) or e.indexOf("compatible") < 0 and /(mozilla)(?:.*? rv:([\w.]+)|)/.exec(e) or []
      browser: t[1] or ""
      version: t[2] or "0"

    e = v.uaMatch(o.userAgent)
    t = {}
    e.browser and (t[e.browser] = not 0
    t.version = e.version
    )
    (if t.chrome then t.webkit = not 0 else t.webkit and (t.safari = not 0))
    v.browser = t
    v.sub = ->
      e = (t, n) ->
        new e.fn.init(t, n)
      v.extend(not 0, e, this)
      e.superclass = this
      e.fn = e:: = this()
      e.fn.constructor = e
      e.sub = @sub
      e.fn.init = (r, i) ->
        i and i instanceof v and (i not instanceof e) and (i = e(i))
        v.fn.init.call(this, r, i, t)

      e.fn.init:: = e.fn

      t = e(i)
      e
  ()

  Dt = undefined
  Pt = undefined
  Ht = undefined
  Bt = /alpha\([^)]*\)/i
  jt = /opacity=([^)]*)/
  Ft = /^(top|right|bottom|left)$/
  It = /^(none|table(?!-c[ea]).+)/
  qt = /^margin/
  Rt = new RegExp("^(" + m + ")(.*)$", "i")
  Ut = new RegExp("^(" + m + ")(?!px)[a-z%]+$", "i")
  zt = new RegExp("^([-+])=(" + m + ")", "i")
  Wt = BODY: "block"
  Xt =
    position: "absolute"
    visibility: "hidden"
    display: "block"

  Vt =
    letterSpacing: 0
    fontWeight: 400

  $t = ["Top", "Right", "Bottom", "Left"]
  Jt = ["Webkit", "O", "Moz", "ms"]
  Kt = v.fn.toggle
  v.fn.extend(
    css: (e, n) ->
      v.access this, ((e, n, r) ->
        (if r isnt t then v.style(e, n, r) else v.css(e, n))
      ), e, n, arguments_.length > 1

    show: ->
      Yt this, not 0

    hide: ->
      Yt this

    toggle: (e, t) ->
      n = typeof e is "boolean"
      (if v.isFunction(e) and v.isFunction(t) then Kt.apply(this, arguments_) else @each(->
        (if ((if n then e else Gt(this))) then v(this).show() else v(this).hide())
      ))
  )
  v.extend(
    cssHooks:
      opacity:
        get: (e, t) ->
          if t
            n = Dt(e, "opacity")
            (if n is "" then "1" else n)

    cssNumber:
      fillOpacity: not 0
      fontWeight: not 0
      lineHeight: not 0
      opacity: not 0
      orphans: not 0
      widows: not 0
      zIndex: not 0
      zoom: not 0

    cssProps:
      float: (if v.support.cssFloat then "cssFloat" else "styleFloat")

    style: (e, n, r, i) ->
      return  if not e or e.nodeType is 3 or e.nodeType is 8 or not e.style
      s = undefined
      o = undefined
      u = undefined
      a = v.camelCase(n)
      f = e.style
      n = v.cssProps[a] or (v.cssProps[a] = Qt(f, a))
      u = v.cssHooks[n] or v.cssHooks[a]

      return (if u and "get" of u and (s = u.get(e, not 1, i)) isnt t then s else f[n])  if r is t
      o = typeof r
      o is "string" and (s = zt.exec(r)) and (r = (s[1] + 1) * s[2] + parseFloat(v.css(e, n))
      o = "number"
      )

      return  if not r? or o is "number" and isNaN(r)
      o is "number" and not v.cssNumber[a] and (r += "px")
      if not u or ("set" not of u) or (r = u.set(e, r, i)) isnt t
        try
          f[n] = r

    css: (e, n, r, i) ->
      s = undefined
      o = undefined
      u = undefined
      a = v.camelCase(n)
      n = v.cssProps[a] or (v.cssProps[a] = Qt(e.style, a))
      u = v.cssHooks[n] or v.cssHooks[a]
      u and "get" of u and (s = u.get(e, not 0, i))
      s is t and (s = Dt(e, n))
      s is "normal" and n of Vt and (s = Vt[n])
      (if r or i isnt t then (o = parseFloat(s)
      (if r or v.isNumeric(o) then o or 0 else s)
      ) else s)

    swap: (e, t, n) ->
      r = undefined
      i = undefined
      s = {}
      for i of t
        s[i] = e.style[i]
        e.style[i] = t[i]
      r = n.call(e)
      for i of t
        e.style[i] = s[i]
      r
  )
  (if e.getComputedStyle then Dt = (t, n) ->
    r = undefined
    i = undefined
    s = undefined
    o = undefined
    u = e.getComputedStyle(t, null)
    a = t.style
    u and (r = u.getPropertyValue(n) or u[n]
    r is "" and not v.contains(t.ownerDocument, t) and (r = v.style(t, n))
    Ut.test(r) and qt.test(n) and (i = a.width
    s = a.minWidth
    o = a.maxWidth
    a.minWidth = a.maxWidth = a.width = r
    r = u.width
    a.width = i
    a.minWidth = s
    a.maxWidth = o
    )
    )
    r
   else i.documentElement.currentStyle and (Dt = (e, t) ->
    n = undefined
    r = undefined
    i = e.currentStyle and e.currentStyle[t]
    s = e.style
    not i? and s and s[t] and (i = s[t])
    Ut.test(i) and not Ft.test(t) and (n = s.left
    r = e.runtimeStyle and e.runtimeStyle.left
    r and (e.runtimeStyle.left = e.currentStyle.left)
    s.left = (if t is "fontSize" then "1em" else i)
    i = s.pixelLeft + "px"
    s.left = n
    r and (e.runtimeStyle.left = r)
    )
    (if i is "" then "auto" else i)
  ))
  v.each(["height", "width"], (e, t) ->
    v.cssHooks[t] =
      get: (e, n, r) ->
        if n
          (if e.offsetWidth is 0 and It.test(Dt(e, "display")) then v.swap(e, Xt, ->
            tn e, t, r
          ) else tn(e, t, r))

      set: (e, n, r) ->
        Zt e, n, (if r then en(e, t, r, v.support.boxSizing and v.css(e, "boxSizing") is "border-box") else 0)
  )
  v.support.opacity or (v.cssHooks.opacity =
    get: (e, t) ->
      (if jt.test(((if t and e.currentStyle then e.currentStyle.filter else e.style.filter)) or "") then .01 * parseFloat(RegExp.$1) + "" else (if t then "1" else ""))

    set: (e, t) ->
      n = e.style
      r = e.currentStyle
      i = (if v.isNumeric(t) then "alpha(opacity=" + t * 100 + ")" else "")
      s = r and r.filter or n.filter or ""
      n.zoom = 1
      if t >= 1 and v.trim(s.replace(Bt, "")) is "" and n.removeAttribute
        n.removeAttribute "filter"
        return  if r and not r.filter
      n.filter = (if Bt.test(s) then s.replace(Bt, i) else s + " " + i)
  )
  v(->
    v.support.reliableMarginRight or (v.cssHooks.marginRight = get: (e, t) ->
      v.swap e,
        display: "inline-block"
      , ->
        Dt e, "marginRight"  if t

    )
    not v.support.pixelPosition and v.fn.position and v.each(["top", "left"], (e, t) ->
      v.cssHooks[t] = get: (e, n) ->
        if n
          r = Dt(e, t)
          (if Ut.test(r) then v(e).position()[t] + "px" else r)
    )
  )
  v.expr and v.expr.filters and (v.expr.filters.hidden = (e) ->
    e.offsetWidth is 0 and e.offsetHeight is 0 or not v.support.reliableHiddenOffsets and (e.style and e.style.display or Dt(e, "display")) is "none"

  v.expr.filters.visible = (e) ->
    not v.expr.filters.hidden(e)

  )
  v.each(
    margin: ""
    padding: ""
    border: "Width"
  , (e, t) ->
    v.cssHooks[e + t] = expand: (n) ->
      r = undefined
      i = (if typeof n is "string" then n.split(" ") else [n])
      s = {}
      r = 0
      while r < 4
        s[e + $t[r] + t] = i[r] or i[r - 2] or i[0]
        r++
      s

    qt.test(e) or (v.cssHooks[e + t].set = Zt)
  )

  rn = /%20/g
  sn = /\[\]$/
  on_ = /\r?\n/g
  un = /^(?:color|date|datetime|datetime-local|email|hidden|month|number|password|range|search|tel|text|time|url|week)$/i
  an = /^(?:select|textarea)/i
  v.fn.extend(
    serialize: ->
      v.param @serializeArray()

    serializeArray: ->
      @map(->
        (if @elements then v.makeArray(@elements) else this)
      ).filter(->
        @name and not @disabled and (@checked or an.test(@nodeName) or un.test(@type))
      ).map((e, t) ->
        n = v(this).val()
        (if not n? then null else (if v.isArray(n) then v.map(n, (e, n) ->
          name: t.name
          value: e.replace(on_, "\r\n")
        ) else
          name: t.name
          value: n.replace(on_, "\r\n")
        ))
      ).get()
  )
  v.param = (e, n) ->
    r = undefined
    i = []
    s = (e, t) ->
      t = (if v.isFunction(t) then t() else (if not t? then "" else t))
      i[i.length] = encodeURIComponent(e) + "=" + encodeURIComponent(t)

    n is t and (n = v.ajaxSettings and v.ajaxSettings.traditional)
    if v.isArray(e) or e.jquery and not v.isPlainObject(e)
      v.each e, ->
        s @name, @value

    else
      for r of e
        fn r, e[r], n, s
    i.join("&").replace rn, "+"


  ln = undefined
  cn = undefined
  hn = /#.*$/
  pn = /^(.*?):[ \t]*([^\r\n]*)\r?$/g
  dn = /^(?:about|app|app\-storage|.+\-extension|file|res|widget):$/
  vn = /^(?:GET|HEAD)$/
  mn = /^\/\//
  gn = /\?/
  yn = /<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/g
  bn = /([?&])_=[^&]*/
  wn = /^([\w\+\.\-]+:)(?:\/\/([^\/?#:]*)(?::(\d+)|)|)/
  En = v.fn.load
  Sn = {}
  xn = {}
  Tn = ["*/"] + ["*"]
  try
    cn = s.href
  catch Nn
    cn = i.createElement("a")
    cn.href = ""
    cn = cn.href
  ln = wn.exec(cn.toLowerCase()) or []
  v.fn.load = (e, n, r) ->
    return En.apply(this, arguments_)  if typeof e isnt "string" and En
    return this  unless @length
    i = undefined
    s = undefined
    o = undefined
    u = this
    a = e.indexOf(" ")
    a >= 0 and (i = e.slice(a, e.length)
    e = e.slice(0, a)
    )
    (if v.isFunction(n) then (r = n
    n = t
    ) else n and typeof n is "object" and (s = "POST"))
    v.ajax(
      url: e
      type: s
      dataType: "html"
      data: n
      complete: (e, t) ->
        r and u.each(r, o or [e.responseText, t, e])
    ).done((e) ->
      o = arguments_
      u.html((if i then v("<div>").append(e.replace(yn, "")).find(i) else e))
    )
    this

  v.each("ajaxStart ajaxStop ajaxComplete ajaxError ajaxSuccess ajaxSend".split(" "), (e, t) ->
    v.fn[t] = (e) ->
      @on t, e
  )
  v.each(["get", "post"], (e, n) ->
    v[n] = (e, r, i, s) ->
      v.isFunction(r) and (s = s or i
      i = r
      r = t
      )
      v.ajax(
        type: n
        url: e
        data: r
        success: i
        dataType: s
      )
  )
  v.extend(
    getScript: (e, n) ->
      v.get e, t, n, "script"

    getJSON: (e, t, n) ->
      v.get e, t, n, "json"

    ajaxSetup: (e, t) ->
      (if t then Ln(e, v.ajaxSettings) else (t = e
      e = v.ajaxSettings
      ))
      Ln(e, t)
      e

    ajaxSettings:
      url: cn
      isLocal: dn.test(ln[1])
      global: not 0
      type: "GET"
      contentType: "application/x-www-form-urlencoded; charset=UTF-8"
      processData: not 0
      async: not 0
      accepts:
        xml: "application/xml, text/xml"
        html: "text/html"
        text: "text/plain"
        json: "application/json, text/javascript"
        "*": Tn

      contents:
        xml: /xml/
        html: /html/
        json: /json/

      responseFields:
        xml: "responseXML"
        text: "responseText"

      converters:
        "* text": e.String
        "text html": not 0
        "text json": v.parseJSON
        "text xml": v.parseXML

      flatOptions:
        context: not 0
        url: not 0

    ajaxPrefilter: Cn(Sn)
    ajaxTransport: Cn(xn)
    ajax: (e, n) ->
      T = (e, n, s, a) ->
        l = undefined
        y = undefined
        b = undefined
        w = undefined
        S = undefined
        T = n
        return  if E is 2
        E = 2
        u and clearTimeout(u)
        o = t
        i = a or ""
        x.readyState = (if e > 0 then 4 else 0)
        s and (w = An(c, x, s))

        unless e >= 200 and e < 300 or e is 304
          b = T
          if not T or e
            T = "error"
            e < 0 and (e = 0)
        x.status = e
        x.statusText = (n or T) + ""
        (if l then d.resolveWith(h, [y, T, x]) else d.rejectWith(h, [x, T, b]))
        x.statusCode(g)
        g = t
        f and p.trigger("ajax" + ((if l then "Success" else "Error")), [x, c, (if l then y else b)])
        m.fireWith(h, [x, T])
        f and (p.trigger("ajaxComplete", [x, c])
        --v.active or v.event.trigger("ajaxStop")
        )
      typeof e is "object" and (n = e
      e = t
      )
      n = n or {}

      r = undefined
      i = undefined
      s = undefined
      o = undefined
      u = undefined
      a = undefined
      f = undefined
      l = undefined
      c = v.ajaxSetup({}, n)
      h = c.context or c
      p = (if h isnt c and (h.nodeType or h instanceof v) then v(h) else v.event)
      d = v.Deferred()
      m = v.Callbacks("once memory")
      g = c.statusCode or {}
      b = {}
      w = {}
      E = 0
      S = "canceled"
      x =
        readyState: 0
        setRequestHeader: (e, t) ->
          unless E
            n = e.toLowerCase()
            e = w[n] = w[n] or e
            b[e] = t
          this

        getAllResponseHeaders: ->
          (if E is 2 then i else null)

        getResponseHeader: (e) ->
          n = undefined
          if E is 2
            unless s
              s = {}
              s[n[1].toLowerCase()] = n[2]  while n = pn.exec(i)
            n = s[e.toLowerCase()]
          (if n is t then null else n)

        overrideMimeType: (e) ->
          E or (c.mimeType = e)
          this

        abort: (e) ->
          e = e or S
          o and o.abort(e)
          T(0, e)
          this

      d.promise(x)
      x.success = x.done
      x.error = x.fail
      x.complete = m.add
      x.statusCode = (e) ->
        if e
          t = undefined
          if E < 2
            for t of e
              g[t] = [g[t], e[t]]
          else
            t = e[x.status]
            x.always(t)
        this

      c.url = ((e or c.url) + "").replace(hn, "").replace(mn, ln[1] + "//")
      c.dataTypes = v.trim(c.dataType or "*").toLowerCase().split(y)
      not c.crossDomain? and (a = wn.exec(c.url.toLowerCase())
      c.crossDomain = not (not a or a[1] is ln[1] and a[2] is ln[2] and (a[3] or ((if a[1] is "http:" then 80 else 443))) is (ln[3] or ((if ln[1] is "http:" then 80 else 443))))
      )
      c.data and c.processData and typeof c.data isnt "string" and (c.data = v.param(c.data, c.traditional))
      kn(Sn, c, n, x)

      return x  if E is 2
      f = c.global
      c.type = c.type.toUpperCase()
      c.hasContent = not vn.test(c.type)
      f and v.active++ is 0 and v.event.trigger("ajaxStart")

      unless c.hasContent
        c.data and (c.url += ((if gn.test(c.url) then "&" else "?")) + c.data
        delete c.data

        )
        r = c.url

        if c.cache is not 1
          N = v.now()
          C = c.url.replace(bn, "$1_=" + N)
          c.url = C + ((if C is c.url then ((if gn.test(c.url) then "&" else "?")) + "_=" + N else ""))
      (c.data and c.hasContent and c.contentType isnt not 1 or n.contentType) and x.setRequestHeader("Content-Type", c.contentType)
      c.ifModified and (r = r or c.url
      v.lastModified[r] and x.setRequestHeader("If-Modified-Since", v.lastModified[r])
      v.etag[r] and x.setRequestHeader("If-None-Match", v.etag[r])
      )
      x.setRequestHeader("Accept", (if c.dataTypes[0] and c.accepts[c.dataTypes[0]] then c.accepts[c.dataTypes[0]] + ((if c.dataTypes[0] isnt "*" then ", " + Tn + "; q=0.01" else "")) else c.accepts["*"]))

      for l of c.headers
        x.setRequestHeader l, c.headers[l]
      if not c.beforeSend or c.beforeSend.call(h, x, c) isnt not 1 and E isnt 2
        S = "abort"
        for l of
          success: 1
          error: 1
          complete: 1
          x[l] c[l]
        o = kn(xn, c, n, x)
        if o
          x.readyState = 1
          f and p.trigger("ajaxSend", [x, c])
          c.async and c.timeout > 0 and (u = setTimeout(->
            x.abort "timeout"
          , c.timeout))

          try
            E = 1
            o.send(b, T)
          catch k
            throw k  unless E < 2
            T -1, k
        return x
      x.abort()

    active: 0
    lastModified: {}
    etag: {}
  )

  Mn = []
  _n = /\?/
  Dn = /(=)\?(?=&|$)|\?\?/
  Pn = v.now()
  v.ajaxSetup(
    jsonp: "callback"
    jsonpCallback: ->
      e = Mn.pop() or v.expando + "_" + Pn++
      this[e] = not 0
      e
  )
  v.ajaxPrefilter("json jsonp", (n, r, i) ->
    s = undefined
    o = undefined
    u = undefined
    a = n.data
    f = n.url
    l = n.jsonp isnt not 1
    c = l and Dn.test(f)
    h = l and not c and typeof a is "string" and not (n.contentType or "").indexOf("application/x-www-form-urlencoded") and Dn.test(a)
    if n.dataTypes[0] is "jsonp" or c or h
      s = n.jsonpCallback = (if v.isFunction(n.jsonpCallback) then n.jsonpCallback() else n.jsonpCallback)
      o = e[s]
      (if c then n.url = f.replace(Dn, "$1" + s) else (if h then n.data = a.replace(Dn, "$1" + s) else l and (n.url += ((if _n.test(f) then "&" else "?")) + n.jsonp + "=" + s)))
      n.converters["script json"] = ->
        u or v.error(s + " was not called")
        u[0]

      n.dataTypes[0] = "json"
      e[s] = ->
        u = arguments_

      i.always(->
        e[s] = o
        n[s] and (n.jsonpCallback = r.jsonpCallback
        Mn.push(s)
        )
        u and v.isFunction(o) and o(u[0])
        u = o = t
      )
      "script"
  )
  v.ajaxSetup(
    accepts:
      script: "text/javascript, application/javascript, application/ecmascript, application/x-ecmascript"

    contents:
      script: /javascript|ecmascript/

    converters:
      "text script": (e) ->
        v.globalEval(e)
        e
  )
  v.ajaxPrefilter("script", (e) ->
    e.cache is t and (e.cache = not 1)
    e.crossDomain and (e.type = "GET"
    e.global = not 1
    )
  )
  v.ajaxTransport("script", (e) ->
    if e.crossDomain
      n = undefined
      r = i.head or i.getElementsByTagName("head")[0] or i.documentElement
      send: (s, o) ->
        n = i.createElement("script")
        n.async = "async"
        e.scriptCharset and (n.charset = e.scriptCharset)
        n.src = e.url
        n.onload = n.onreadystatechange = (e, i) ->
          if i or not n.readyState or /loaded|complete/.test(n.readyState)
            n.onload = n.onreadystatechange = null
            r and n.parentNode and r.removeChild(n)
            n = t
            i or o(200, "success")

        r.insertBefore(n, r.firstChild)

      abort: ->
        n and n.onload(0, 1)
  )

  Hn = undefined
  Bn = (if e.ActiveXObject then ->
    for e of Hn
      Hn[e] 0, 1
   else not 1)
  jn = 0
  v.ajaxSettings.xhr = (if e.ActiveXObject then ->
    not @isLocal and Fn() or In()
   else Fn)
  (e) ->
    v.extend v.support,
      ajax: !!e
      cors: !!e and "withCredentials" of e

  (v.ajaxSettings.xhr())
  v.support.ajax and v.ajaxTransport((n) ->
    if not n.crossDomain or v.support.cors
      r = undefined
      send: (i, s) ->
        o = undefined
        u = undefined
        a = n.xhr()
        (if n.username then a.open(n.type, n.url, n.async, n.username, n.password) else a.open(n.type, n.url, n.async))
        if n.xhrFields
          for u of n.xhrFields
            a[u] = n.xhrFields[u]
        n.mimeType and a.overrideMimeType and a.overrideMimeType(n.mimeType)
        not n.crossDomain and not i["X-Requested-With"] and (i["X-Requested-With"] = "XMLHttpRequest")

        try
          for u of i
            a.setRequestHeader u, i[u]
        a.send(n.hasContent and n.data or null)
        r = (e, i) ->
          u = undefined
          f = undefined
          l = undefined
          c = undefined
          h = undefined
          try
            if r and (i or a.readyState is 4)
              r = t
              o and (a.onreadystatechange = v.noop
              Bn and delete Hn[o]

              )

              unless i
                u = a.status
                l = a.getAllResponseHeaders()
                c = {}
                h = a.responseXML
                h and h.documentElement and (c.xml = h)

                try
                  c.text = a.responseText
                try
                  f = a.statusText
                catch p
                  f = ""
                (if not u and n.isLocal and not n.crossDomain then u = (if c.text then 200 else 404) else u is 1223 and (u = 204))
          catch d
            i or s(-1, d)
          c and s(u, f, c, l)

        (if n.async then (if a.readyState is 4 then setTimeout(r, 0) else (o = ++jn
        Bn and (Hn or (Hn = {}
        v(e).unload(Bn)
        )
        Hn[o] = r
        )
        a.onreadystatechange = r
        )) else r())

      abort: ->
        r and r(0, 1)
  )

  qn = undefined
  Rn = undefined
  Un = /^(?:toggle|show|hide)$/
  zn = new RegExp("^(?:([-+])=|)(" + m + ")([a-z%]*)$", "i")
  Wn = /queueHooks$/
  Xn = [Gn]
  Vn = "*": [(e, t) ->
    n = undefined
    r = undefined
    i = @createTween(e, t)
    s = zn.exec(t)
    o = i.cur()
    u = +o or 0
    a = 1
    f = 20
    if s
      n = +s[2]
      r = s[3] or ((if v.cssNumber[e] then "" else "px"))

      if r isnt "px" and u
        u = v.css(i.elem, e, not 0) or n or 1
        loop
          a = a or ".5"
          u /= a
          v.style(i.elem, e, u + r)
          break unless a isnt (a = i.cur() / o) and a isnt 1 and --f
      i.unit = r
      i.start = u
      i.end = (if s[1] then u + (s[1] + 1) * n else n)
    i
  ]
  v.Animation = v.extend(Kn,
    tweener: (e, t) ->
      (if v.isFunction(e) then (t = e
      e = ["*"]
      ) else e = e.split(" "))
      n = undefined
      r = 0
      i = e.length
      while r < i
        n = e[r]
        Vn[n] = Vn[n] or []
        Vn[n].unshift(t)
        r++

    prefilter: (e, t) ->
      (if t then Xn.unshift(e) else Xn.push(e))
  )
  v.Tween = Yn
  Yn:: =
    constructor: Yn
    init: (e, t, n, r, i, s) ->
      @elem = e
      @prop = n
      @easing = i or "swing"
      @options = t
      @start = @now = @cur()
      @end = r
      @unit = s or ((if v.cssNumber[n] then "" else "px"))

    cur: ->
      e = Yn.propHooks[@prop]
      (if e and e.get then e.get(this) else Yn.propHooks._default.get(this))

    run: (e) ->
      t = undefined
      n = Yn.propHooks[@prop]
      (if @options.duration then @pos = t = v.easing[@easing](e, @options.duration * e, 0, 1, @options.duration) else @pos = t = e)
      @now = (@end - @start) * t + @start
      @options.step and @options.step.call(@elem, @now, this)
      (if n and n.set then n.set(this) else Yn.propHooks._default.set(this))
      this

  Yn::init:: = Yn::
  Yn.propHooks = _default:
    get: (e) ->
      t = undefined
      (if not e.elem[e.prop]? or !!e.elem.style and e.elem.style[e.prop]? then (t = v.css(e.elem, e.prop, not 1, "")
      (if not t or t is "auto" then 0 else t)
      ) else e.elem[e.prop])

    set: (e) ->
      (if v.fx.step[e.prop] then v.fx.step[e.prop](e) else (if e.elem.style and (e.elem.style[v.cssProps[e.prop]]? or v.cssHooks[e.prop]) then v.style(e.elem, e.prop, e.now + e.unit) else e.elem[e.prop] = e.now))

  Yn.propHooks.scrollTop = Yn.propHooks.scrollLeft = set: (e) ->
    e.elem.nodeType and e.elem.parentNode and (e.elem[e.prop] = e.now)

  v.each(["toggle", "show", "hide"], (e, t) ->
    n = v.fn[t]
    v.fn[t] = (r, i, s) ->
      (if not r? or typeof r is "boolean" or not e and v.isFunction(r) and v.isFunction(i) then n.apply(this, arguments_) else @animate(Zn(t, not 0), r, i, s))
  )
  v.fn.extend(
    fadeTo: (e, t, n, r) ->
      @filter(Gt).css("opacity", 0).show().end().animate
        opacity: t
      , e, n, r

    animate: (e, t, n, r) ->
      i = v.isEmptyObject(e)
      s = v.speed(t, n, r)
      o = ->
        t = Kn(this, v.extend({}, e), s)
        i and t.stop(not 0)

      (if i or s.queue is not 1 then @each(o) else @queue(s.queue, o))

    stop: (e, n, r) ->
      i = (e) ->
        t = e.stop
        delete e.stop

        t(r)

      typeof e isnt "string" and (r = n
      n = e
      e = t
      )
      n and e isnt not 1 and @queue(e or "fx", [])
      @each(->
        t = not 0
        n = e? and e + "queueHooks"
        s = v.timers
        o = v._data(this)
        if n
          o[n] and o[n].stop and i(o[n])
        else
          for n of o
            o[n] and o[n].stop and Wn.test(n) and i(o[n])
        n = s.length
        while n--
          s[n].elem is this and (not e? or s[n].queue is e) and (s[n].anim.stop(r)
          t = not 1
          s.splice(n, 1)
          )
        (t or not r) and v.dequeue(this, e)
      )
  )
  v.each(
    slideDown: Zn("show")
    slideUp: Zn("hide")
    slideToggle: Zn("toggle")
    fadeIn:
      opacity: "show"

    fadeOut:
      opacity: "hide"

    fadeToggle:
      opacity: "toggle"
  , (e, t) ->
    v.fn[e] = (e, n, r) ->
      @animate t, e, n, r
  )
  v.speed = (e, t, n) ->
    r = (if e and typeof e is "object" then v.extend({}, e) else
      complete: n or not n and t or v.isFunction(e) and e
      duration: e
      easing: n and t or t and not v.isFunction(t) and t
    )
    r.duration = (if v.fx.off then 0 else (if typeof r.duration is "number" then r.duration else (if r.duration of v.fx.speeds then v.fx.speeds[r.duration] else v.fx.speeds._default)))
    r.queue = "fx"  if not r.queue? or r.queue is not 0
    r.old = r.complete
    r.complete = ->
      v.isFunction(r.old) and r.old.call(this)
      r.queue and v.dequeue(this, r.queue)

    r

  v.easing =
    linear: (e) ->
      e

    swing: (e) ->
      .5 - Math.cos(e * Math.PI) / 2

  v.timers = []
  v.fx = Yn::init
  v.fx.tick = ->
    e = undefined
    n = v.timers
    r = 0
    qn = v.now()
    while r < n.length
      e = n[r]
      not e() and n[r] is e and n.splice(r--, 1)
      r++
    n.length or v.fx.stop()
    qn = t

  v.fx.timer = (e) ->
    e() and v.timers.push(e) and not Rn and (Rn = setInterval(v.fx.tick, v.fx.interval))

  v.fx.interval = 13
  v.fx.stop = ->
    clearInterval(Rn)
    Rn = null

  v.fx.speeds =
    slow: 600
    fast: 200
    _default: 400

  v.fx.step = {}
  v.expr and v.expr.filters and (v.expr.filters.animated = (e) ->
    v.grep(v.timers, (t) ->
      e is t.elem
    ).length
  )

  er = /^(?:body|html)$/i
  v.fn.offset = (e) ->
    if arguments_.length
      return (if e is t then this else @each((t) ->
        v.offset.setOffset this, e, t
      ))
    n = undefined
    r = undefined
    i = undefined
    s = undefined
    o = undefined
    u = undefined
    a = undefined
    f =
      top: 0
      left: 0

    l = this[0]
    c = l and l.ownerDocument
    return  unless c
    (if (r = c.body) is l then v.offset.bodyOffset(l) else (n = c.documentElement
    (if v.contains(n, l) then (typeof l.getBoundingClientRect isnt "undefined" and (f = l.getBoundingClientRect())
    i = tr(c)
    s = n.clientTop or r.clientTop or 0
    o = n.clientLeft or r.clientLeft or 0
    u = i.pageYOffset or n.scrollTop
    a = i.pageXOffset or n.scrollLeft

      top: f.top + u - s
      left: f.left + a - o

    ) else f)
    ))

  v.offset =
    bodyOffset: (e) ->
      t = e.offsetTop
      n = e.offsetLeft
      v.support.doesNotIncludeMarginInBodyOffset and (t += parseFloat(v.css(e, "marginTop")) or 0
      n += parseFloat(v.css(e, "marginLeft")) or 0
      )

        top: t
        left: n

    setOffset: (e, t, n) ->
      r = v.css(e, "position")
      r is "static" and (e.style.position = "relative")
      i = v(e)
      s = i.offset()
      o = v.css(e, "top")
      u = v.css(e, "left")
      a = (r is "absolute" or r is "fixed") and v.inArray("auto", [o, u]) > -1
      f = {}
      l = {}
      c = undefined
      h = undefined
      (if a then (l = i.position()
      c = l.top
      h = l.left
      ) else (c = parseFloat(o) or 0
      h = parseFloat(u) or 0
      ))
      v.isFunction(t) and (t = t.call(e, n, s))
      t.top? and (f.top = t.top - s.top + c)
      t.left? and (f.left = t.left - s.left + h)
      (if "using" of t then t.using.call(e, f) else i.css(f))

  v.fn.extend(
    position: ->
      return  unless this[0]
      e = this[0]
      t = @offsetParent()
      n = @offset()
      r = (if er.test(t[0].nodeName) then
        top: 0
        left: 0
       else t.offset())
      n.top -= parseFloat(v.css(e, "marginTop")) or 0
      n.left -= parseFloat(v.css(e, "marginLeft")) or 0
      r.top += parseFloat(v.css(t[0], "borderTopWidth")) or 0
      r.left += parseFloat(v.css(t[0], "borderLeftWidth")) or 0

        top: n.top - r.top
        left: n.left - r.left

    offsetParent: ->
      @map ->
        e = @offsetParent or i.body
        e = e.offsetParent  while e and not er.test(e.nodeName) and v.css(e, "position") is "static"
        e or i.body

  )
  v.each(
    scrollLeft: "pageXOffset"
    scrollTop: "pageYOffset"
  , (e, n) ->
    r = /Y/.test(n)
    v.fn[e] = (i) ->
      v.access this, ((e, i, s) ->
        o = tr(e)
        return (if o then (if n of o then o[n] else o.document.documentElement[i]) else e[i])  if s is t
        (if o then o.scrollTo((if r then v(o).scrollLeft() else s), (if r then s else v(o).scrollTop())) else e[i] = s)
      ), e, i, arguments_.length, null
  )
  v.each(
    Height: "height"
    Width: "width"
  , (e, n) ->
    v.each
      padding: "inner" + e
      content: n
      "": "outer" + e
    , (r, i) ->
      v.fn[i] = (i, s) ->
        o = arguments_.length and (r or typeof i isnt "boolean")
        u = r or ((if i is not 0 or s is not 0 then "margin" else "border"))
        v.access this, ((n, r, i) ->
          s = undefined
          (if v.isWindow(n) then n.document.documentElement["client" + e] else (if n.nodeType is 9 then (s = n.documentElement
          Math.max(n.body["scroll" + e], s["scroll" + e], n.body["offset" + e], s["offset" + e], s["client" + e])
          ) else (if i is t then v.css(n, r, i, u) else v.style(n, r, i, u))))
        ), n, (if o then i else t), o, null

  )
  e.jQuery = e.$ = v
  typeof define is "function" and define.amd and define.amd.jQuery and define("jquery", [], ->
    v
  )
) window
