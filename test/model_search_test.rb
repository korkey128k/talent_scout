require "test_helper"
require "talent_scout"

class ModelSearchTest < Minitest::Test

  def test_kind_of_active_model
    assert_kind_of ActiveModel::Model, MyModelSearch.new
  end

  def test_attribute_assignment_type_casts_values
    expected = {
      str1: "abc",
      int1: 123,
      date1: Date.new(1999, 12, 31),
      date2: Date.new(2000, 01, 01),
    }

    search = MyModelSearch.new(expected.transform_values(&:to_s))
    assert_equal expected, search.attributes.symbolize_keys
  end

  private

  class MyModelSearch < TalentScout::ModelSearch
    criteria :str1
    criteria :int1, :integer
    criteria %i[date1 date2], :date
  end

end
