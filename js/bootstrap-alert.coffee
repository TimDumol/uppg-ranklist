# ==========================================================
# * bootstrap-alert.js v2.0.0
# * http://twitter.github.com/bootstrap/javascript.html#alerts
# * ==========================================================
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
# * ========================================================== 
not ($) ->
  "use strict"
  
  # ALERT CLASS DEFINITION
  #  * ====================== 
  dismiss = "[data-dismiss=\"alert\"]"
  Alert = (el) ->
    $(el).on "click", dismiss, @close

  Alert:: =
    constructor: Alert
    close: (e) ->
      #strip for ie7
      removeElement = ->
        $parent.remove()
        $parent.trigger "closed"
      $this = $(this)
      selector = $this.attr("data-target")
      $parent = undefined
      unless selector
        selector = $this.attr("href")
        selector = selector and selector.replace(/.*(?=#[^\s]*$)/, "")
      $parent = $(selector)
      $parent.trigger "close"
      e and e.preventDefault()
      $parent.length or ($parent = (if $this.hasClass("alert") then $this else $this.parent()))
      $parent.removeClass "in"
      (if $.support.transition and $parent.hasClass("fade") then $parent.on($.support.transition.end, removeElement) else removeElement())

  
  # ALERT PLUGIN DEFINITION
  #  * ======================= 
  $.fn.alert = (option) ->
    @each ->
      $this = $(this)
      data = $this.data("alert")
      $this.data "alert", (data = new Alert(this))  unless data
      data[option].call $this  if typeof option is "string"


  $.fn.alert.Constructor = Alert
  
  # ALERT DATA-API
  #  * ============== 
  $ ->
    $("body").on "click.alert.data-api", dismiss, Alert::close

(window.jQuery)
