"use strict"
humaneDate = window.humaneDate
tmpl = window.tmpl
# Error handling
$.ajaxSetup error: (jqXHR, status, error) ->
  $("#generic-ajax-error").show().delay(2000).hide "fast"

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
    User.bind('fetch', @onFetch)
    @items = []
  
  @_sortHelper: (a, b) ->
    if a.uva_ac != b.uva_ac then a.uva_ac > b.uva_ac else a.uva_nsubs < b.uva_nsubs

  # Sort the users
  sort: ->
    @items.sort(@_sortHelper)

  render: =>
    @html('')
    for item in @items
      @append(item.render())

  addOne: (user) =>
    item = new UserItem(item: user)
    @items.push(item)
    @sort()
    @render()

  addAll: =>
    @html('')
    User.each(@addOne)
  
  onFetch: =>
    @$('tr').addClass('awesome')



User.fetch()
