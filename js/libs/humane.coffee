#
# * Javascript Humane Dates
# * Copyright (c) 2008 Dean Landolt (deanlandolt.com)
# * Re-write by Zach Leatherman (zachleat.com)
# *
# * Adopted from the John Resig's pretty.js
# * at http://ejohn.org/blog/javascript-pretty-date
# * and henrah's proposed modification
# * at http://ejohn.org/blog/javascript-pretty-date/#comment-297458
# *
# * Licensed under the MIT license.
# 
humaneDate = (date, compareTo) ->
  # 60 minutes, 1 minute
  # 24 hours, 1 hour
  # 7 days, 1 day
  # ~1 month, 1 week
  # 1 year, ~1 month
  # Infinity, 1 year
  
  # if we received a GMT time from a string, doesn't include time zone bias
  # if we got a date object, the time zone is built in, we need to remove it.
  
  #
  #     * 0 seconds && < 60 seconds        Now
  #     * 60 seconds                       1 Minute
  #     * > 60 seconds && < 60 minutes     X Minutes
  #     * 60 minutes                       1 Hour
  #     * > 60 minutes && < 24 hours       X Hours
  #     * 24 hours                         1 Day
  #     * > 24 hours && < 7 days           X Days
  #     * 7 days                           1 Week
  #     * > 7 days && < ~ 1 Month          X Weeks
  #     * ~ 1 Month                        1 Month
  #     * > ~ 1 Month && < 1 Year          X Months
  #     * 1 Year                           1 Year
  #     * > 1 Year                         X Years
  #     *
  #     * Single units are +10%. 1 Year shows first at 1 Year + 10%
  #     
  normalize = (val, single) ->
    margin = 0.1
    return single  if val >= single and val <= single * (1 + margin)
    val
  return  unless date
  lang =
    ago: "Ago"
    from: ""
    now: "Just Now"
    minute: "Minute"
    minutes: "Minutes"
    hour: "Hour"
    hours: "Hours"
    day: "Day"
    days: "Days"
    week: "Week"
    weeks: "Weeks"
    month: "Month"
    months: "Months"
    year: "Year"
    years: "Years"

  formats = [[60, lang.now], [3600, lang.minute, lang.minutes, 60], [86400, lang.hour, lang.hours, 3600], [604800, lang.day, lang.days, 86400], [2628000, lang.week, lang.weeks, 604800], [31536000, lang.month, lang.months, 2628000], [Infinity, lang.year, lang.years, 31536000]]
  isString = typeof date is "string"
  date = (if isString then new Date(("" + date).replace(/-/g, "/").replace(/[TZ]/g, " ")) else date)
  compareTo = compareTo or new Date
  seconds = (compareTo - date + (compareTo.getTimezoneOffset() - ((if isString then 0 else date.getTimezoneOffset()))) * 60000) / 1000
  token = undefined
  if seconds < 0
    seconds = Math.abs(seconds)
    token = (if lang.from then " " + lang.from else "")
  else
    token = (if lang.ago then " " + lang.ago else "")
  i = 0
  format = formats[0]

  while formats[i]
    if seconds < format[0]
      
      # Now
      return format[1]  if i is 0
      val = Math.ceil(normalize(seconds, format[3]) / (format[3]))
      return val + " " + ((if val isnt 1 then format[2] else format[1])) + ((if i > 0 then token else ""))
    format = formats[++i]
unless typeof jQuery is "undefined"
  jQuery.fn.humaneDates = (options) ->
    settings = jQuery.extend(
      lowercase: false
    , options)
    @each ->
      $t = jQuery(this)
      date = $t.attr("datetime") or $t.attr("title")
      date = humaneDate(date)
      date = date.toLowerCase()  if date and settings["lowercase"]
      
      # don't modify the dom if we don't have to
      $t.html date  if date and $t.html() isnt date

