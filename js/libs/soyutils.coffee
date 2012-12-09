#
# * Copyright 2008 Google Inc.
# *
# * Licensed under the Apache License, Version 2.0 (the "License");
# * you may not use this file except in compliance with the License.
# * You may obtain a copy of the License at
# *
# *     http://www.apache.org/licenses/LICENSE-2.0
# *
# * Unless required by applicable law or agreed to in writing, software
# * distributed under the License is distributed on an "AS IS" BASIS,
# * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# * See the License for the specific language governing permissions and
# * limitations under the License.
# 

###
@fileoverview
Utility functions and classes for Soy.

<p>
The top portion of this file contains utilities for Soy users:<ul>
<li> soy.StringBuilder: Compatible with the 'stringbuilder' code style.
<li> soy.renderElement: Render template and set as innerHTML of an element.
<li> soy.renderAsFragment: Render template and return as HTML fragment.
</ul>

<p>
The bottom portion of this file contains utilities that should only be called
by Soy-generated JS code. Please do not use these functions directly from
your hand-writen code. Their names all start with '$$'.
###

# COPIED FROM nogoog_shim.js

# Create closure namespaces.
goog = goog or {}
goog.inherits = (childCtor, parentCtor) ->
  
  ###
  @constructor
  ###
  tempCtor = ->
  tempCtor:: = parentCtor::
  childCtor.superClass_ = parentCtor::
  childCtor:: = new tempCtor()
  childCtor::constructor = childCtor


# Just enough browser detection for this file.
unless goog.userAgent
  goog.userAgent = (->
    userAgent = ""
    userAgent = navigator.userAgent  if "undefined" isnt typeof navigator and navigator and "string" is typeof navigator.userAgent
    isOpera = userAgent.indexOf("Opera") is 0
    
    ###
    @type {boolean}
    ###
    HAS_JSCRIPT: typeof "ScriptEngine" of this
    
    ###
    @type {boolean}
    ###
    IS_OPERA: isOpera
    
    ###
    @type {boolean}
    ###
    IS_IE: not isOpera and userAgent.indexOf("MSIE") isnt -1
    
    ###
    @type {boolean}
    ###
    IS_WEBKIT: not isOpera and userAgent.indexOf("WebKit") isnt -1
  )()

###
@param {...*} var_args
###
goog.asserts = fail: (var_args) ->  unless goog.asserts

# Stub out the document wrapper used by renderAs*.
unless goog.dom
  goog.dom = {}
  
  ###
  @param {Document=} d
  @constructor
  ###
  goog.dom.DomHelper = (d) ->
    @document_ = d or document

  
  ###
  @return {!Document}
  ###
  goog.dom.DomHelper::getDocument = ->
    @document_

  
  ###
  Creates a new element.
  @param {string} name Tag name.
  @return {!Element}
  ###
  goog.dom.DomHelper::createElement = (name) ->
    @document_.createElement name

  
  ###
  Creates a new document fragment.
  @return {!DocumentFragment}
  ###
  goog.dom.DomHelper::createDocumentFragment = ->
    @document_.createDocumentFragment()
unless goog.format
  goog.format =
    insertWordBreaks: (str, maxCharsBetweenWordBreaks) ->
      str = String(str)
      resultArr = []
      resultArrLen = 0
      
      # These variables keep track of important state inside str.
      isInTag = false # whether we're inside an HTML tag
      isMaybeInEntity = false # whether we might be inside an HTML entity
      numCharsWithoutBreak = 0 # number of chars since last word break
      flushIndex = 0 # index of first char not yet flushed to resultArr
      i = 0
      n = str.length

      while i < n
        charCode = str.charCodeAt(i)
        
        # If hit maxCharsBetweenWordBreaks, and not space next, then add <wbr>.
        
        # space
        if numCharsWithoutBreak >= maxCharsBetweenWordBreaks and charCode isnt 32
          resultArr[resultArrLen++] = str.substring(flushIndex, i)
          flushIndex = i
          resultArr[resultArrLen++] = goog.format.WORD_BREAK
          numCharsWithoutBreak = 0
        if isInTag
          
          # If inside an HTML tag and we see '>', it's the end of the tag.
          isInTag = false  if charCode is 62
        else if isMaybeInEntity
          switch charCode
            
            # Inside an entity, a ';' is the end of the entity.
            # The entity that just ended counts as one char, so increment
            # numCharsWithoutBreak.
            when 59 # ';'
              isMaybeInEntity = false
              ++numCharsWithoutBreak
            
            # If maybe inside an entity and we see '<', we weren't actually in
            # an entity. But now we're inside and HTML tag.
            when 60 # '<'
              isMaybeInEntity = false
              isInTag = true
            
            # If maybe inside an entity and we see ' ', we weren't actually in
            # an entity. Just correct the state and reset the
            # numCharsWithoutBreak since we just saw a space.
            when 32 # ' '
              isMaybeInEntity = false
              numCharsWithoutBreak = 0
        else # !isInTag && !isInEntity
          switch charCode
            
            # When not within a tag or an entity and we see '<', we're now
            # inside an HTML tag.
            when 60 # '<'
              isInTag = true
            
            # When not within a tag or an entity and we see '&', we might be
            # inside an entity.
            when 38 # '&'
              isMaybeInEntity = true
            
            # When we see a space, reset the numCharsWithoutBreak count.
            when 32 # ' '
              numCharsWithoutBreak = 0
            
            # When we see a non-space, increment the numCharsWithoutBreak.
            else
              ++numCharsWithoutBreak
        ++i
      
      # Flush the remaining chars at the end of the string.
      resultArr[resultArrLen++] = str.substring(flushIndex)
      resultArr.join ""

    
    ###
    String inserted as a word break by insertWordBreaks(). Safari requires
    <wbr></wbr>, Opera needs the 'shy' entity, though this will give a
    visible hyphen at breaks. Other browsers just use <wbr>.
    @type {string}
    @private
    ###
    WORD_BREAK: (if goog.userAgent.IS_WEBKIT then "<wbr></wbr>" else (if goog.userAgent.IS_OPERA then "&shy;" else "<wbr>"))
unless goog.i18n
  goog.i18n = bidi:
    
    ###
    Check the directionality of a piece of text, return true if the piece
    of text should be laid out in RTL direction.
    @param {string} text The piece of text that need to be detected.
    @param {boolean=} opt_isHtml Whether {@code text} is HTML/HTML-escaped.
    Default: false.
    @return {boolean}
    @private
    ###
    detectRtlDirectionality: (text, opt_isHtml) ->
      text = soyshim.$$bidiStripHtmlIfNecessary_(text, opt_isHtml)
      soyshim.$$bidiRtlWordRatio_(text) > soyshim.$$bidiRtlDetectionThreshold_

###
Directionality enum.
@enum {number}
###
goog.i18n.bidi.Dir =
  RTL: -1
  UNKNOWN: 0
  LTR: 1


###
Convert a directionality given in various formats to a goog.i18n.bidi.Dir
constant. Useful for interaction with different standards of directionality
representation.

@param {goog.i18n.bidi.Dir|number|boolean} givenDir Directionality given in
one of the following formats:
1. A goog.i18n.bidi.Dir constant.
2. A number (positive = LRT, negative = RTL, 0 = unknown).
3. A boolean (true = RTL, false = LTR).
@return {goog.i18n.bidi.Dir} A goog.i18n.bidi.Dir constant matching the given
directionality.
###
goog.i18n.bidi.toDir = (givenDir) ->
  if typeof givenDir is "number"
    (if givenDir > 0 then goog.i18n.bidi.Dir.LTR else (if givenDir < 0 then goog.i18n.bidi.Dir.RTL else goog.i18n.bidi.Dir.UNKNOWN))
  else
    (if givenDir then goog.i18n.bidi.Dir.RTL else goog.i18n.bidi.Dir.LTR)


###
Utility class for formatting text for display in a potentially
opposite-directionality context without garbling. Provides the following
functionality:

@param {goog.i18n.bidi.Dir|number|boolean} dir The context
directionality as a number
(positive = LRT, negative = RTL, 0 = unknown).
@constructor
###
goog.i18n.BidiFormatter = (dir) ->
  @dir_ = goog.i18n.bidi.toDir(dir)


###
Returns "dir=ltr" or "dir=rtl", depending on {@code text}'s estimated
directionality, if it is not the same as the context directionality.
Otherwise, returns the empty string.

@param {string} text Text whose directionality is to be estimated.
@param {boolean=} opt_isHtml Whether {@code text} is HTML / HTML-escaped.
Default: false.
@return {string} "dir=rtl" for RTL text in non-RTL context; "dir=ltr" for LTR
text in non-LTR context; else, the empty string.
###
goog.i18n.BidiFormatter::dirAttr = (text, opt_isHtml) ->
  dir = soy.$$bidiTextDir(text, opt_isHtml)
  (if dir and dir isnt @dir_ then (if dir < 0 then "dir=rtl" else "dir=ltr") else "")


