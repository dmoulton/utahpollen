require 'helper'

class TestUtahpollen < Test::Unit::TestCase
  should "return values from utahallergy.com" do
    results = PollenCounts.get()
    assert_kind_of(Hash,results,"Did not return a hash")
  end
end
