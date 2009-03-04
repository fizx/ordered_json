#!/usr/bin/env ruby
ENV["ARCHFLAGS"] = "-arch #{`uname -p` =~ /powerpc/ ? 'ppc' : 'i386'}"

require 'mkmf'

json = File.dirname(__FILE__) + "/json-c-0.8"
system "cd #{json} && ./configure && make" 

LIBDIR = Config::CONFIG['libdir']
INCLUDEDIR = Config::CONFIG['includedir']

$CFLAGS << " -std=c99 #{ENV["CFLAGS"]}"
if Config::CONFIG['target_os'] == 'mingw32'
  $CFLAGS << " -DXP_WIN -DXP_WIN32"
else
  $CFLAGS << " -g -DXP_UNIX"
end

unless find_header("json-c-0.8/json.h", File.dirname(__FILE__))
  abort "wtf json"
end

unless find_header("json-c-0.8/printbuf.h", File.dirname(__FILE__))
  abort "wtf printbuf"
end

 
unless find_library('json', 'json_tokener_parse', File.dirname(__FILE__) + "/json-c-0.8")
  abort "wtf libjson"
end

$CFLAGS << " -O3 -Wall -Wextra -Wcast-qual -Wwrite-strings -Wconversion -Wmissing-noreturn -Winline"

create_makefile('ordered_json_c')