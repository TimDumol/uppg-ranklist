# =============================================================
# * bootstrap-scrollspy.js v2.0.0
# * http://twitter.github.com/bootstrap/javascript.html#scrollspy
# * =============================================================
# * Copyright 2012 Twitter, Inc.
# *
# * Licensed under the Apache License, Version 2.0 (the "License");
# * you may not use this file except in compliance with the License.
# * You may obtain a copy of the License at
# *
# * http://www.apache.org/licenses/LICENSE-2.0
# *
# * Unless required by applicable law or agreed to in writing, software
# * distributed under the License is distributed on an "AS IS" BASIS,
# * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# * See the License for the specific language governing permissions and
# * limitations under the License.
# * ============================================================== 
not ($) ->
  
  # SCROLLSPY CLASS DEFINITION
  #   * ========================== 
  ScrollSpy = (element, options) ->
    process = $.proxy(@process, this)
    $element = (if $(element).is("body") then $(window) else $(element))
    href = undefined
    @options = $.extend({}, $.fn.scrollspy.defaults, options)
    @$scrollElement = $element.on("scroll.scroll.data-api", process)
    #strip for ie7
    @selector = (@options.target or ((href = $(element).attr("href")) and href.replace(/.*(?=#[^\s]+$)/, "")) or "") + " .nav li > a"
    @$body = $("body").on("click.scroll.data-api", @selector, process)
    @refresh()
    @process()
  "use strict"
  ScrollSpy:: =
    constructor: ScrollSpy
    refresh: ->
      @targets = @$body.find(@selector).map(->
        href = $(this).attr("href")
        (if /^#\w/.test(href) and $(href).length then href else null)
      )
      @offsets = $.map(@targets, (id) ->
        $(id).position().top
      )

    process: ->
      scrollTop = @$scrollElement.scrollTop() + @options.offset
      offsets = @offsets
      targets = @targets
      activeTarget = @activeTarget
      i = undefined
      i = offsets.length
      while i--
        activeTarget isnt targets[i] and scrollTop >= offsets[i] and (not offsets[i + 1] or scrollTop <= offsets[i + 1]) and @activate(targets[i])

    activate: (target) ->
      active = undefined
      @activeTarget = target
      @$body.find(@selector).parent(".active").removeClass "active"
      active = @$body.find(@selector + "[href=\"" + target + "\"]").parent("li").addClass("active")
      active.closest("li.dropdown").addClass "active"  if active.parent(".dropdown-menu")

  
  # SCROLLSPY PLUGIN DEFINITION
  #  * =========================== 
  $.fn.scrollspy = (option) ->
    @each ->
      $this = $(this)
      data = $this.data("scrollspy")
      options = typeof option is "object" and option
      $this.data "scrollspy", (data = new ScrollSpy(this, options))  unless data
      data[option]()  if typeof option is "string"


  $.fn.scrollspy.Constructor = ScrollSpy
  $.fn.scrollspy.defaults = offset: 10
  
  # SCROLLSPY DATA-API
  #  * ================== 
  $ ->
    $("[data-spy=\"scroll\"]").each ->
      $spy = $(this)
      $spy.scrollspy $spy.data()


(window.jQuery)
