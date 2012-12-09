VERSION=1.4.0
DATE=$(shell date)
BOOTSTRAP = ./ranklist/static/css/bootstrap.css
BOOTSTRAP_MIN = ./ranklist/static/css/bootstrap.min.css
BOOTSTRAP_LESS = ./less/bootstrap.less
LESS_COMPRESSOR ?= `which lessc`
UGLIFY_JS ?= `which uglifyjs`
WATCHR ?= `which watchr`
JS=libs/jquery.js\
	 libs/es5-shim.js libs/humane.js site/templates.js libs/underscore.js\
	 libs/soyutils.js bootstrap-alert.js bootstrap-button.js bootstrap-dropdown.js\
	 bootstrap-modal.js bootstrap-popover.js bootstrap-scrollspy.js\
	 bootstrap-tab.js
COFFEE=js/libs/spine/src/spine.coffee js/libs/spine/src/ajax.coffee js/libs/spine/src/list.coffee\
	   js/libs/spine/src/local.coffee js/libs/spine/src/manager.coffee\
	   js/libs/spine/src/relation.coffee js/libs/spine/src/route.coffee\
	    js/site/main.coffee
JS_FULL=${JS:%=ranklist/static/js/%}
all: ranklist/static ${JS_FULL} ranklist/static/js/site/coffee.js

ranklist/static:
	@@if test ! -z ${LESS_COMPRESSOR}; then \
		sed -e 's/@VERSION/'"v${VERSION}"'/' -e 's/@DATE/'"${DATE}"'/' <${BOOTSTRAP_LESS} >${BOOTSTRAP_LESS}.tmp; \
		lessc ${BOOTSTRAP_LESS}.tmp > ${BOOTSTRAP}; \
		lessc ${BOOTSTRAP_LESS}.tmp > ${BOOTSTRAP_MIN} --compress; \
		rm -f ${BOOTSTRAP_LESS}.tmp; \
		echo "Bootstrap successfully built! - `date`"; \
	else \
		echo "You must have the LESS compiler installed in order to static Bootstrap."; \
		echo "You can install it by running: npm install less -g"; \
	fi

#js/templates.js: templates/templates.soy
#	java -jar templates/SoyToJsSrcCompiler.jar --outputPathFormat js/templates.js \
#		templates/templates.soy

js/site/coffee.js: ${COFFEE}
	coffee -c -j js/site/coffee.js ${COFFEE}

ranklist/static/js/site/coffee.js: js/site/coffee.js
	mkdir -p "`dirname $@`" && [ "${DEBUG}" ] && cp $< $@ || uglifyjs $< > $@

ranklist/static/js/%.js: js/%.js
	mkdir -p "`dirname $@`" && [ "${DEBUG}" ] && cp $< $@ || uglifyjs $< > $@

ranklist/static/js/%.json: js/%.json
	mkdir -p "`dirname $@`" && cp $< $@

js/site/templates.js: templates/templates.soy
	java -jar templates/SoyToJsSrcCompiler.jar --outputPathFormat js/site/templates.js \
		templates/templates.soy

watch:
	@@if test ! -z ${WATCHR}; then \
	  echo "Watching less and js files..."; \
	  watchr -e "watch('less/.*\.less|js/.*\.js|js.*\.coffee|templates/*.soy') { system 'make' }"; \
	else \
		echo "You must have the watchr installed in order to watch Bootstrap less files."; \
		echo "You can install it by running: gem install watchr"; \
	fi

.PHONY: ranklist/static watch
