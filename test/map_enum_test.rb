require "assert"

require 'enumeration'

class MapEnumTest < Assert::Context
  desc "instance"

  subject { @a_thing }
  before do
    Thing.send :include, Enumeration
    Thing.send(:enum, :stuff, {
      :a => "aye",
      :b => "bee",
      :c => "see"
    })
    @a_thing = Thing.new
  end

  should have_class_methods :stuff, :stuff_set, :stuff_collection
  should have_accessor :stuff

  should "provide class level access to the enum set" do
    stuffs = Thing.stuff_set
    assert stuffs
    assert_kind_of ::Array, stuffs
    assert !stuffs.empty?
    assert_equal 3, stuffs.size
    [:a, :b, :c].each{|t| assert Thing.stuff_set.include?(t)}
    assert_equal({:a=>'aye',:b=>'bee',:c=>'see'}, Thing.stuff_collection)
  end

  should "provide class level lookup of the enum" do
    assert_equal "aye", Thing.stuff(:a)
  end

  should "write a key and read the value and key" do
    subject.stuff = :b
    assert_equal "bee", subject.stuff
    assert_equal :b, subject.stuff_key
  end

  should "write a value and read the value" do
    subject.stuff = "see"
    assert_equal "see", subject.stuff
    assert_equal :c, subject.stuff_key
  end

  should "not read keys like you would values" do
    subject.stuff = :c
    assert_not_equal :c, subject.stuff
  end

  should "write nil for keys that aren't in the enum" do
    subject.stuff = :bad
    assert_equal nil, subject.stuff
    assert_equal nil, subject.stuff_key
  end

  should "write nil for values that aren't in the enum" do
    subject.stuff = "bady-bad"
    assert_equal nil, subject.stuff
    assert_equal nil, subject.stuff_key
  end

end
