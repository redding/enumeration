require "assert"
require "enumeration/collection"

class Enumeration::Collection

  class UnitTests < Assert::Context
    desc "Enumeration::Collection"
    setup do
      @collection = Enumeration::Collection.new([])
    end
    subject{ @collection }

    should have_readers :data
    should have_imeths :[], :key, :list?, :map?, :set

    should "only be created from Arrays or Hashes" do
      assert_raises ArgumentError do
        Enumeration::Collection.new(Factory.string)
      end
      assert_nothing_raised do
        Enumeration::Collection.new([])
        Enumeration::Collection.new({})
      end
    end

  end

  class ListCollectionTests < UnitTests
    desc "for a list"
    setup do
      @list = ['one', 'two', 'three']
      @collection = Enumeration::Collection.new(@list)
    end

    should "be a list" do
      assert_true  subject.list?
      assert_false subject.map?
    end

    should "know its data" do
      assert_equal @list, subject.data
    end

    should "know its set" do
      assert_equal @list, subject.set
    end

    should "lookup value by key" do
      assert_equal 'two', subject['two']
    end

    should "lookup key by value" do
      assert_equal 'three', subject.key('three')
    end

  end

  class MapCollectionTests < UnitTests
    desc "for a map"
    setup do
      @map = {
        :one   => 1,
        :two   => 2,
        :three => 3
      }
      @collection = Enumeration::Collection.new(@map)
    end

    should "be a map" do
      assert_true  subject.map?
      assert_false subject.list?
    end

    should "know its data" do
      assert_equal(@map, subject.data)
    end

    should "know it's set" do
      @map.keys.each{ |k| assert subject.set.include?(k) }
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

end
