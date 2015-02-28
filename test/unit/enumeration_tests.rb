require "assert"
require 'enumeration'

module Enumeration

  class UnitTests < Assert::Context
    desc "Enumeration"
    setup do
      @enum_class = Class.new{ include Enumeration }
      @enum = @enum_class.new
    end
    subject{ @enum }

    should have_class_method :enum

  end

  class ListEnumTests < UnitTests
    desc "for a list"
    setup do
      @enum_class.send(:enum, :word, %w{aye bee see})
    end

    should have_cmeths :word_set, :word_collection
    should have_accessor :word

    should "not have a class level lookup method" do
      assert_raises NoMethodError do
        @enum_class.word
      end
    end

    should "provide class level access to the enum list" do
      words = @enum_class.word_set
      assert_kind_of ::Array, words
      assert_equal 3, words.size
      assert_equal ['aye', 'bee', 'see'], words
      assert_equal words, @enum_class.word_collection
    end

    should "write a value and read the value" do
      subject.word = "see"
      assert_equal "see", subject.word
      assert_equal "see", subject.word_key
    end

    should "write nil for values that aren't in the enum" do
      subject.word = Factory.string
      assert_equal nil, subject.word
      assert_equal nil, subject.word_key
    end

  end

  class MapEnumTests < UnitTests
    desc "for a map"
    setup do
      @enum_class.send(:enum, :stuff, {
        :a => "aye",
        :b => "bee",
        :c => "see"
      })
    end

    should have_cmeths :stuff, :stuff_set, :stuff_collection
    should have_accessor :stuff

    should "provide class level lookup of the enum" do
      assert_equal "aye", @enum_class.stuff(:a)
    end

    should "provide class level access to the enum set" do
      stuffs = @enum_class.stuff_set
      assert_kind_of ::Array, stuffs
      assert_equal 3, stuffs.size
      [:a, :b, :c].each{ |s| assert @enum_class.stuff_set.include?(s) }

      exp = {
        :a => 'aye',
        :b => 'bee',
        :c => 'see'
      }
      assert_equal exp, @enum_class.stuff_collection
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
      subject.stuff = Factory.string.to_sym
      assert_equal nil, subject.stuff
      assert_equal nil, subject.stuff_key
    end

    should "write nil for values that aren't in the enum" do
      subject.stuff = Factory.string
      assert_equal nil, subject.stuff
      assert_equal nil, subject.stuff_key
    end

  end

end