###
Returns the trailing horizontal edge, i.e. "right" or "left", depending on
the global bidi directionality.
@return {string} "left" for RTL context and "right" otherwise.
###
goog.i18n.BidiFormatter::endEdge = ->
  (if @dir_ < 0 then "left" else "right")


###
Returns the Unicode BiDi mark matching the context directionality (LRM for
LTR context directionality, RLM for RTL context directionality), or the
empty string for neutral / unknown context directionality.

@return {string} LRM for LTR context directionality and RLM for RTL context
directionality.
###
goog.i18n.BidiFormatter::mark = ->
  #LRM
  #RLM
  (if (@dir_ > 0) then "‎" else (if (@dir_ < 0) then "‏" else ""))


###
Returns a Unicode BiDi mark matching the context directionality (LRM or RLM)
if the directionality or the exit directionality of {@code text} are opposite
to the context directionality. Otherwise returns the empty string.

@param {string} text The input text.
@param {boolean=} opt_isHtml Whether {@code text} is HTML / HTML-escaped.
Default: false.
@return {string} A Unicode bidi mark matching the global directionality or
the empty string.
###
goog.i18n.BidiFormatter::markAfter = (text, opt_isHtml) ->
  dir = soy.$$bidiTextDir(text, opt_isHtml)
  soyshim.$$bidiMarkAfterKnownDir_ @dir_, dir, text, opt_isHtml


###
Formats a string of unknown directionality for use in HTML output of the
context directionality, so an opposite-directionality string is neither
garbled nor garbles what follows it.

@param {string} str The input text.
@param {boolean=} placeholder This argument exists for consistency with the
Closure Library. Specifying it has no effect.
@return {string} Input text after applying the above processing.
###
goog.i18n.BidiFormatter::spanWrap = (str, placeholder) ->
  str = String(str)
  textDir = soy.$$bidiTextDir(str, true)
  reset = soyshim.$$bidiMarkAfterKnownDir_(@dir_, textDir, str, true)
  if textDir > 0 and @dir_ <= 0
    str = "<span dir=ltr>" + str + "</span>"
  else str = "<span dir=rtl>" + str + "</span>"  if textDir < 0 and @dir_ >= 0
  str + reset


###
Returns the leading horizontal edge, i.e. "left" or "right", depending on
the global bidi directionality.
@return {string} "right" for RTL context and "left" otherwise.
###
goog.i18n.BidiFormatter::startEdge = ->
  (if @dir_ < 0 then "right" else "left")


