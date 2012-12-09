# ============================================================
# * bootstrap-dropdown.js v2.0.0
# * http://twitter.github.com/bootstrap/javascript.html#dropdowns
# * ============================================================
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
# * ============================================================ 
not ($) ->
  
  # DROPDOWN CLASS DEFINITION
  #  * ========================= 
  #strip for ie7
  clearMenus = ->
    $(toggle).parent().removeClass "open"
  "use strict"
  toggle = "[data-toggle=\"dropdown\"]"
  Dropdown = (element) ->
    $el = $(element).on("click.dropdown.data-api", @toggle)
    $("html").on "click.dropdown.data-api", ->
      $el.parent().removeClass "open"


  Dropdown:: =
    constructor: Dropdown
    toggle: (e) ->
      $this = $(this)
      selector = $this.attr("data-target")
      $parent = undefined
      isActive = undefined
      unless selector
        selector = $this.attr("href")
        selector = selector and selector.replace(/.*(?=#[^\s]*$)/, "")
      $parent = $(selector)
      $parent.length or ($parent = $this.parent())
      isActive = $parent.hasClass("open")
      clearMenus()
      not isActive and $parent.toggleClass("open")
      false

  
  # DROPDOWN PLUGIN DEFINITION
  #   * ========================== 
  $.fn.dropdown = (option) ->
    @each ->
      $this = $(this)
      data = $this.data("dropdown")
      $this.data "dropdown", (data = new Dropdown(this))  unless data
      data[option].call $this  if typeof option is "string"


  $.fn.dropdown.Constructor = Dropdown
  
  # APPLY TO STANDARD DROPDOWN ELEMENTS
  #   * =================================== 
  $ ->
    $("html").on "click.dropdown.data-api", clearMenus
    $("body").on "click.dropdown.data-api", toggle, Dropdown::toggle

(window.jQuery)
