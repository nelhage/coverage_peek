#include "coverage_peek.h"
#include "ruby/version.h"

VALUE rb_mCoverage;
ID id_Coverage;

extern VALUE
rb_get_coverages(void);

static int
coverage_peek_result_i(st_data_t key, st_data_t val, st_data_t h)
{
    VALUE path = (VALUE)key;
    VALUE coverage = (VALUE)val;
    VALUE coverages = (VALUE)h;
    coverage = rb_ary_dup(coverage);
    rb_ary_freeze(coverage);
    rb_hash_aset(coverages, path, coverage);
    return ST_CONTINUE;
}

/*
 *  call-seq:
 *     Coverage.peek_result  => hash
 *
 * Returns a hash that contains filename as key and coverage array as value.
 */
static VALUE
rb_coverage_peek_result(VALUE klass)
{
    VALUE coverages = rb_get_coverages();
    VALUE ncoverages = rb_hash_new();
    if (!RTEST(coverages)) {
	rb_raise(rb_eRuntimeError, "coverage measurement is not enabled");
    }
    st_foreach(RHASH_TBL(coverages), coverage_peek_result_i, ncoverages);
    rb_hash_freeze(ncoverages);
    return ncoverages;
}

void
Init_coverage_peek(void)
{
  rb_require("coverage.so");
  if (RUBY_API_VERSION_CODE >= 203000)
    return;
  id_Coverage = rb_intern("Coverage");
  rb_mCoverage = rb_const_get(rb_cObject, id_Coverage);
  rb_define_module_function(rb_mCoverage, "peek_result", rb_coverage_peek_result, 0);
}
