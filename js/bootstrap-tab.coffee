# ========================================================
# * bootstrap-tab.js v2.0.0
# * http://twitter.github.com/bootstrap/javascript.html#tabs
# * ========================================================
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
# * ======================================================== 
not ($) ->
  "use strict"
  
  # TAB CLASS DEFINITION
  #  * ==================== 
  Tab = (element) ->
    @element = $(element)

  Tab:: =
    constructor: Tab
    show: ->
      $this = @element
      $ul = $this.closest("ul:not(.dropdown-menu)")
      selector = $this.attr("data-target")
      previous = undefined
      $target = undefined
      unless selector
        selector = $this.attr("href")
        selector = selector and selector.replace(/.*(?=#[^\s]*$)/, "") #strip for ie7
      return previous = $ul.find(".active a").last()[0]  if $this.parent("li").hasClass("active")
      $this.trigger
        type: "show"
        relatedTarget: previous

      $target = $(selector)
      @activate $this.parent("li"), $ul
      @activate $target, $target.parent(), ->
        $this.trigger
          type: "shown"
          relatedTarget: previous



    activate: (element, container, callback) ->
      next = ->
        $active.removeClass("active").find("> .dropdown-menu > .active").removeClass "active"
        element.addClass "active"
        if transition
          element[0].offsetWidth # reflow for transition
          element.addClass "in"
        else
          element.removeClass "fade"
        element.closest("li.dropdown").addClass "active"  if element.parent(".dropdown-menu")
        callback and callback()
      $active = container.find("> .active")
      transition = callback and $.support.transition and $active.hasClass("fade")
      (if transition then $active.one($.support.transition.end, next) else next())
      $active.removeClass "in"

  
  # TAB PLUGIN DEFINITION
  #  * ===================== 
  $.fn.tab = (option) ->
    @each ->
      $this = $(this)
      data = $this.data("tab")
      $this.data "tab", (data = new Tab(this))  unless data
      data[option]()  if typeof option is "string"


  $.fn.tab.Constructor = Tab
  
  # TAB DATA-API
  #  * ============ 
  $ ->
    $("body").on "click.tab.data-api", "[data-toggle=\"tab\"], [data-toggle=\"pill\"]", (e) ->
      e.preventDefault()
      $(this).tab "show"


(window.jQuery)
