#!/usr/bin/env ruby
ENV["ARCHFLAGS"] = "-arch #{`uname -p` =~ /powerpc/ ? 'ppc' : 'i386'}"

require 'mkmf'

json = File.dirname(__FILE__) + "/json-c-0.8"
system "cd #{json} && ./configure && make" 

ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..'))
LIBDIR = Config::CONFIG['libdir']
INCLUDEDIR = Config::CONFIG['includedir']

$CFLAGS << " -std=c99 #{ENV["CFLAGS"]}"
if Config::CONFIG['target_os'] == 'mingw32'
  $CFLAGS << " -DXP_WIN -DXP_WIN32"
else
  $CFLAGS << " -g -DXP_UNIX"
end

$CFLAGS << " -O3 -Wall -Wextra -Wcast-qual -Wwrite-strings -Wconversion -Wmissing-noreturn -Winline"

create_makefile('ordered_json_c')