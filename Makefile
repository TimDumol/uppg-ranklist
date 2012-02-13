VERSION=1.4.0
DATE=$(shell date)
BOOTSTRAP = ./build/css/bootstrap.css
BOOTSTRAP_MIN = ./build/css/bootstrap.min.css
BOOTSTRAP_LESS = ./less/bootstrap.less
LESS_COMPRESSOR ?= `which lessc`
UGLIFY_JS ?= `which uglifyjs`
WATCHR ?= `which watchr`
JS=bootstrap-alert.js bootstrap-button.js bootstrap-dropdown.js\
	 bootstrap-modal.js bootstrap-popover.js bootstrap-scrollspy.js\
	 bootstrap-tab.js libs/jquery-1.7.1.js site/main.js\
	 libs/es5-shim.js libs/humane.js site/templates.js libs/underscore.js\
	 libs/soyutils.js site/users.json
JS_FULL=${JS:%=build/js/%}
all: build $(JS_FULL) 

build:
	@@if test ! -z ${LESS_COMPRESSOR}; then \
		sed -e 's/@VERSION/'"v${VERSION}"'/' -e 's/@DATE/'"${DATE}"'/' <${BOOTSTRAP_LESS} >${BOOTSTRAP_LESS}.tmp; \
		lessc ${BOOTSTRAP_LESS}.tmp > ${BOOTSTRAP}; \
		lessc ${BOOTSTRAP_LESS}.tmp > ${BOOTSTRAP_MIN} --compress; \
		rm -f ${BOOTSTRAP_LESS}.tmp; \
		echo "Bootstrap successfully built! - `date`"; \
	else \
		echo "You must have the LESS compiler installed in order to build Bootstrap."; \
		echo "You can install it by running: npm install less -g"; \
	fi

#js/templates.js: templates/templates.soy
#	java -jar templates/SoyToJsSrcCompiler.jar --outputPathFormat js/templates.js \
#		templates/templates.soy

build/js/%.js: js/%.js
	mkdir -p "`dirname $@`" && [ "${DEBUG}" ] && cp $< $@ || uglifyjs -o $@ $<

build/js/%.json: js/%.json
	mkdir -p "`dirname $@`" && cp $< $@

js/site/templates.js: templates/templates.soy
	java -jar templates/SoyToJsSrcCompiler.jar --outputPathFormat js/site/templates.js \
		templates/templates.soy

watch:
	@@if test ! -z ${WATCHR}; then \
	  echo "Watching less and js files..."; \
	  watchr -e "watch('less/.*\.less|js/.*\.js|templates/*.soy') { system 'make' }"; \
	else \
		echo "You must have the watchr installed in order to watch Bootstrap less files."; \
		echo "You can install it by running: gem install watchr"; \
	fi

.PHONY: build watch
