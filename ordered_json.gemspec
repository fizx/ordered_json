Gem::Specification.new do |s|
  s.name     = "ordered_json"
  s.version  = "0.3.4"
  s.date     = "2009-03-19"
  s.summary  = "Ordered json hash conversion "
  s.email    = "kyle@kylemaxwell.com"
  s.has_rdoc = true
  s.extensions = "ext/extconf.rb"
  s.authors  = ["Kyle Maxwell"]
  s.files    = %w[
    .gitignore
    CHANGELOG
    ext/extconf.rb
    ext/json-c-0.8/aclocal.m4
    ext/json-c-0.8/arraylist.c
    ext/json-c-0.8/arraylist.h
    ext/json-c-0.8/AUTHORS
    ext/json-c-0.8/bits.h
    ext/json-c-0.8/ChangeLog
    ext/json-c-0.8/config.guess
    ext/json-c-0.8/config.h.in
    ext/json-c-0.8/config.sub
    ext/json-c-0.8/configure
    ext/json-c-0.8/configure.in
    ext/json-c-0.8/COPYING
    ext/json-c-0.8/debug.c
    ext/json-c-0.8/debug.h
    ext/json-c-0.8/depcomp
    ext/json-c-0.8/doc/html/annotated.html
    ext/json-c-0.8/doc/html/arraylist_8h.html
    ext/json-c-0.8/doc/html/bits_8h.html
    ext/json-c-0.8/doc/html/config_8h.html
    ext/json-c-0.8/doc/html/debug_8h.html
    ext/json-c-0.8/doc/html/doxygen.css
    ext/json-c-0.8/doc/html/doxygen.png
    ext/json-c-0.8/doc/html/files.html
    ext/json-c-0.8/doc/html/functions.html
    ext/json-c-0.8/doc/html/functions_vars.html
    ext/json-c-0.8/doc/html/globals.html
    ext/json-c-0.8/doc/html/globals_defs.html
    ext/json-c-0.8/doc/html/globals_enum.html
    ext/json-c-0.8/doc/html/globals_eval.html
    ext/json-c-0.8/doc/html/globals_func.html
    ext/json-c-0.8/doc/html/globals_type.html
    ext/json-c-0.8/doc/html/globals_vars.html
    ext/json-c-0.8/doc/html/index.html
    ext/json-c-0.8/doc/html/json_8h.html
    ext/json-c-0.8/doc/html/json__object_8h.html
    ext/json-c-0.8/doc/html/json__object__private_8h.html
    ext/json-c-0.8/doc/html/json__tokener_8h.html
    ext/json-c-0.8/doc/html/json__util_8h.html
    ext/json-c-0.8/doc/html/linkhash_8h.html
    ext/json-c-0.8/doc/html/printbuf_8h.html
    ext/json-c-0.8/doc/html/structarray__list.html
    ext/json-c-0.8/doc/html/structjson__object.html
    ext/json-c-0.8/doc/html/structjson__object__iter.html
    ext/json-c-0.8/doc/html/structjson__tokener.html
    ext/json-c-0.8/doc/html/structjson__tokener__srec.html
    ext/json-c-0.8/doc/html/structlh__entry.html
    ext/json-c-0.8/doc/html/structlh__table.html
    ext/json-c-0.8/doc/html/structprintbuf.html
    ext/json-c-0.8/doc/html/tab_b.gif
    ext/json-c-0.8/doc/html/tab_l.gif
    ext/json-c-0.8/doc/html/tab_r.gif
    ext/json-c-0.8/doc/html/tabs.css
    ext/json-c-0.8/doc/html/unionjson__object_1_1data.html
    ext/json-c-0.8/INSTALL
    ext/json-c-0.8/install-sh
    ext/json-c-0.8/json.h
    ext/json-c-0.8/json.pc.in
    ext/json-c-0.8/json_object.c
    ext/json-c-0.8/json_object.h
    ext/json-c-0.8/json_object_private.h
    ext/json-c-0.8/json_tokener.c
    ext/json-c-0.8/json_tokener.h
    ext/json-c-0.8/json_util.c
    ext/json-c-0.8/json_util.h
    ext/json-c-0.8/linkhash.c
    ext/json-c-0.8/linkhash.h
    ext/json-c-0.8/ltmain.sh
    ext/json-c-0.8/Makefile.am
    ext/json-c-0.8/Makefile.in
    ext/json-c-0.8/missing
    ext/json-c-0.8/NEWS
    ext/json-c-0.8/printbuf.c
    ext/json-c-0.8/printbuf.h
    ext/json-c-0.8/README
    ext/json-c-0.8/test1.c
    ext/json-c-0.8/test2.c
    ext/json-c-0.8/test3.c
    ext/ordered_json_c.c
    lib/ordered_json.rb
    ordered_json.gemspec
    Rakefile
    README
    test/crashing_example.rb
    test/ordered_json_test.rb
    test/pretty.json
  ]
  s.add_dependency("collections", ["> 0.0.0"])
end
