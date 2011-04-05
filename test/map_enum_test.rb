require "test/helper"

class MapEnumTest < Test::Unit::TestCase
  context "instance" do

    subject { Thing.new }
    before do
      Thing.send :include, Enumeration
      Thing.send(:enum, :stuff, {
        :a => "aye",
        :b => "bee",
        :c => "see"
      })
    end

    should_have_class_methods :stuff, :stuff_set
    should_have_accessor :stuff

    should "provide class level access to the enum set" do
      stuffs = Thing.stuff_set
      assert stuffs
      assert_kind_of ::Array, stuffs
      assert !stuffs.empty?
      assert_equal 3, stuffs.size
      [:a, :b, :c].each{|t| assert Thing.stuff_set.include?(t)}
    end

    should "provide class level lookup of the enum" do
      assert_equal "aye", Thing.stuff(:a)
    end

    should "write by key and read by value" do
      subject.stuff = :b
      assert_equal "bee", subject.stuff
    end

    should "write by value and read by value" do
      subject.stuff = "see"
      assert_equal "see", subject.stuff
    end

    should "not read by key" do
      subject.stuff = :c
      assert_not_equal :c, subject.stuff
    end

    should "write nil for keys that aren't in the enum" do
      subject.stuff = :bad
      assert_equal nil, subject.stuff
    end

    should "write nil for values that aren't in the enum" do
      subject.stuff = "bady-bad"
      assert_equal nil, subject.stuff
    end

  end
end
