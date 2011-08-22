require "assert"

require "enumeration/collection"

class CollectionAPITest < Assert::Context
  desc "Enumeration collection"
  subject { Enumeration::Collection.new([]) }

  should have_reader :data
  should have_instance_methods :set, :map?, :list?, :[]

  should "only be created from Arrays or Hashes" do
    assert_raises ArgumentError do
      Enumeration::Collection.new('stuff')
    end
    assert_nothing_raised do
      Enumeration::Collection.new([])
      Enumeration::Collection.new({})
    end
  end

end

class ListCollectionTest < Assert::Context
  desc "List collection"
  subject { Enumeration::Collection.new(['one', 'two', 'three']) }

  should "be a list" do
    assert_equal true, subject.list?
    assert_equal false, subject.map?
  end

  should "know it's data" do
    assert_equal ['one', 'two', 'three'], subject.data
  end

  should "know it's set" do
    assert_equal ['one', 'two', 'three'], subject.set
  end

  should "lookup value by key" do
    assert_equal 'two', subject['two']
  end

  should "lookup key by value" do
    assert_equal 'three', subject.key('three')
  end

end

class MapCollectionTest < Assert::Context
  desc "Map collection"
  subject { Enumeration::Collection.new({ :one => 1, :two => 2, :three => 3}) }

  should "be a map" do
    assert_equal true, subject.map?
    assert_equal false, subject.list?
  end

  should "know it's data" do
    assert_equal({:one=>1,:two=>2,:three=>3}, subject.data)
  end

  should "know it's set" do
    [:one, :two, :three].each{|n| assert subject.set.include?(n)}
  end

  should "lookup value by key" do
    assert_equal 2, subject[:two]
  end

  should "lookup value by value" do
    assert_equal 2, subject[2]
  end

  should "lookup key by value" do
    assert_equal :two, subject.key(2)
  end

  should "lookup key by key" do
    assert_equal :two, subject.key(:two)
  end

end