###
Formats a string of unknown directionality for use in plain-text output of
the context directionality, so an opposite-directionality string is neither
garbled nor garbles what follows it.
As opposed to {@link #spanWrap}, this makes use of unicode BiDi formatting
characters. In HTML, its *only* valid use is inside of elements that do not
allow mark-up, e.g. an 'option' tag.

@param {string} str The input text.
@param {boolean=} placeholder This argument exists for consistency with the
Closure Library. Specifying it has no effect.
@return {string} Input text after applying the above processing.
###
goog.i18n.BidiFormatter::unicodeWrap = (str, placeholder) ->
  str = String(str)
  textDir = soy.$$bidiTextDir(str, true)
  reset = soyshim.$$bidiMarkAfterKnownDir_(@dir_, textDir, str, true)
  if textDir > 0 and @dir_ <= 0
    str = "‪" + str + "‬"
  else str = "‫" + str + "‬"  if textDir < 0 and @dir_ >= 0
  str + reset

goog.string =
  
  ###
  Converts \r\n, \r, and \n to <br>s
  @param {*} str The string in which to convert newlines.
  @param {boolean=} opt_xml Whether to use XML compatible tags.
  @return {string} A copy of {@code str} with converted newlines.
  ###
  newLineToBr: (str, opt_xml) ->
    str = String(str)
    
    # This quick test helps in the case when there are no chars to replace,
    # in the worst case this makes barely a difference to the time taken.
    return str  unless goog.string.NEWLINE_TO_BR_RE_.test(str)
    str.replace /(\r\n|\r|\n)/g, (if opt_xml then "<br />" else "<br>")

  urlEncode: encodeURIComponent
  
  ###
  Regular expression used within newlineToBr().
  @type {RegExp}
  @private
  ###
  NEWLINE_TO_BR_RE_: /[\r\n]/


###
Utility class to facilitate much faster string concatenation in IE,
using Array.join() rather than the '+' operator.  For other browsers
we simply use the '+' operator.

@param {Object|number|string|boolean=} opt_a1 Optional first initial item
to append.
@param {...Object|number|string|boolean} var_args Other initial items to
append, e.g., new goog.string.StringBuffer('foo', 'bar').
@constructor
###
goog.string.StringBuffer = (opt_a1, var_args) ->
  
  ###
  Internal buffer for the string to be concatenated.
  @type {string|Array}
  @private
  ###
  @buffer_ = (if goog.userAgent.HAS_JSCRIPT then [] else "")
  @append.apply this, arguments_  if opt_a1?


###
Length of internal buffer (faster than calling buffer_.length).
Only used for IE.
@type {number}
@private
###
goog.string.StringBuffer::bufferLength_ = 0

###
Appends one or more items to the string.

Calling this with null, undefined, or empty arguments is an error.

@param {Object|number|string|boolean} a1 Required first string.
@param {Object|number|string|boolean=} opt_a2 Optional second string.
@param {...Object|number|string|boolean} var_args Other items to append,
e.g., sb.append('foo', 'bar', 'baz').
@return {goog.string.StringBuffer} This same StringBuilder object.
###
goog.string.StringBuffer::append = (a1, opt_a2, var_args) ->
  if goog.userAgent.HAS_JSCRIPT
    unless opt_a2? # no second argument (note: undefined == null)
      # Array assignment is 2x faster than Array push.  Also, use a1
      # directly to avoid arguments instantiation, another 2x improvement.
      @buffer_[@bufferLength_++] = a1
    else
      arr = @buffer_ ###
@type {Array.<number|string|boolean>}
###
      arr.push.apply arr, arguments_
      @bufferLength_ = @buffer_.length
  else
    
    # Use a1 directly to avoid arguments instantiation for single-arg case.
    @buffer_ += a1
    if opt_a2? # no second argument (note: undefined == null)
      i = 1

      while i < arguments_.length
        @buffer_ += arguments_[i]
        i++
  this


###
Clears the string.
###
goog.string.StringBuffer::clear = ->
  if goog.userAgent.HAS_JSCRIPT
    @buffer_.length = 0 # reuse array to avoid creating new object
    @bufferLength_ = 0
  else
    @buffer_ = ""


###
Returns the concatenated string.

@return {string} The concatenated string.
###
goog.string.StringBuffer::toString = ->
  if goog.userAgent.HAS_JSCRIPT
    str = @buffer_.join("")
    
    # Given a string with the entire contents, simplify the StringBuilder by
    # setting its contents to only be this string, rather than many fragments.
    @clear()
    @append str  if str
    str
  else
    @buffer_ ###
@type {string}
###

unless goog.soy
  goog.soy =
    
    ###
    Helper function to render a Soy template and then set the
    output string as the innerHTML of an element. It is recommended
    to use this helper function instead of directly setting
    innerHTML in your hand-written code, so that it will be easier
    to audit the code for cross-site scripting vulnerabilities.
    
    @param {Function} template The Soy template defining element's content.
    @param {Object=} opt_templateData The data for the template.
    @param {Object=} opt_injectedData The injected data for the template.
    @param {(goog.dom.DomHelper|Document)=} opt_dom The context in which DOM
    nodes will be created.
    ###
    renderAsElement: (template, opt_templateData, opt_injectedData, opt_dom) ->
      ###
      @type {!Element}
      ###
      # asElement 
      soyshim.$$renderWithWrapper_ template, opt_templateData, opt_dom, true, opt_injectedData

    
    ###
    Helper function to render a Soy template into a single node or
    a document fragment. If the rendered HTML string represents a
    single node, then that node is returned (note that this is
    not* a fragment, despite them name of the method). Otherwise a
    document fragment is returned containing the rendered nodes.
    
    @param {Function} template The Soy template defining element's content.
    @param {Object=} opt_templateData The data for the template.
    @param {Object=} opt_injectedData The injected data for the template.
    @param {(goog.dom.DomHelper|Document)=} opt_dom The context in which DOM
    nodes will be created.
    @return {!Node} The resulting node or document fragment.
    ###
    renderAsFragment: (template, opt_templateData, opt_injectedData, opt_dom) ->
      # asElement 
      soyshim.$$renderWithWrapper_ template, opt_templateData, opt_dom, false, opt_injectedData

    
    ###
    Helper function to render a Soy template and then set the output string as
    the innerHTML of an element. It is recommended to use this helper function
    instead of directly setting innerHTML in your hand-written code, so that it
    will be easier to audit the code for cross-site scripting vulnerabilities.
    
    NOTE: New code should consider using goog.soy.renderElement instead.
    
    @param {Element} element The element whose content we are rendering.
    @param {Function} template The Soy template defining the element's content.
    @param {Object=} opt_templateData The data for the template.
    @param {Object=} opt_injectedData The injected data for the template.
    ###
    renderElement: (element, template, opt_templateData, opt_injectedData) ->
      element.innerHTML = template(opt_templateData, null, opt_injectedData)
soy = esc: {}
soydata = {}
soyshim = $$DEFAULT_TEMPLATE_DATA_: {}

###
Helper function to render a Soy template into a single node or a document
fragment. If the rendered HTML string represents a single node, then that
node is returned. Otherwise a document fragment is created and returned
(wrapped in a DIV element if #opt_singleNode is true).

@param {Function} template The Soy template defining the element's content.
@param {Object=} opt_templateData The data for the template.
@param {(goog.dom.DomHelper|Document)=} opt_dom The context in which DOM
nodes will be created.
@param {boolean=} opt_asElement Whether to wrap the fragment in an
element if the template does not render a single element. If true,
result is always an Element.
@param {Object=} opt_injectedData The injected data for the template.
@return {!Node} The resulting node or document fragment.
@private
###
soyshim.$$renderWithWrapper_ = (template, opt_templateData, opt_dom, opt_asElement, opt_injectedData) ->
  dom = opt_dom or document
  wrapper = dom.createElement("div")
  wrapper.innerHTML = template(opt_templateData or soyshim.$$DEFAULT_TEMPLATE_DATA_, `undefined`, opt_injectedData)
  
  # If the template renders as a single element, return it.
  if wrapper.childNodes.length is 1
    firstChild = wrapper.firstChild
    # Element 
    return (firstChild)  if not opt_asElement or firstChild.nodeType is 1 ###
@type {!Node}
###
  
  # If we're forcing it to be a single element, return the wrapper DIV.
  return wrapper  if opt_asElement
  
  # Otherwise, create and return a fragment.
  fragment = dom.createDocumentFragment()
  fragment.appendChild wrapper.firstChild  while wrapper.firstChild
  fragment


###
Returns a Unicode BiDi mark matching bidiGlobalDir (LRM or RLM) if the
directionality or the exit directionality of text are opposite to
bidiGlobalDir. Otherwise returns the empty string.
If opt_isHtml, makes sure to ignore the LTR nature of the mark-up and escapes
in text, making the logic suitable for HTML and HTML-escaped text.
@param {number} bidiGlobalDir The global directionality context: 1 if ltr, -1
if rtl, 0 if unknown.
@param {number} dir text's directionality: 1 if ltr, -1 if rtl, 0 if unknown.
@param {string} text The text whose directionality is to be estimated.
@param {boolean=} opt_isHtml Whether text is HTML/HTML-escaped.
Default: false.
@return {string} A Unicode bidi mark matching bidiGlobalDir, or
the empty string when text's overall and exit directionalities both match
bidiGlobalDir, or bidiGlobalDir is 0 (unknown).
@private
###
soyshim.$$bidiMarkAfterKnownDir_ = (bidiGlobalDir, dir, text, opt_isHtml) ->
  # LRM
  # RLM
  (if bidiGlobalDir > 0 and (dir < 0 or soyshim.$$bidiIsRtlExitText_(text, opt_isHtml)) then "‎" else (if bidiGlobalDir < 0 and (dir > 0 or soyshim.$$bidiIsLtrExitText_(text, opt_isHtml)) then "‏" else ""))


###
Strips str of any HTML mark-up and escapes. Imprecise in several ways, but
precision is not very important, since the result is only meant to be used
for directionality detection.
@param {string} str The string to be stripped.
@param {boolean=} opt_isHtml Whether str is HTML / HTML-escaped.
Default: false.
@return {string} The stripped string.
@private
###
soyshim.$$bidiStripHtmlIfNecessary_ = (str, opt_isHtml) ->
  (if opt_isHtml then str.replace(soyshim.$$BIDI_HTML_SKIP_RE_, " ") else str)


###
Simplified regular expression for am HTML tag (opening or closing) or an HTML
escape - the things we want to skip over in order to ignore their ltr
characters.
@type {RegExp}
@private
###
soyshim.$$BIDI_HTML_SKIP_RE_ = /<[^>]*>|&[^;]+;/g

###
A practical pattern to identify strong LTR character. This pattern is not
theoretically correct according to unicode standard. It is simplified for
performance and small code size.
@type {string}
@private
###
soyshim.$$bidiLtrChars_ = "A-Za-zÀ-ÖØ-öø-ʸ̀-֐ࠀ-῿" + "Ⰰ-﬜﷾-﹯﻽-￿"

###
A practical pattern to identify strong neutral and weak character. This
pattern is not theoretically correct according to unicode standard. It is
simplified for performance and small code size.
@type {string}
@private
###
soyshim.$$bidiNeutralChars_ = "\u0000- !-@[-`{-¿×÷ʹ-˿ -⯿"

###
A practical pattern to identify strong RTL character. This pattern is not
theoretically correct according to unicode standard. It is simplified for
performance and small code size.
@type {string}
@private
###
soyshim.$$bidiRtlChars_ = "֑-߿יִ-﷽ﹰ-ﻼ"

###
Regular expressions to check if a piece of text is of RTL directionality
on first character with strong directionality.
@type {RegExp}
@private
###
soyshim.$$bidiRtlDirCheckRe_ = new RegExp("^[^" + soyshim.$$bidiLtrChars_ + "]*[" + soyshim.$$bidiRtlChars_ + "]")

###
Regular expressions to check if a piece of text is of neutral directionality.
Url are considered as neutral.
@type {RegExp}
@private
###
soyshim.$$bidiNeutralDirCheckRe_ = new RegExp("^[" + soyshim.$$bidiNeutralChars_ + "]*$|^http://")

###
Check the directionality of the a piece of text based on the first character
with strong directionality.
@param {string} str string being checked.
@return {boolean} return true if rtl directionality is being detected.
@private
###
soyshim.$$bidiIsRtlText_ = (str) ->
  soyshim.$$bidiRtlDirCheckRe_.test str


###
Check the directionality of the a piece of text based on the first character
with strong directionality.
@param {string} str string being checked.
@return {boolean} true if all characters have neutral directionality.
@private
###
soyshim.$$bidiIsNeutralText_ = (str) ->
  soyshim.$$bidiNeutralDirCheckRe_.test str


###
This constant controls threshold of rtl directionality.
@type {number}
@private
###
soyshim.$$bidiRtlDetectionThreshold_ = 0.40

###
Returns the RTL ratio based on word count.
@param {string} str the string that need to be checked.
@return {number} the ratio of RTL words among all words with directionality.
@private
###
soyshim.$$bidiRtlWordRatio_ = (str) ->
  rtlCount = 0
  totalCount = 0
  tokens = str.split(" ")
  i = 0

  while i < tokens.length
    if soyshim.$$bidiIsRtlText_(tokens[i])
      rtlCount++
      totalCount++
    else totalCount++  unless soyshim.$$bidiIsNeutralText_(tokens[i])
    i++
  (if totalCount is 0 then 0 else rtlCount / totalCount)


###
Regular expressions to check if the last strongly-directional character in a
piece of text is LTR.
@type {RegExp}
@private
###
soyshim.$$bidiLtrExitDirCheckRe_ = new RegExp("[" + soyshim.$$bidiLtrChars_ + "][^" + soyshim.$$bidiRtlChars_ + "]*$")

###
Regular expressions to check if the last strongly-directional character in a
piece of text is RTL.
@type {RegExp}
@private
###
soyshim.$$bidiRtlExitDirCheckRe_ = new RegExp("[" + soyshim.$$bidiRtlChars_ + "][^" + soyshim.$$bidiLtrChars_ + "]*$")

###
Check if the exit directionality a piece of text is LTR, i.e. if the last
strongly-directional character in the string is LTR.
@param {string} str string being checked.
@param {boolean=} opt_isHtml Whether str is HTML / HTML-escaped.
Default: false.
@return {boolean} Whether LTR exit directionality was detected.
@private
###
soyshim.$$bidiIsLtrExitText_ = (str, opt_isHtml) ->
  str = soyshim.$$bidiStripHtmlIfNecessary_(str, opt_isHtml)
  soyshim.$$bidiLtrExitDirCheckRe_.test str


###
Check if the exit directionality a piece of text is RTL, i.e. if the last
strongly-directional character in the string is RTL.
@param {string} str string being checked.
@param {boolean=} opt_isHtml Whether str is HTML / HTML-escaped.
Default: false.
@return {boolean} Whether RTL exit directionality was detected.
@private
###
soyshim.$$bidiIsRtlExitText_ = (str, opt_isHtml) ->
  str = soyshim.$$bidiStripHtmlIfNecessary_(str, opt_isHtml)
  soyshim.$$bidiRtlExitDirCheckRe_.test str


# =============================================================================
# COPIED FROM soyutils_usegoog.js

# -----------------------------------------------------------------------------
# StringBuilder (compatible with the 'stringbuilder' code style).

###
Utility class to facilitate much faster string concatenation in IE,
using Array.join() rather than the '+' operator.  For other browsers
we simply use the '+' operator.

@param {Object} var_args Initial items to append,
e.g., new soy.StringBuilder('foo', 'bar').
@constructor
###
soy.StringBuilder = goog.string.StringBuffer

# -----------------------------------------------------------------------------
# soydata: Defines typed strings, e.g. an HTML string {@code "a<b>c"} is
# semantically distinct from the plain text string {@code "a<b>c"} and smart
# templates can take that distinction into account.

###
A type of textual content.
@enum {number}
###
soydata.SanitizedContentKind =
  
  ###
  A snippet of HTML that does not start or end inside a tag, comment, entity,
  or DOCTYPE; and that does not contain any executable code
  (JS, {@code <object>}s, etc.) from a different trust domain.
  ###
  HTML: 0
  
  ###
  A sequence of code units that can appear between quotes (either kind) in a
  JS program without causing a parse error, and without causing any side
  effects.
  <p>
  The content should not contain unescaped quotes, newlines, or anything else
  that would cause parsing to fail or to cause a JS parser to finish the
  string its parsing inside the content.
  <p>
  The content must also not end inside an escape sequence ; no partial octal
  escape sequences or odd number of '{@code \}'s at the end.
  ###
  JS_STR_CHARS: 1
  
  ###
  A properly encoded portion of a URI.
  ###
  URI: 2
  
  ###
  An attribute name and value such as {@code dir="ltr"}.
  ###
  HTML_ATTRIBUTE: 3


###
A string-like object that carries a content-type.
@param {string} content
@constructor
@private
###
soydata.SanitizedContent = (content) ->
  
  ###
  The textual content.
  @type {string}
  ###
  @content = content


###
@type {soydata.SanitizedContentKind}
###
soydata.SanitizedContent::contentKind

###
@override
###
soydata.SanitizedContent::toString = ->
  @content


###
Content of type {@link soydata.SanitizedContentKind.HTML}.
@param {string} content A string of HTML that can safely be embedded in
a PCDATA context in your app.  If you would be surprised to find that an
HTML sanitizer produced {@code s} (e.g. it runs code or fetches bad URLs)
and you wouldn't write a template that produces {@code s} on security or
privacy grounds, then don't pass {@code s} here.
@constructor
@extends {soydata.SanitizedContent}
###
soydata.SanitizedHtml = (content) ->
  soydata.SanitizedContent.call this, content

goog.inherits soydata.SanitizedHtml, soydata.SanitizedContent

###
@override
###
soydata.SanitizedHtml::contentKind = soydata.SanitizedContentKind.HTML

###
Content of type {@link soydata.SanitizedContentKind.JS_STR_CHARS}.
@param {string} content A string of JS that when evaled, produces a
value that does not depend on any sensitive data and has no side effects
<b>OR</b> a string of JS that does not reference any variables or have
any side effects not known statically to the app authors.
@constructor
@extends {soydata.SanitizedContent}
###
soydata.SanitizedJsStrChars = (content) ->
  soydata.SanitizedContent.call this, content

goog.inherits soydata.SanitizedJsStrChars, soydata.SanitizedContent

###
@override
###
soydata.SanitizedJsStrChars::contentKind = soydata.SanitizedContentKind.JS_STR_CHARS

###
Content of type {@link soydata.SanitizedContentKind.URI}.
@param {string} content A chunk of URI that the caller knows is safe to
emit in a template.
@constructor
@extends {soydata.SanitizedContent}
###
soydata.SanitizedUri = (content) ->
  soydata.SanitizedContent.call this, content

goog.inherits soydata.SanitizedUri, soydata.SanitizedContent

###
@override
###
soydata.SanitizedUri::contentKind = soydata.SanitizedContentKind.URI

###
Content of type {@link soydata.SanitizedContentKind.HTML_ATTRIBUTE}.
@param {string} content An attribute name and value, such as
{@code dir="ltr"}.
@constructor
@extends {soydata.SanitizedContent}
###
soydata.SanitizedHtmlAttribute = (content) ->
  soydata.SanitizedContent.call this, content

goog.inherits soydata.SanitizedHtmlAttribute, soydata.SanitizedContent

###
@override
###
soydata.SanitizedHtmlAttribute::contentKind = soydata.SanitizedContentKind.HTML_ATTRIBUTE

# -----------------------------------------------------------------------------
# Public utilities.

###
Helper function to render a Soy template and then set the output string as
the innerHTML of an element. It is recommended to use this helper function
instead of directly setting innerHTML in your hand-written code, so that it
will be easier to audit the code for cross-site scripting vulnerabilities.

NOTE: New code should consider using goog.soy.renderElement instead.

@param {Element} element The element whose content we are rendering.
@param {Function} template The Soy template defining the element's content.
@param {Object=} opt_templateData The data for the template.
@param {Object=} opt_injectedData The injected data for the template.
###
soy.renderElement = goog.soy.renderElement

###
Helper function to render a Soy template into a single node or a document
fragment. If the rendered HTML string represents a single node, then that
node is returned (note that this is *not* a fragment, despite them name of
the method). Otherwise a document fragment is returned containing the
rendered nodes.

NOTE: New code should consider using goog.soy.renderAsFragment
instead (note that the arguments are different).

@param {Function} template The Soy template defining the element's content.
@param {Object=} opt_templateData The data for the template.
@param {Document=} opt_document The document used to create DOM nodes. If not
specified, global document object is used.
@param {Object=} opt_injectedData The injected data for the template.
@return {!Node} The resulting node or document fragment.
###
soy.renderAsFragment = (template, opt_templateData, opt_document, opt_injectedData) ->
  goog.soy.renderAsFragment template, opt_templateData, opt_injectedData, new goog.dom.DomHelper(opt_document)


###
Helper function to render a Soy template into a single node. If the rendered
HTML string represents a single node, then that node is returned. Otherwise,
a DIV element is returned containing the rendered nodes.

NOTE: New code should consider using goog.soy.renderAsElement
instead (note that the arguments are different).

@param {Function} template The Soy template defining the element's content.
@param {Object=} opt_templateData The data for the template.
@param {Document=} opt_document The document used to create DOM nodes. If not
specified, global document object is used.
@param {Object=} opt_injectedData The injected data for the template.
@return {!Element} Rendered template contents, wrapped in a parent DIV
element if necessary.
###
soy.renderAsElement = (template, opt_templateData, opt_document, opt_injectedData) ->
  goog.soy.renderAsElement template, opt_templateData, opt_injectedData, new goog.dom.DomHelper(opt_document)


# -----------------------------------------------------------------------------
# Below are private utilities to be used by Soy-generated code only.

###
Builds an augmented data object to be passed when a template calls another,
and needs to pass both original data and additional params. The returned
object will contain both the original data and the additional params. If the
same key appears in both, then the value from the additional params will be
visible, while the value from the original data will be hidden. The original
data object will be used, but not modified.

@param {!Object} origData The original data to pass.
@param {Object} additionalParams The additional params to pass.
@return {Object} An augmented data object containing both the original data
and the additional params.
###
soy.$$augmentData = (origData, additionalParams) ->
  
  # Create a new object whose '__proto__' field is set to origData.
  ###
  @constructor
  ###
  TempCtor = ->
  TempCtor:: = origData
  newData = new TempCtor()
  
  # Add the additional params to the new object.
  for key of additionalParams
    newData[key] = additionalParams[key]
  newData


###
Gets the keys in a map as an array. There are no guarantees on the order.
@param {Object} map The map to get the keys of.
@return {Array.<string>} The array of keys in the given map.
###
soy.$$getMapKeys = (map) ->
  mapKeys = []
  for key of map
    mapKeys.push key
  mapKeys


###
Gets a consistent unique id for the given delegate template name. Two calls
to this function will return the same id if and only if the input names are
the same.

<p> Important: This function must always be called with a string constant.

<p> If Closure Compiler is not being used, then this is just this identity
function. If Closure Compiler is being used, then each call to this function
will be replaced with a short string constant, which will be consistent per
input name.

@param {string} delTemplateName The delegate template name for which to get a
consistent unique id.
@return {string} A unique id that is consistent per input name.

@consistentIdGenerator
###
soy.$$getDelegateId = (delTemplateName) ->
  delTemplateName


###
Map from registered delegate template id/name to the priority of the
implementation.
@type {Object}
@private
###
soy.$$DELEGATE_REGISTRY_PRIORITIES_ = {}

###
Map from registered delegate template id/name to the implementation function.
@type {Object}
@private
###
soy.$$DELEGATE_REGISTRY_FUNCTIONS_ = {}

###
Registers a delegate implementation. If the same delegate template id/name
has been registered previously, then priority values are compared and only
the higher priority implementation is stored (if priorities are equal, an
error is thrown).

@param {string} delTemplateId The delegate template id/name to register.
@param {number} delPriority The implementation's priority value.
@param {Function} delFn The implementation function.
###
soy.$$registerDelegateFn = (delTemplateId, delPriority, delFn) ->
  mapKey = "key_" + delTemplateId
  currPriority = soy.$$DELEGATE_REGISTRY_PRIORITIES_[mapKey]
  if currPriority is `undefined` or delPriority > currPriority
    
    # Registering new or higher-priority function: replace registry entry.
    soy.$$DELEGATE_REGISTRY_PRIORITIES_[mapKey] = delPriority
    soy.$$DELEGATE_REGISTRY_FUNCTIONS_[mapKey] = delFn
  else if delPriority is currPriority
    
    # Registering same-priority function: error.
    throw Error("Encountered two active delegates with same priority (id/name \"" + delTemplateId + "\").")
  else


# Registering lower-priority function: do nothing.

###
Retrieves the (highest-priority) implementation that has been registered for
a given delegate template id/name. If no implementation has been registered
for the id/name, then returns an implementation that is equivalent to an
empty template (i.e. rendered output would be empty string).

@param {string} delTemplateId The delegate template id/name to get.
@return {Function} The retrieved implementation function.
###
soy.$$getDelegateFn = (delTemplateId) ->
  delFn = soy.$$DELEGATE_REGISTRY_FUNCTIONS_["key_" + delTemplateId]
  (if delFn then delFn else soy.$$EMPTY_TEMPLATE_FN_)


###
Private helper soy.$$getDelegateFn(). This is the empty template function
that is returned whenever there's no delegate implementation found.

@param {Object.<string, *>=} opt_data
@param {soy.StringBuilder=} opt_sb
@param {Object.<string, *>=} opt_ijData
@return {string}
@private
###
soy.$$EMPTY_TEMPLATE_FN_ = (opt_data, opt_sb, opt_ijData) ->
  ""


# -----------------------------------------------------------------------------
# Escape/filter/normalize.

###
Escapes HTML special characters in a string.  Escapes double quote '"' in
addition to '&', '<', and '>' so that a string can be included in an HTML
tag attribute value within double quotes.
Will emit known safe HTML as-is.

@param {*} value The string-like value to be escaped.  May not be a string,
but the value will be coerced to a string.
@return {string} An escaped version of value.
###
soy.$$escapeHtml = (value) ->
  return value.content  if typeof value is "object" and value and value.contentKind is soydata.SanitizedContentKind.HTML
  soy.esc.$$escapeHtmlHelper value


###
Escapes HTML special characters in a string so that it can be embedded in
RCDATA.
<p>
Escapes HTML special characters so that the value will not prematurely end
the body of a tag like {@code <textarea>} or {@code <title>}.  RCDATA tags
cannot contain other HTML entities, so it is not strictly necessary to escape
HTML special characters except when part of that text looks like an HTML
entity or like a close tag : {@code </textarea>}.
<p>
Will normalize known safe HTML to make sure that sanitized HTML (which could
contain an innocuous {@code </textarea>} don't prematurely end an RCDATA
element.

@param {*} value The string-like value to be escaped.  May not be a string,
but the value will be coerced to a string.
@return {string} An escaped version of value.
###
soy.$$escapeHtmlRcdata = (value) ->
  return soy.esc.$$normalizeHtmlHelper(value.content)  if typeof value is "object" and value and value.contentKind is soydata.SanitizedContentKind.HTML
  soy.esc.$$escapeHtmlHelper value


###
Removes HTML tags from a string of known safe HTML so it can be used as an
attribute value.

@param {*} value The HTML to be escaped.  May not be a string, but the
value will be coerced to a string.
@return {string} A representation of value without tags, HTML comments, or
other content.
###
soy.$$stripHtmlTags = (value) ->
  String(value).replace soy.esc.$$HTML_TAG_REGEX_, ""


###
Escapes HTML special characters in an HTML attribute value.

@param {*} value The HTML to be escaped.  May not be a string, but the
value will be coerced to a string.
@return {string} An escaped version of value.
###
soy.$$escapeHtmlAttribute = (value) ->
  return soy.esc.$$normalizeHtmlHelper(soy.$$stripHtmlTags(value.content))  if typeof value is "object" and value and value.contentKind is soydata.SanitizedContentKind.HTML
  soy.esc.$$escapeHtmlHelper value


###
Escapes HTML special characters in a string including space and other
characters that can end an unquoted HTML attribute value.

@param {*} value The HTML to be escaped.  May not be a string, but the
value will be coerced to a string.
@return {string} An escaped version of value.
###
soy.$$escapeHtmlAttributeNospace = (value) ->
  return soy.esc.$$normalizeHtmlNospaceHelper(soy.$$stripHtmlTags(value.content))  if typeof value is "object" and value and value.contentKind is soydata.SanitizedContentKind.HTML
  soy.esc.$$escapeHtmlNospaceHelper value


###
Filters out strings that cannot be a substring of a valid HTML attribute.

@param {*} value The value to escape.  May not be a string, but the value
will be coerced to a string.
@return {string} A valid HTML attribute name part or name/value pair.
{@code "zSoyz"} if the input is invalid.
###
soy.$$filterHtmlAttribute = (value) ->
  return value.content.replace(RegExp("=([^\"']*)$"), "=\"$1\"")  if typeof value is "object" and value and value.contentKind is soydata.SanitizedContentKind.HTML_ATTRIBUTE
  soy.esc.$$filterHtmlAttributeHelper value


###
Filters out strings that cannot be a substring of a valid HTML element name.

@param {*} value The value to escape.  May not be a string, but the value
will be coerced to a string.
@return {string} A valid HTML element name part.
{@code "zSoyz"} if the input is invalid.
###
soy.$$filterHtmlElementName = (value) ->
  soy.esc.$$filterHtmlElementNameHelper value


###
Escapes characters in the value to make it valid content for a JS string
literal.

@param {*} value The value to escape.  May not be a string, but the value
will be coerced to a string.
@return {string} An escaped version of value.
@deprecated
###
soy.$$escapeJs = (value) ->
  soy.$$escapeJsString value


###
Escapes characters in the value to make it valid content for a JS string
literal.

@param {*} value The value to escape.  May not be a string, but the value
will be coerced to a string.
@return {string} An escaped version of value.
###
soy.$$escapeJsString = (value) ->
  return value.content  if typeof value is "object" and value.contentKind is soydata.SanitizedContentKind.JS_STR_CHARS
  soy.esc.$$escapeJsStringHelper value


###
Encodes a value as a JavaScript literal.

@param {*} value The value to escape.  May not be a string, but the value
will be coerced to a string.
@return {string} A JavaScript code representation of the input.
###
soy.$$escapeJsValue = (value) ->
  
  # We surround values with spaces so that they can't be interpolated into
  # identifiers by accident.
  # We could use parentheses but those might be interpreted as a function call.
  # Intentionally matches undefined.
  # Java returns null from maps where there is no corresponding key while
  # JS returns undefined.
  # We always output null for compatibility with Java which does not have a
  # distinct undefined value.
  return " null "  unless value?
  switch typeof value
    when "boolean", "number"
      " " + value + " "
    else
      "'" + soy.esc.$$escapeJsStringHelper(String(value)) + "'"


###
Escapes characters in the string to make it valid content for a JS regular
expression literal.

@param {*} value The value to escape.  May not be a string, but the value
will be coerced to a string.
@return {string} An escaped version of value.
###
soy.$$escapeJsRegex = (value) ->
  soy.esc.$$escapeJsRegexHelper value


###
Matches all URI mark characters that conflict with HTML attribute delimiters
or that cannot appear in a CSS uri.
From <a href="http://www.w3.org/TR/CSS2/grammar.html">G.2: CSS grammar</a>
<pre>
url        ([!#$%&*-~]|{nonascii}|{escape})*
</pre>

@type {RegExp}
@private
###
soy.$$problematicUriMarks_ = /['()]/g

###
@param {string} ch A single character in {@link soy.$$problematicUriMarks_}.
@return {string}
@private
###
soy.$$pctEncode_ = (ch) ->
  "%" + ch.charCodeAt(0).toString(16)


###
Escapes a string so that it can be safely included in a URI.

@param {*} value The value to escape.  May not be a string, but the value
will be coerced to a string.
@return {string} An escaped version of value.
###
soy.$$escapeUri = (value) ->
  return soy.$$normalizeUri(value)  if typeof value is "object" and value.contentKind is soydata.SanitizedContentKind.URI
  
  # Apostophes and parentheses are not matched by encodeURIComponent.
  # They are technically special in URIs, but only appear in the obsolete mark
  # production in Appendix D.2 of RFC 3986, so can be encoded without changing
  # semantics.
  encoded = soy.esc.$$escapeUriHelper(value)
  soy.$$problematicUriMarks_.lastIndex = 0
  return encoded.replace(soy.$$problematicUriMarks_, soy.$$pctEncode_)  if soy.$$problematicUriMarks_.test(encoded)
  encoded


###
Removes rough edges from a URI by escaping any raw HTML/JS string delimiters.

@param {*} value The value to escape.  May not be a string, but the value
will be coerced to a string.
@return {string} An escaped version of value.
###
soy.$$normalizeUri = (value) ->
  soy.esc.$$normalizeUriHelper value


###
Vets a URI's protocol and removes rough edges from a URI by escaping
any raw HTML/JS string delimiters.

@param {*} value The value to escape.  May not be a string, but the value
will be coerced to a string.
@return {string} An escaped version of value.
###
soy.$$filterNormalizeUri = (value) ->
  soy.esc.$$filterNormalizeUriHelper value


###
Escapes a string so it can safely be included inside a quoted CSS string.

@param {*} value The value to escape.  May not be a string, but the value
will be coerced to a string.
@return {string} An escaped version of value.
###
soy.$$escapeCssString = (value) ->
  soy.esc.$$escapeCssStringHelper value


###
Encodes a value as a CSS identifier part, keyword, or quantity.

@param {*} value The value to escape.  May not be a string, but the value
will be coerced to a string.
@return {string} A safe CSS identifier part, keyword, or quanitity.
###
soy.$$filterCssValue = (value) ->
  
  # Uses == to intentionally match null and undefined for Java compatibility.
  return ""  unless value?
  soy.esc.$$filterCssValueHelper value


# -----------------------------------------------------------------------------
# Basic directives/functions.

###
Converts \r\n, \r, and \n to <br>s
@param {*} str The string in which to convert newlines.
@return {string} A copy of {@code str} with converted newlines.
###
soy.$$changeNewlineToBr = (str) ->
  goog.string.newLineToBr String(str), false


###
Inserts word breaks ('wbr' tags) into a HTML string at a given interval. The
counter is reset if a space is encountered. Word breaks aren't inserted into
HTML tags or entities. Entites count towards the character count; HTML tags
do not.

@param {*} str The HTML string to insert word breaks into. Can be other
types, but the value will be coerced to a string.
@param {number} maxCharsBetweenWordBreaks Maximum number of non-space
characters to allow before adding a word break.
@return {string} The string including word breaks.
###
soy.$$insertWordBreaks = (str, maxCharsBetweenWordBreaks) ->
  goog.format.insertWordBreaks String(str), maxCharsBetweenWordBreaks


###
Truncates a string to a given max length (if it's currently longer),
optionally adding ellipsis at the end.

@param {*} str The string to truncate. Can be other types, but the value will
be coerced to a string.
@param {number} maxLen The maximum length of the string after truncation
(including ellipsis, if applicable).
@param {boolean} doAddEllipsis Whether to add ellipsis if the string needs
truncation.
@return {string} The string after truncation.
###
soy.$$truncate = (str, maxLen, doAddEllipsis) ->
  str = String(str)
  return str  if str.length <= maxLen # no need to truncate
  
  # If doAddEllipsis, either reduce maxLen to compensate, or else if maxLen is
  # too small, just turn off doAddEllipsis.
  if doAddEllipsis
    if maxLen > 3
      maxLen -= 3
    else
      doAddEllipsis = false
  
  # Make sure truncating at maxLen doesn't cut up a unicode surrogate pair.
  maxLen -= 1  if soy.$$isHighSurrogate_(str.charAt(maxLen - 1)) and soy.$$isLowSurrogate_(str.charAt(maxLen))
  
  # Truncate.
  str = str.substring(0, maxLen)
  
  # Add ellipsis.
  str += "..."  if doAddEllipsis
  str


###
Private helper for $$truncate() to check whether a char is a high surrogate.
@param {string} ch The char to check.
@return {boolean} Whether the given char is a unicode high surrogate.
@private
###
soy.$$isHighSurrogate_ = (ch) ->
  0xD800 <= ch and ch <= 0xDBFF


###
Private helper for $$truncate() to check whether a char is a low surrogate.
@param {string} ch The char to check.
@return {boolean} Whether the given char is a unicode low surrogate.
@private
###
soy.$$isLowSurrogate_ = (ch) ->
  0xDC00 <= ch and ch <= 0xDFFF


# -----------------------------------------------------------------------------
# Bidi directives/functions.

###
Cache of bidi formatter by context directionality, so we don't keep on
creating new objects.
@type {!Object.<!goog.i18n.BidiFormatter>}
@private
###
soy.$$bidiFormatterCache_ = {}

###
Returns cached bidi formatter for bidiGlobalDir, or creates a new one.
@param {number} bidiGlobalDir The global directionality context: 1 if ltr, -1
if rtl, 0 if unknown.
@return {goog.i18n.BidiFormatter} A formatter for bidiGlobalDir.
@private
###
soy.$$getBidiFormatterInstance_ = (bidiGlobalDir) ->
  soy.$$bidiFormatterCache_[bidiGlobalDir] or (soy.$$bidiFormatterCache_[bidiGlobalDir] = new goog.i18n.BidiFormatter(bidiGlobalDir))


###
Estimate the overall directionality of text. If opt_isHtml, makes sure to
ignore the LTR nature of the mark-up and escapes in text, making the logic
suitable for HTML and HTML-escaped text.
@param {string} text The text whose directionality is to be estimated.
@param {boolean=} opt_isHtml Whether text is HTML/HTML-escaped.
Default: false.
@return {number} 1 if text is LTR, -1 if it is RTL, and 0 if it is neutral.
###
soy.$$bidiTextDir = (text, opt_isHtml) ->
  return 0  unless text
  (if goog.i18n.bidi.detectRtlDirectionality(text, opt_isHtml) then -1 else 1)


###
Returns "dir=ltr" or "dir=rtl", depending on text's estimated
directionality, if it is not the same as bidiGlobalDir.
Otherwise, returns the empty string.
If opt_isHtml, makes sure to ignore the LTR nature of the mark-up and escapes
in text, making the logic suitable for HTML and HTML-escaped text.
@param {number} bidiGlobalDir The global directionality context: 1 if ltr, -1
if rtl, 0 if unknown.
@param {string} text The text whose directionality is to be estimated.
@param {boolean=} opt_isHtml Whether text is HTML/HTML-escaped.
Default: false.
@return {soydata.SanitizedHtmlAttribute} "dir=rtl" for RTL text in non-RTL
context; "dir=ltr" for LTR text in non-LTR context;
else, the empty string.
###
soy.$$bidiDirAttr = (bidiGlobalDir, text, opt_isHtml) ->
  new soydata.SanitizedHtmlAttribute(soy.$$getBidiFormatterInstance_(bidiGlobalDir).dirAttr(text, opt_isHtml))


###
Returns a Unicode BiDi mark matching bidiGlobalDir (LRM or RLM) if the
directionality or the exit directionality of text are opposite to
bidiGlobalDir. Otherwise returns the empty string.
If opt_isHtml, makes sure to ignore the LTR nature of the mark-up and escapes
in text, making the logic suitable for HTML and HTML-escaped text.
@param {number} bidiGlobalDir The global directionality context: 1 if ltr, -1
if rtl, 0 if unknown.
@param {string} text The text whose directionality is to be estimated.
@param {boolean=} opt_isHtml Whether text is HTML/HTML-escaped.
Default: false.
@return {string} A Unicode bidi mark matching bidiGlobalDir, or the empty
string when text's overall and exit directionalities both match
bidiGlobalDir, or bidiGlobalDir is 0 (unknown).
###
soy.$$bidiMarkAfter = (bidiGlobalDir, text, opt_isHtml) ->
  formatter = soy.$$getBidiFormatterInstance_(bidiGlobalDir)
  formatter.markAfter text, opt_isHtml


###
Returns str wrapped in a <span dir=ltr|rtl> according to its directionality -
but only if that is neither neutral nor the same as the global context.
Otherwise, returns str unchanged.
Always treats str as HTML/HTML-escaped, i.e. ignores mark-up and escapes when
estimating str's directionality.
@param {number} bidiGlobalDir The global directionality context: 1 if ltr, -1
if rtl, 0 if unknown.
@param {*} str The string to be wrapped. Can be other types, but the value
will be coerced to a string.
@return {string} The wrapped string.
###
soy.$$bidiSpanWrap = (bidiGlobalDir, str) ->
  formatter = soy.$$getBidiFormatterInstance_(bidiGlobalDir)
  formatter.spanWrap str + "", true


###
Returns str wrapped in Unicode BiDi formatting characters according to its
directionality, i.e. either LRE or RLE at the beginning and PDF at the end -
but only if str's directionality is neither neutral nor the same as the
global context. Otherwise, returns str unchanged.
Always treats str as HTML/HTML-escaped, i.e. ignores mark-up and escapes when
estimating str's directionality.
@param {number} bidiGlobalDir The global directionality context: 1 if ltr, -1
if rtl, 0 if unknown.
@param {*} str The string to be wrapped. Can be other types, but the value
will be coerced to a string.
@return {string} The wrapped string.
###
soy.$$bidiUnicodeWrap = (bidiGlobalDir, str) ->
  formatter = soy.$$getBidiFormatterInstance_(bidiGlobalDir)
  formatter.unicodeWrap str + "", true


# -----------------------------------------------------------------------------
# Generated code.

# START GENERATED CODE FOR ESCAPERS.

###
@type {function (*) : string}
###
soy.esc.$$escapeUriHelper = (v) ->
  encodeURIComponent String(v)


###
Maps charcters to the escaped versions for the named escape directives.
@type {Object.<string, string>}
@private
###
soy.esc.$$ESCAPE_MAP_FOR_ESCAPE_HTML__AND__NORMALIZE_HTML__AND__ESCAPE_HTML_NOSPACE__AND__NORMALIZE_HTML_NOSPACE_ =
  "\u0000": "&#0;"
  "\"": "&quot;"
  "&": "&amp;"
  "'": "&#39;"
  "<": "&lt;"
  ">": "&gt;"
  "\t": "&#9;"
  "\n": "&#10;"
  "\u000b": "&#11;"
  "\f": "&#12;"
  "\r": "&#13;"
  " ": "&#32;"
  "-": "&#45;"
  "/": "&#47;"
  "=": "&#61;"
  "`": "&#96;"
  "": "&#133;"
  " ": "&#160;"
  " ": "&#8232;"
  " ": "&#8233;"


###
A function that can be used with String.replace..
@param {string} ch A single character matched by a compatible matcher.
@return {string} A token in the output language.
@private
###
soy.esc.$$REPLACER_FOR_ESCAPE_HTML__AND__NORMALIZE_HTML__AND__ESCAPE_HTML_NOSPACE__AND__NORMALIZE_HTML_NOSPACE_ = (ch) ->
  soy.esc.$$ESCAPE_MAP_FOR_ESCAPE_HTML__AND__NORMALIZE_HTML__AND__ESCAPE_HTML_NOSPACE__AND__NORMALIZE_HTML_NOSPACE_[ch]


###
Maps charcters to the escaped versions for the named escape directives.
@type {Object.<string, string>}
@private
###
soy.esc.$$ESCAPE_MAP_FOR_ESCAPE_JS_STRING__AND__ESCAPE_JS_REGEX_ =
  "\u0000": "\\x00"
  "\b": "\\x08"
  "\t": "\\t"
  "\n": "\\n"
  "\u000b": "\\x0b"
  "\f": "\\f"
  "\r": "\\r"
  "\"": "\\x22"
  "&": "\\x26"
  "'": "\\x27"
  "/": "\\/"
  "<": "\\x3c"
  "=": "\\x3d"
  ">": "\\x3e"
  "\\": "\\\\"
  "": "\\x85"
  " ": "\\u2028"
  " ": "\\u2029"
  $: "\\x24"
  "(": "\\x28"
  ")": "\\x29"
  "*": "\\x2a"
  "+": "\\x2b"
  ",": "\\x2c"
  "-": "\\x2d"
  ".": "\\x2e"
  ":": "\\x3a"
  "?": "\\x3f"
  "[": "\\x5b"
  "]": "\\x5d"
  "^": "\\x5e"
  "{": "\\x7b"
  "|": "\\x7c"
  "}": "\\x7d"


###
A function that can be used with String.replace..
@param {string} ch A single character matched by a compatible matcher.
@return {string} A token in the output language.
@private
###
soy.esc.$$REPLACER_FOR_ESCAPE_JS_STRING__AND__ESCAPE_JS_REGEX_ = (ch) ->
  soy.esc.$$ESCAPE_MAP_FOR_ESCAPE_JS_STRING__AND__ESCAPE_JS_REGEX_[ch]


###
Maps charcters to the escaped versions for the named escape directives.
@type {Object.<string, string>}
@private
###
soy.esc.$$ESCAPE_MAP_FOR_ESCAPE_CSS_STRING_ =
  "\u0000": "\\0 "
  "\b": "\\8 "
  "\t": "\\9 "
  "\n": "\\a "
  "\u000b": "\\b "
  "\f": "\\c "
  "\r": "\\d "
  "\"": "\\22 "
  "&": "\\26 "
  "'": "\\27 "
  "(": "\\28 "
  ")": "\\29 "
  "*": "\\2a "
  "/": "\\2f "
  ":": "\\3a "
  ";": "\\3b "
  "<": "\\3c "
  "=": "\\3d "
  ">": "\\3e "
  "@": "\\40 "
  "\\": "\\5c "
  "{": "\\7b "
  "}": "\\7d "
  "": "\\85 "
  " ": "\\a0 "
  " ": "\\2028 "
  " ": "\\2029 "


###
A function that can be used with String.replace..
@param {string} ch A single character matched by a compatible matcher.
@return {string} A token in the output language.
@private
###
soy.esc.$$REPLACER_FOR_ESCAPE_CSS_STRING_ = (ch) ->
  soy.esc.$$ESCAPE_MAP_FOR_ESCAPE_CSS_STRING_[ch]


###
Maps charcters to the escaped versions for the named escape directives.
@type {Object.<string, string>}
@private
###
soy.esc.$$ESCAPE_MAP_FOR_NORMALIZE_URI__AND__FILTER_NORMALIZE_URI_ =
  "\u0000": "%00"
  "\u0001": "%01"
  "\u0002": "%02"
  "\u0003": "%03"
  "\u0004": "%04"
  "\u0005": "%05"
  "\u0006": "%06"
  "\u0007": "%07"
  "\b": "%08"
  "\t": "%09"
  "\n": "%0A"
  "\u000b": "%0B"
  "\f": "%0C"
  "\r": "%0D"
  "\u000e": "%0E"
  "\u000f": "%0F"
  "\u0010": "%10"
  "\u0011": "%11"
  "\u0012": "%12"
  "\u0013": "%13"
  "\u0014": "%14"
  "\u0015": "%15"
  "\u0016": "%16"
  "\u0017": "%17"
  "\u0018": "%18"
  "\u0019": "%19"
  "\u001a": "%1A"
  "\u001b": "%1B"
  "\u001c": "%1C"
  "\u001d": "%1D"
  "\u001e": "%1E"
  "\u001f": "%1F"
  " ": "%20"
  "\"": "%22"
  "'": "%27"
  "(": "%28"
  ")": "%29"
  "<": "%3C"
  ">": "%3E"
  "\\": "%5C"
  "{": "%7B"
  "}": "%7D"
  "": "%7F"
  "": "%C2%85"
  " ": "%C2%A0"
  " ": "%E2%80%A8"
  " ": "%E2%80%A9"
  "！": "%EF%BC%81"
  "＃": "%EF%BC%83"
  "＄": "%EF%BC%84"
  "＆": "%EF%BC%86"
  "＇": "%EF%BC%87"
  "（": "%EF%BC%88"
  "）": "%EF%BC%89"
  "＊": "%EF%BC%8A"
  "＋": "%EF%BC%8B"
  "，": "%EF%BC%8C"
  "／": "%EF%BC%8F"
  "：": "%EF%BC%9A"
  "；": "%EF%BC%9B"
  "＝": "%EF%BC%9D"
  "？": "%EF%BC%9F"
  "＠": "%EF%BC%A0"
  "［": "%EF%BC%BB"
  "］": "%EF%BC%BD"


###
A function that can be used with String.replace..
@param {string} ch A single character matched by a compatible matcher.
@return {string} A token in the output language.
@private
###
soy.esc.$$REPLACER_FOR_NORMALIZE_URI__AND__FILTER_NORMALIZE_URI_ = (ch) ->
  soy.esc.$$ESCAPE_MAP_FOR_NORMALIZE_URI__AND__FILTER_NORMALIZE_URI_[ch]


###
Matches characters that need to be escaped for the named directives.
@type RegExp
@private
###
soy.esc.$$MATCHER_FOR_ESCAPE_HTML_ = /[\x00\x22\x26\x27\x3c\x3e]/g

###
Matches characters that need to be escaped for the named directives.
@type RegExp
@private
###
soy.esc.$$MATCHER_FOR_NORMALIZE_HTML_ = /[\x00\x22\x27\x3c\x3e]/g

###
Matches characters that need to be escaped for the named directives.
@type RegExp
@private
###
soy.esc.$$MATCHER_FOR_ESCAPE_HTML_NOSPACE_ = /[\x00\x09-\x0d \x22\x26\x27\x2d\/\x3c-\x3e`\x85\xa0\u2028\u2029]/g

###
Matches characters that need to be escaped for the named directives.
@type RegExp
@private
###
soy.esc.$$MATCHER_FOR_NORMALIZE_HTML_NOSPACE_ = /[\x00\x09-\x0d \x22\x27\x2d\/\x3c-\x3e`\x85\xa0\u2028\u2029]/g

###
Matches characters that need to be escaped for the named directives.
@type RegExp
@private
###
soy.esc.$$MATCHER_FOR_ESCAPE_JS_STRING_ = /[\x00\x08-\x0d\x22\x26\x27\/\x3c-\x3e\\\x85\u2028\u2029]/g

###
Matches characters that need to be escaped for the named directives.
@type RegExp
@private
###
soy.esc.$$MATCHER_FOR_ESCAPE_JS_REGEX_ = /[\x00\x08-\x0d\x22\x24\x26-\/\x3a\x3c-\x3f\x5b-\x5e\x7b-\x7d\x85\u2028\u2029]/g

###
Matches characters that need to be escaped for the named directives.
@type RegExp
@private
###
soy.esc.$$MATCHER_FOR_ESCAPE_CSS_STRING_ = /[\x00\x08-\x0d\x22\x26-\x2a\/\x3a-\x3e@\\\x7b\x7d\x85\xa0\u2028\u2029]/g

###
Matches characters that need to be escaped for the named directives.
@type RegExp
@private
###
soy.esc.$$MATCHER_FOR_NORMALIZE_URI__AND__FILTER_NORMALIZE_URI_ = /[\x00- \x22\x27-\x29\x3c\x3e\\\x7b\x7d\x7f\x85\xa0\u2028\u2029\uff01\uff03\uff04\uff06-\uff0c\uff0f\uff1a\uff1b\uff1d\uff1f\uff20\uff3b\uff3d]/g

###
A pattern that vets values produced by the named directives.
@type RegExp
@private
###
soy.esc.$$FILTER_FOR_FILTER_CSS_VALUE_ = /^(?!-*(?:expression|(?:moz-)?binding))(?:[.#]?-?(?:[_a-z0-9-]+)(?:-[_a-z0-9-]+)*-?|-?(?:[0-9]+(?:\.[0-9]*)?|\.[0-9]+)(?:[a-z]{1,2}|%)?|!important|)$/i

###
A pattern that vets values produced by the named directives.
@type RegExp
@private
###
soy.esc.$$FILTER_FOR_FILTER_NORMALIZE_URI_ = /^(?:(?:https?|mailto):|[^&:\/?#]*(?:[\/?#]|$))/i

###
A pattern that vets values produced by the named directives.
@type RegExp
@private
###
soy.esc.$$FILTER_FOR_FILTER_HTML_ATTRIBUTE_ = /^(?!style|on|action|archive|background|cite|classid|codebase|data|dsync|href|longdesc|src|usemap)(?:[a-z0-9_$:-]*)$/i

###
A pattern that vets values produced by the named directives.
@type RegExp
@private
###
soy.esc.$$FILTER_FOR_FILTER_HTML_ELEMENT_NAME_ = /^(?!script|style|title|textarea|xmp|no)[a-z0-9_$:-]*$/i

###
A helper for the Soy directive |escapeHtml
@param {*} value Can be of any type but will be coerced to a string.
@return {string} The escaped text.
###
soy.esc.$$escapeHtmlHelper = (value) ->
  str = String(value)
  str.replace soy.esc.$$MATCHER_FOR_ESCAPE_HTML_, soy.esc.$$REPLACER_FOR_ESCAPE_HTML__AND__NORMALIZE_HTML__AND__ESCAPE_HTML_NOSPACE__AND__NORMALIZE_HTML_NOSPACE_


###
A helper for the Soy directive |normalizeHtml
@param {*} value Can be of any type but will be coerced to a string.
@return {string} The escaped text.
###
soy.esc.$$normalizeHtmlHelper = (value) ->
  str = String(value)
  str.replace soy.esc.$$MATCHER_FOR_NORMALIZE_HTML_, soy.esc.$$REPLACER_FOR_ESCAPE_HTML__AND__NORMALIZE_HTML__AND__ESCAPE_HTML_NOSPACE__AND__NORMALIZE_HTML_NOSPACE_


###
A helper for the Soy directive |escapeHtmlNospace
@param {*} value Can be of any type but will be coerced to a string.
@return {string} The escaped text.
###
soy.esc.$$escapeHtmlNospaceHelper = (value) ->
  str = String(value)
  str.replace soy.esc.$$MATCHER_FOR_ESCAPE_HTML_NOSPACE_, soy.esc.$$REPLACER_FOR_ESCAPE_HTML__AND__NORMALIZE_HTML__AND__ESCAPE_HTML_NOSPACE__AND__NORMALIZE_HTML_NOSPACE_


###
A helper for the Soy directive |normalizeHtmlNospace
@param {*} value Can be of any type but will be coerced to a string.
@return {string} The escaped text.
###
soy.esc.$$normalizeHtmlNospaceHelper = (value) ->
  str = String(value)
  str.replace soy.esc.$$MATCHER_FOR_NORMALIZE_HTML_NOSPACE_, soy.esc.$$REPLACER_FOR_ESCAPE_HTML__AND__NORMALIZE_HTML__AND__ESCAPE_HTML_NOSPACE__AND__NORMALIZE_HTML_NOSPACE_


###
A helper for the Soy directive |escapeJsString
@param {*} value Can be of any type but will be coerced to a string.
@return {string} The escaped text.
###
soy.esc.$$escapeJsStringHelper = (value) ->
  str = String(value)
  str.replace soy.esc.$$MATCHER_FOR_ESCAPE_JS_STRING_, soy.esc.$$REPLACER_FOR_ESCAPE_JS_STRING__AND__ESCAPE_JS_REGEX_


###
A helper for the Soy directive |escapeJsRegex
@param {*} value Can be of any type but will be coerced to a string.
@return {string} The escaped text.
###
soy.esc.$$escapeJsRegexHelper = (value) ->
  str = String(value)
  str.replace soy.esc.$$MATCHER_FOR_ESCAPE_JS_REGEX_, soy.esc.$$REPLACER_FOR_ESCAPE_JS_STRING__AND__ESCAPE_JS_REGEX_


###
A helper for the Soy directive |escapeCssString
@param {*} value Can be of any type but will be coerced to a string.
@return {string} The escaped text.
###
soy.esc.$$escapeCssStringHelper = (value) ->
  str = String(value)
  str.replace soy.esc.$$MATCHER_FOR_ESCAPE_CSS_STRING_, soy.esc.$$REPLACER_FOR_ESCAPE_CSS_STRING_


###
A helper for the Soy directive |filterCssValue
@param {*} value Can be of any type but will be coerced to a string.
@return {string} The escaped text.
###
soy.esc.$$filterCssValueHelper = (value) ->
  str = String(value)
  return "zSoyz"  unless soy.esc.$$FILTER_FOR_FILTER_CSS_VALUE_.test(str)
  str


###
A helper for the Soy directive |normalizeUri
@param {*} value Can be of any type but will be coerced to a string.
@return {string} The escaped text.
###
soy.esc.$$normalizeUriHelper = (value) ->
  str = String(value)
  str.replace soy.esc.$$MATCHER_FOR_NORMALIZE_URI__AND__FILTER_NORMALIZE_URI_, soy.esc.$$REPLACER_FOR_NORMALIZE_URI__AND__FILTER_NORMALIZE_URI_


###
A helper for the Soy directive |filterNormalizeUri
@param {*} value Can be of any type but will be coerced to a string.
@return {string} The escaped text.
###
soy.esc.$$filterNormalizeUriHelper = (value) ->
  str = String(value)
  return "zSoyz"  unless soy.esc.$$FILTER_FOR_FILTER_NORMALIZE_URI_.test(str)
  str.replace soy.esc.$$MATCHER_FOR_NORMALIZE_URI__AND__FILTER_NORMALIZE_URI_, soy.esc.$$REPLACER_FOR_NORMALIZE_URI__AND__FILTER_NORMALIZE_URI_


###
A helper for the Soy directive |filterHtmlAttribute
@param {*} value Can be of any type but will be coerced to a string.
@return {string} The escaped text.
###
soy.esc.$$filterHtmlAttributeHelper = (value) ->
  str = String(value)
  return "zSoyz"  unless soy.esc.$$FILTER_FOR_FILTER_HTML_ATTRIBUTE_.test(str)
  str


###
A helper for the Soy directive |filterHtmlElementName
@param {*} value Can be of any type but will be coerced to a string.
@return {string} The escaped text.
###
soy.esc.$$filterHtmlElementNameHelper = (value) ->
  str = String(value)
  return "zSoyz"  unless soy.esc.$$FILTER_FOR_FILTER_HTML_ELEMENT_NAME_.test(str)
  str


###
Matches all tags, HTML comments, and DOCTYPEs in tag soup HTML.

@type {RegExp}
@private
###
soy.esc.$$HTML_TAG_REGEX_ = /<(?:!|\/?[a-zA-Z])(?:[^>'"]|"[^"]*"|'[^']*')*>/g

# END GENERATED CODE
