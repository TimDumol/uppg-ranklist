"use strict"
humaneDate = window.humaneDate
tmpl = window.tmpl
# Error handling
$.ajaxSetup error: (jqXHR, status, error) ->
  $("#generic-ajax-error").show().delay(2000).hide "fast"

#/ An Euler/UVa rank
class Rank extends Spine.Model
  @configure 'Rank', 'name', 'uva_id', 'uva_uname',
    'uva_ac', 'uva_nsubs', 'uva_ntried',
    'uva_grank', 'uva_last_sub',
    'euler_id', 'euler_solved',
    'cf_id', 'cf_rating',
    'groups'

  @extend Spine.Model.Ajax


# An item in the table
class RankItem extends Spine.Controller
  constructor: ->
    super
    if not @item then throw "@item required"
    @item.bind('update', @render)
    @item.bind('destroy', @remove)

  tag: "tr"

  render: =>
    rendered = tmpl.rank(
      rank: this
      lastUvaSubHumane: if @uva_last_sub then humaneDate(new Date(@uva_last_sub)).toLowerCase() else ""
    )
    @html(rendered)
    @

  remove: =>
    @el.remove()


# The ranks
class Ranks extends Spine.Controller
  constructor: ->
    super
    Rank.bind('refresh', @addAll)
    Rank.bind('create', @addOne)
    @items = []
  
  @_uvaSortHelper: (a, b) ->
    if a.uva_ac != b.uva_ac then a.uva_ac > b.uva_ac else a.uva_nsubs < b.uva_nsubs

  @_eulerSortHelper: (a, b) -> a.euler_solved > b.euler_solved

  @_cfSortHelper: (a, b) -> a.cf_rating > b.cf_rating

  # Sort the ranks
  sort: ->
    @items.sort(@_sortHelper)
    for item, i in @items
      item.uva_lrank = i+1

  render: =>
    @html('')
    for item in @items
      @append(item.render())

  addOne: (rank) =>
    item = new RankItem(item: rank)
    @items.push(item)
    @sort()
    @render()

  addAll: =>
    @html('')
    Rank.each(@addOne)
  

class App extends Spine.Controller
  constructor: ->
    super
    Rank.fetch()

app = new App()
