"use strict"
humaneDate = window.humaneDate
tmpl = window.tmpl
# Error handling
$.ajaxSetup error: (jqXHR, status, error) ->
  $("#generic-ajax-error").show().delay(2000).hide "fast"

class ProgressBar extends Spine.Controller
  constructor: ->
    super
    @progress = 0
  
  render: =>
    percent = Math.round(@progress * 100)
    $("#progress-text").html percent + "%"
    $("#progress-bar").css "width", percent + "%"
    if percent is 100
      $("#progress-text").css "left", "40%"
    else
      $("#progress-text").css "left", "45%"


#/ An Euler/UVa user
class User extends Spine.Model
  @configure 'User', 'name', 'uva_id', 'uva_uname',
    'uva_ac', 'uva_nsubs', 'uva_ntried',
    'uva_grank', 'uva_last_sub',
    'euler_id', 'euler_solved',
    'cf_id', 'cf_rating',
    'cf_nrounds'

  @extend Spine.Model.Ajax

# An item in the table
class UserItem extends Spine.Controller
  constructor: ->
    super
    if not @item then throw "@item required"
    @item.bind('update', @render)
    @item.bind('destroy', @remove)

  tag: "tr"

  render: =>
    rendered = tmpl.user(
      user: this
      lastUvaSubHumane: if @uva_last_sub then humaneDate(new Date(@uva_last_sub)).toLowerCase() else ""
    )
    @html(rendered)
    @

  remove: =>
    @el.remove()


# The users
class Users extends Spine.Controller
  constructor: ->
    super
    User.bind('refresh', @addAll)
    User.bind('create', @addOne)
  
  addOne: (item) =>
    @append(new UserItem(item: item).render())

  addAll: =>
    @html('')
    User.each(@addOne)

User.fetch()

users = undefined
updateAndRenderAll = ->
  updateProgress 0
  $("#refresh-rankings").button "loading"
  nUpdated = 0
  $.each users.fetch(), (idx, def) ->
    def.done ->
      ++nUpdated
      updateProgress nUpdated / users.list.length
      $("#refresh-rankings").button "reset"  if nUpdated is users.list.length
      users.updateUvaRanks()
      users.render()

users.el = $("#users tbody")
updateAndRenderAll()
$("#refresh-rankings").click updateAndRenderAll
