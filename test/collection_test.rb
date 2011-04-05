require "test/helper"
require "enumeration/collection"

class CollectionAPITest < Test::Unit::TestCase
  context "Enumeration collection" do
    subject { Enumeration::Collection.new([]) }

    should_have_instance_methods :set, :map?, :list?, :[]

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
end

class ListCollectionTest < Test::Unit::TestCase
  context "List collection" do
    subject { Enumeration::Collection.new(['one', 'two', 'three']) }

    should "be a list" do
      assert_equal true, subject.list?
      assert_equal false, subject.map?
    end

    should "know it's set" do
      assert_equal ['one', 'two', 'three'], subject.set
    end

    should "lookup by value" do
      assert_equal 'two', subject['two']
    end

  end
end

class MapCollectionTest < Test::Unit::TestCase
  context "Map collection" do
    subject { Enumeration::Collection.new({ :one => 1, :two => 2, :three => 3}) }

    should "be a map" do
      assert_equal true, subject.map?
      assert_equal false, subject.list?
    end

    should "know it's set" do
      [:one, :two, :three].each{|n| assert subject.set.include?(n)}
    end

    should "lookup by key" do
      assert_equal 2, subject[:two]
    end

    should "lookup by value" do
      assert_equal 2, subject[2]
    end

  end
end