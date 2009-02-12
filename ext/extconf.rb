#!/usr/bin/env ruby
ENV["ARCHFLAGS"] = "-arch #{`uname -p` =~ /powerpc/ ? 'ppc' : 'i386'}"

require 'mkmf'

ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..'))
LIBDIR = Config::CONFIG['libdir']
INCLUDEDIR = Config::CONFIG['includedir']

$CFLAGS << " #{ENV["CFLAGS"]}"
if Config::CONFIG['target_os'] == 'mingw32'
  $CFLAGS << " -DXP_WIN -DXP_WIN32"
else
  $CFLAGS << " -g -DXP_UNIX"
end

$CFLAGS << " -O3 -Wall -Wextra -Wcast-qual -Wwrite-strings -Wconversion -Wmissing-noreturn -Winline"

myincl = %w[/usr/local/include /opt/local/include /usr/include]
mylib = %w[/usr/local/lib /opt/local/lib /usr/lib]

find_header('json/json.h', INCLUDEDIR, *myincl) or abort "need json/json.h"
find_library('json', 'json_object_new_string', LIBDIR, *mylib) or abort "need libjson"

create_makefile('ordered_json_c')