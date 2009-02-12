#include "ruby.h"
#include <json/json.h>

VALUE _parse(VALUE, VALUE);

void Init_ordered_json_c()
{
	VALUE c_oj = rb_define_class("OrderedJSONC", rb_cObject);
	rb_define_singleton_method(c_oj, "parse", _parse, 1);
}

VALUE _parse(VALUE self, VALUE str){
  char *c_str = STR2CSTR(str);
  struct json_object* json = json_tokener_parse(c_str);
  
  return Qnil;
}