# =========================================================
# * bootstrap-modal.js v2.0.0
# * http://twitter.github.com/bootstrap/javascript.html#modals
# * =========================================================
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
# * ========================================================= 
not ($) ->
  
  # MODAL CLASS DEFINITION
  #  * ====================== 
  #don't move modals dom position
  # force reflow
  
  # MODAL PRIVATE METHODS
  #  * ===================== 
  hideWithTransition = ->
    that = this
    timeout = setTimeout(->
      that.$element.off $.support.transition.end
      hideModal.call that
    , 500)
    @$element.one $.support.transition.end, ->
      clearTimeout timeout
      hideModal.call that

  hideModal = (that) ->
    @$element.hide().trigger "hidden"
    backdrop.call this
  backdrop = (callback) ->
    that = this
    animate = (if @$element.hasClass("fade") then "fade" else "")
    if @isShown and @options.backdrop
      doAnimate = $.support.transition and animate
      @$backdrop = $("<div class=\"modal-backdrop " + animate + "\" />").appendTo(document.body)
      @$backdrop.click $.proxy(@hide, this)  unless @options.backdrop is "static"
      @$backdrop[0].offsetWidth  if doAnimate # force reflow
      @$backdrop.addClass "in"
      (if doAnimate then @$backdrop.one($.support.transition.end, callback) else callback())
    else if not @isShown and @$backdrop
      @$backdrop.removeClass "in"
      (if $.support.transition and @$element.hasClass("fade") then @$backdrop.one($.support.transition.end, $.proxy(removeBackdrop, this)) else removeBackdrop.call(this))
    else callback()  if callback
  removeBackdrop = ->
    @$backdrop.remove()
    @$backdrop = null
  escape = ->
    that = this
    if @isShown and @options.keyboard
      $(document).on "keyup.dismiss.modal", (e) ->
        e.which is 27 and that.hide()

    else $(document).off "keyup.dismiss.modal"  unless @isShown
  "use strict"
  Modal = (content, options) ->
    @options = $.extend({}, $.fn.modal.defaults, options)
    @$element = $(content).delegate("[data-dismiss=\"modal\"]", "click.dismiss.modal", $.proxy(@hide, this))

  Modal:: =
    constructor: Modal
    toggle: ->
      this[(if not @isShown then "show" else "hide")]()

    show: ->
      that = this
      return  if @isShown
      $("body").addClass "modal-open"
      @isShown = true
      @$element.trigger "show"
      escape.call this
      backdrop.call this, ->
        transition = $.support.transition and that.$element.hasClass("fade")
        not that.$element.parent().length and that.$element.appendTo(document.body)
        that.$element.show()
        that.$element[0].offsetWidth  if transition
        that.$element.addClass "in"
        (if transition then that.$element.one($.support.transition.end, ->
          that.$element.trigger "shown"
        ) else that.$element.trigger("shown"))


    hide: (e) ->
      e and e.preventDefault()
      return  unless @isShown
      that = this
      @isShown = false
      $("body").removeClass "modal-open"
      escape.call this
      @$element.trigger("hide").removeClass "in"
      (if $.support.transition and @$element.hasClass("fade") then hideWithTransition.call(this) else hideModal.call(this))

  
  # MODAL PLUGIN DEFINITION
  #  * ======================= 
  $.fn.modal = (option) ->
    @each ->
      $this = $(this)
      data = $this.data("modal")
      options = typeof option is "object" and option
      $this.data "modal", (data = new Modal(this, options))  unless data
      if typeof option is "string"
        data[option]()
      else
        data.show()


  $.fn.modal.defaults =
    backdrop: true
    keyboard: true

  $.fn.modal.Constructor = Modal
  
  # MODAL DATA-API
  #  * ============== 
  $ ->
    $("body").on "click.modal.data-api", "[data-toggle=\"modal\"]", (e) ->
      $this = $(this)
      href = undefined
      $target = $($this.attr("data-target") or (href = $this.attr("href")) and href.replace(/.*(?=#[^\s]+$)/, "")) #strip for ie7
      option = (if $target.data("modal") then "toggle" else $.extend({}, $target.data(), $this.data()))
      e.preventDefault()
      $target.modal option


(window.jQuery)
