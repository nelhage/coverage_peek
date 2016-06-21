require 'test_helper'
require 'coverage.so'
Coverage.start

class CoveragePeekTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::CoveragePeek::VERSION
  end

  def test_peek
    assert(require_relative('_lib/coverage_test'))
    before = Coverage.peek_result
    assert_kind_of(Hash, before)
    f = before.keys.find { |k| k.end_with?("_lib/coverage_test.rb") }
    assert(f)
    assert_kind_of(Array, before[f])
    CoveragePeekTestHelper.a_method
    after = Coverage.peek_result
    assert_kind_of(Hash, before)
    refute_equal(before[f], after[f])
  end

  def test_peek_filtered
    Coverage.peek_result_filtered
  end
end
