#include "ruby.h"
#include "json-c-0.8/json.h"
#include "json-c-0.8/printbuf.h"
#include <stdio.h>
#include <stdbool.h>

VALUE oj_dump(VALUE, VALUE, VALUE);
struct json_object* oj_dump_json(VALUE obj);
struct json_object* oj_dump_json_hash(VALUE obj);
struct json_object* oj_dump_json_array(VALUE obj);

char* oj_pretty_dump(struct json_object* json, struct printbuf *buf, int depth);

VALUE oj_parse(VALUE, VALUE, VALUE);
VALUE oj_build(struct json_object *, VALUE);
VALUE oj_build_object(struct json_object *, VALUE);
VALUE oj_build_array(struct json_object *, VALUE);

VALUE rb_dump_error;
VALUE rb_parse_error;

void Init_ordered_json_c()
{
	rb_dump_error = rb_eval_string("OrderedJSON::DumpError");
	rb_parse_error = rb_eval_string("OrderedJSON::ParseError");
	VALUE c_oj = rb_define_class("OrderedJSONC", rb_cObject);
	rb_define_singleton_method(c_oj, "parse", oj_parse, 2);
	rb_define_singleton_method(c_oj, "dump", oj_dump, 2);
}

VALUE oj_parse(VALUE self, VALUE str, VALUE hash_class){
	VALUE out;
  char *c_str = STR2CSTR(str);
  struct json_object* json = json_tokener_parse(c_str);
	if(is_error(json)) {
		rb_raise(rb_parse_error, "Invalid JSON");
	} else {
  out = oj_build(json, hash_class);
	}
  json_object_put(json);
  return out;
}

VALUE oj_dump(VALUE self, VALUE obj, VALUE pretty) {
  struct json_object* json = oj_dump_json(obj);
	struct printbuf *buf = printbuf_new(); 
	char *cstr = (pretty != Qfalse && pretty != Qnil) ? 
		oj_pretty_dump(json, buf, 0) : 
		json_object_to_json_string(json);
  VALUE out = rb_str_new2(cstr);
  json_object_put(json);
	printbuf_free(buf);
  return out;
}

char* tabs(int num) {
	char *tabs = malloc(num + 2);
	*tabs = '\n';
	for(int i = 0; i < num; i++){
		*(tabs + i + 1) = '\t';
	}
	*(tabs + num + 1) = 0;
	return tabs;
}

char* oj_pretty_dump(struct json_object* json, struct printbuf *buf, int depth) {
	if(json != NULL) {
	  switch(json_object_get_type(json)){	
	  case json_type_object:
			oj_pretty_dump_object(json, buf, depth);
			break;
	  case json_type_array:
			oj_pretty_dump_array(json, buf, depth);
			break;
	  default:
			sprintbuf(buf, "%s", json_object_to_json_string(json));
		}
	} else {
		sprintbuf(buf, "null");
	}
	return buf->buf;
}

void oj_pretty_dump_object(struct json_object* json, struct printbuf *buf, int depth) {
	struct json_object *jtmp;
	char *space  = tabs(depth);
	char *space1 = tabs(depth + 1);
	char *comma  = "";
	sprintbuf(buf, "{");
	json_object_object_foreach(json, key, val) {
		jtmp = json_object_new_string(key);
		sprintbuf(buf, "%s%s%s: ", comma, space1, json_object_to_json_string(jtmp));
		json_object_put(jtmp);
		oj_pretty_dump(val, buf, depth + 1);
		comma = ",";
	}
	sprintbuf(buf, "%s}", space);
	free(space);
	free(space1);
}

void oj_pretty_dump_array(struct json_object* json, struct printbuf *buf, int depth) {
	int len = json_object_array_length(json);
	char *space =  (len < 2) ? strdup("") : tabs(depth);
	char *space1 = (len < 2) ? strdup("") : tabs(depth + 1);
	sprintbuf(buf, "[ ");
	for(int i = 0; i < len; i++) {
		char *comma = i == 0 ? "" : ", ";
		sprintbuf(buf, "%s%s", comma, space1);
		oj_pretty_dump(json_object_array_get_idx(json, i), buf, depth + 1);
	}
	sprintbuf(buf, " %s]", space);
	free(space);
}

struct json_object* oj_dump_json(VALUE obj) {
  switch(TYPE(obj)) {
    case T_OBJECT:
    case T_HASH:
      return oj_dump_json_hash(obj);
    case T_FLOAT:  
      return json_object_new_double(NUM2DBL(obj));
    case T_STRING: 
      return json_object_new_string(STR2CSTR(obj));
    case T_ARRAY: 
      return oj_dump_json_array(obj);
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

struct json_object* oj_dump_json_hash(VALUE hash) {
  struct json_object *json = json_object_new_object();
  VALUE keys = rb_funcall(hash, rb_intern("keys"), 0);
  VALUE values = rb_funcall(hash, rb_intern("values"), 0); 
  int len = RARRAY(keys)->len;
  for(int i = 0; i < len; i++) {
    json_object_object_add(json,
		STR2CSTR(rb_funcall(rb_ary_entry(keys, i), rb_intern("to_s"), 0)),
        oj_dump_json(rb_ary_entry(values, i))
      );
  }
  return json;
}

struct json_object* oj_dump_json_array(VALUE array) {
  int len = RARRAY(array)->len;
  struct json_object *json = json_object_new_array();;
  for(int i = 0; i < len; i++) {
    json_object_array_add(json, oj_dump_json(rb_ary_entry(array, i)));
  }
  return json;
}

VALUE oj_build(struct json_object* json, VALUE hash_class){
  if(json != NULL) {
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
    rb_ary_push(array, oj_build(json_object_array_get_idx(json, i), hash_class));
  }
  return array;
}