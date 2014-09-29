# OS Specific
# set default shell to cmd.exe, fixing git-shell issues with gnu-make.
ifeq ($(OS), Windows_NT)
	SHELL = C:\Windows\SysWOW64\cmd.exe
endif

LS     = node_modules/LiveScript
LSC    = node_modules/".bin"/lsc
MOCHA  = node_modules/".bin"/mocha
BRSIFY = node_modules/".bin"/browserify
UGLIFY = node_modules/'.bin'/uglifyjs
MKDIRP = node_modules/".bin"/mkdirp

SRC  = $(shell find src -maxdepth 1 -name "*.ls" -type f | sort)
DIST = $(SRC:src/%.ls=dist/%.js)
BREL = browser/prelude.js browser/prelude.min.js

build: dist $(DIST) browser

install:
	@npm install .

dist:
	$(MKDIRP) dist

browser:
	$(MKDIRP) browser
	$(BRSIFY) -r "./dist/prelude.js:prelude" > "browser/prelude.js"
	$(UGLIFY) "browser/prelude.js" --mangle --comments "none" > "browser/prelude.min.js"

test: build
	@$(MOCHA) tests -u tdd -R spec -t 5000 --compilers ls:$(LS) -r "./test-runner.js" -c -S -b --recursive --check-leaks --inline-diffs

clean:
	@rm -rf dist
	@rm -rf browser
	@sleep .2

dist/%.js: src/%.ls
	$(LSC) --bare -o "$(shell dirname $@)" -c "$<"

.PHONY: install build dist browser browser-minify test clean
