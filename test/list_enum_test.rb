require "test/helper"

class ListEnumTest < Test::Unit::TestCase
  context "instance" do

    subject { Thing.new }
    before do
      Thing.send :include, Enumeration
      Thing.send(:enum, :word, %w{aye bee see})
    end

    should_have_class_methods :word_set, :word_collection
    should_have_accessor :word

    should "not have a class level lookup method" do
      assert_raises NoMethodError do
        Thing.word
      end
    end

    should "provide class level access to the enum set" do
      words = Thing.word_set
      assert words
      assert_kind_of ::Array, words
      assert !words.empty?
      assert_equal 3, words.size
      assert_equal ['aye', 'bee', 'see'], Thing.word_set
      assert_equal Thing.word_set, Thing.word_collection
    end

    should "write a value and read the value" do
      subject.word = "see"
      assert_equal "see", subject.word
    end

    should "write a value and read the key" do
      subject.word = "see"
      assert_equal "see", subject.word_key
    end

    should "write nil for values that aren't in the enum" do
      subject.word = "bady-bad"
      assert_equal nil, subject.word
      assert_equal nil, subject.word_key
    end

  end
end

