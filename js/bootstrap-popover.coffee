# ===========================================================
# * bootstrap-popover.js v2.0.0
# * http://twitter.github.com/bootstrap/javascript.html#popovers
# * ===========================================================
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
# * =========================================================== 
not ($) ->
  "use strict"
  Popover = (element, options) ->
    @init "popover", element, options

  
  # NOTE: POPOVER EXTENDS BOOTSTRAP-TOOLTIP.js
  #     ========================================== 
  Popover:: = $.extend({}, $.fn.tooltip.Constructor::,
    constructor: Popover
    setContent: ->
      $tip = @tip()
      title = @getTitle()
      content = @getContent()
      $tip.find(".popover-title")[(if $.type(title) is "object" then "append" else "html")] title
      $tip.find(".popover-content > *")[(if $.type(content) is "object" then "append" else "html")] content
      $tip.removeClass "fade top bottom left right in"

    hasContent: ->
      @getTitle() or @getContent()

    getContent: ->
      content = undefined
      $e = @$element
      o = @options
      content = $e.attr("data-content") or ((if typeof o.content is "function" then o.content.call($e[0]) else o.content))
      content = content.toString().replace(/(^\s*|\s*$)/, "")
      content

    tip: ->
      @$tip = $(@options.template)  unless @$tip
      @$tip
  )
  
  # POPOVER PLUGIN DEFINITION
  #  * ======================= 
  $.fn.popover = (option) ->
    @each ->
      $this = $(this)
      data = $this.data("popover")
      options = typeof option is "object" and option
      $this.data "popover", (data = new Popover(this, options))  unless data
      data[option]()  if typeof option is "string"


  $.fn.popover.Constructor = Popover
  $.fn.popover.defaults = $.extend({}, $.fn.tooltip.defaults,
    placement: "right"
    content: ""
    template: "<div class=\"popover\"><div class=\"arrow\"></div><div class=\"popover-inner\"><h3 class=\"popover-title\"></h3><div class=\"popover-content\"><p></p></div></div></div>"
  )
(window.jQuery)
