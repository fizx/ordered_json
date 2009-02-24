Gem::Specification.new do |s|
  s.name     = "ordered_json"
  s.version  = "0.3.0"
  s.date     = "2009-02-24"
  s.summary  = "Ordered json hash conversion "
  s.email    = "kyle@kylemaxwell.com"
  s.has_rdoc = true
  s.extensions = "ext/extconf.rb"
  s.authors  = ["Kyle Maxwell"]
  s.files    = %w[
    ./.gitignore
    ./CHANGELOG
    ./ext/extconf.rb
    ./ext/json-c-0.8/aclocal.m4
    ./ext/json-c-0.8/arraylist.c
    ./ext/json-c-0.8/arraylist.h
    ./ext/json-c-0.8/AUTHORS
    ./ext/json-c-0.8/bits.h
    ./ext/json-c-0.8/ChangeLog
    ./ext/json-c-0.8/config.guess
    ./ext/json-c-0.8/config.h.in
    ./ext/json-c-0.8/config.sub
    ./ext/json-c-0.8/configure
    ./ext/json-c-0.8/configure.in
    ./ext/json-c-0.8/COPYING
    ./ext/json-c-0.8/debug.c
    ./ext/json-c-0.8/debug.h
    ./ext/json-c-0.8/depcomp
    ./ext/json-c-0.8/install-sh
    ./ext/json-c-0.8/json.h
    ./ext/json-c-0.8/json.pc.in
    ./ext/json-c-0.8/json_object.c
    ./ext/json-c-0.8/json_object.h
    ./ext/json-c-0.8/json_object_private.h
    ./ext/json-c-0.8/json_tokener.c
    ./ext/json-c-0.8/json_tokener.h
    ./ext/json-c-0.8/json_util.c
    ./ext/json-c-0.8/json_util.h
    ./ext/json-c-0.8/linkhash.c
    ./ext/json-c-0.8/linkhash.h
    ./ext/json-c-0.8/ltmain.sh
    ./ext/json-c-0.8/Makefile.am
    ./ext/json-c-0.8/Makefile.in
    ./ext/json-c-0.8/missing
    ./ext/json-c-0.8/NEWS
    ./ext/json-c-0.8/printbuf.c
    ./ext/json-c-0.8/printbuf.h
    ./ext/json-c-0.8/README
    ./ext/json-c-0.8/test1.c
    ./ext/json-c-0.8/test2.c
    ./ext/json-c-0.8/test3.c
    ./ext/mkmf.log
    ./ext/ordered_json_c.c
    ./lib/ordered_json.rb
    ./ordered_json.gemspec
    ./Rakefile
    ./README
    ./test/ordered_json_test.rb
    ./test/pretty.json
  ]
  s.add_dependency("collections", ["> 0.0.0"])
end
