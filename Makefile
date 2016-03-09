# OS Specific
# set default shell to cmd.exe, fixing git-shell issues with gnu-make.
ifeq ($(OS), Windows_NT)
	SHELL = C:\Windows\SysWOW64\cmd.exe
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Linux)
	    OPEN_BROWSER := chromium-browser
	endif
	ifeq ($(UNAME_S),Darwin)
	    OPEN_BROWSER += open
	endif
endif


LS     = node_modules/livescript
LSC    = node_modules/".bin"/lsc
MOCHA  = node_modules/".bin"/mocha
_MOCHA = node_modules/".bin"/_mocha
BRSIFY = node_modules/".bin"/browserify
UGLIFY = node_modules/".bin"/uglifyjs
MKDIRP = node_modules/".bin"/mkdirp
ISTNBL = node_modules/".bin"/istanbul
MOCHAF = -u tdd -R min -t 5000 --compilers ls:$(LS) -r "./test-runner.ls" -c -S -b --recursive --inline-diffs

LS_SRC  = $(shell find src -maxdepth 1 -name "*.ls" -type f | sort)
LS_DIST = $(LS_SRC:src/%.ls=lib/%.js)
BR_DIST = browser/prelude.js browser/prelude.min.js

build: prepare $(LS_DIST) $(BR_DIST)

prepare:
	@$(MKDIRP) lib browser

test: build
	@$(ISTNBL) cover $(_MOCHA) -- $(MOCHAF)

clean:
	@rm -rf lib
	@rm -rf browser
	@sleep .1 # wait for editor to refresh the file tree.......

init:
	@rm -rf none_modules/
	@npm install

report: test
	@$(OPEN_BROWSER) coverage/lcov-report/index.html > /dev/null 2>&1

.PHONY: build prepare test clean init report

lib/%.js: src/%.ls
	$(LSC) --map linked --bare -o "$(shell dirname $@)" -c "$<"

browser/%.js: lib/%.js
	$(BRSIFY) -r "./$<:prelude" > "$@"

browser/%.min.js: browser/%.js
	$(UGLIFY) "./$<" --mangle --comments "none" > "$@"
