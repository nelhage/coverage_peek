#include "coverage_peek.h"

VALUE rb_mCoveragePeek;

void
Init_coverage_peek(void)
{
  rb_mCoveragePeek = rb_define_module("CoveragePeek");
}
