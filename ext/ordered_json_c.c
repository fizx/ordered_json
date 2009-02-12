#include "ruby.h"
#include <json/json.h>

VALUE oj_dump(VALUE, VALUE);
struct json_object* ob_dump_json(VALUE obj);
struct json_object* ob_dump_json_hash(VALUE obj);
struct json_object* ob_dump_json_array(VALUE obj);

VALUE oj_parse(VALUE, VALUE, VALUE);
VALUE oj_build(struct json_object *, VALUE);
VALUE oj_build_object(struct json_object *, VALUE);
VALUE oj_build_array(struct json_object *, VALUE);

void Init_ordered_json_c()
{
	VALUE c_oj = rb_define_class("OrderedJSONC", rb_cObject);
	rb_define_singleton_method(c_oj, "parse", oj_parse, 2);
	rb_define_singleton_method(c_oj, "dump", oj_dump, 1);
}

VALUE oj_parse(VALUE self, VALUE str, VALUE hash_class){
  char *c_str = STR2CSTR(str);
  struct json_object* json = json_tokener_parse(c_str);
  VALUE out = oj_build(json, hash_class);
  json_object_put(json);
  return out;
}

VALUE oj_dump(VALUE self, VALUE obj){
  struct json_object* json = ob_dump_json(obj);
  char *cstr = json_object_to_json_string(json);
  VALUE out = rb_str_new2(cstr);
  json_object_put(json);
  return out;
}

struct json_object* ob_dump_json(VALUE obj) {
  switch(TYPE(obj)) {
    case T_OBJECT:
    case T_HASH:
      return ob_dump_json_hash(obj);
    case T_FLOAT:  
      return json_object_new_double(NUM2DBL(obj));
    case T_STRING: 
      return json_object_new_string(STR2CSTR(obj));
    case T_ARRAY: 
      return ob_dump_json_array(obj);
    case T_FIXNUM:
    case T_BIGNUM:          
      return json_object_new_int(NUM2INT(obj));
    case T_TRUE:
      return json_object_new_boolean(1);
    case T_FALSE:
      return json_object_new_boolean(0);
    case T_NIL:
    default:
      return NULL;
  }
}

struct json_object* ob_dump_json_hash(VALUE hash) {
  struct json_object *json = json_object_new_object();
  VALUE keys = rb_funcall(hash, rb_intern("keys"), 0);
  VALUE values = rb_funcall(hash, rb_intern("values"), 0); 
  int len = RARRAY(keys)->len;
  for(int i = 0; i < len; i++) {
    json_object_object_add(json,
		STR2CSTR(rb_funcall(rb_ary_entry(keys, i), rb_intern("to_s"), 0)),
        ob_dump_json(rb_ary_entry(values, i))
      );
  }
  return json;
}

struct json_object* ob_dump_json_array(VALUE array) {
  int len = RARRAY(array)->len;
  struct json_object *json = json_object_new_array();;
  for(int i = 0; i < len; i++) {
    json_object_array_add(json, ob_dump_json(rb_ary_entry(array, i)));
  }
  return json;
}

VALUE oj_build(struct json_object* json, VALUE hash_class){
  switch(json_object_get_type(json)){
    case json_type_null:
      return Qnil;
    case json_type_boolean:
      return json_object_get_boolean(json) ? Qtrue : Qfalse;
    case json_type_double:	
      return rb_float_new(json_object_get_double(json));
    case json_type_int:
      return INT2FIX(json_object_get_int(json));
    case json_type_object:
      return oj_build_object(json, hash_class);
    case json_type_array:
      return oj_build_array(json, hash_class);
    case json_type_string:
      return rb_str_new2(json_object_get_string(json));
  }
  return Qnil;
}

VALUE oj_build_object(struct json_object * json, VALUE hash_class) {
  VALUE hash = rb_funcall(hash_class, rb_intern("new"), 0);
  json_object_object_foreach(json, key, value) {
    rb_funcall(hash, rb_intern("[]="), 2, rb_str_new2(key), oj_build(value, hash_class));
  }
  return hash;
}

VALUE oj_build_array(struct json_object * json, VALUE hash_class) {
  VALUE array = rb_ary_new();
  for(int i = 0; i < json_object_array_length(json); i++) {
    rb_ary_push(array, ob_build(json_object_array_get_idx(json, i), hash_class));
  }
  return array;
}