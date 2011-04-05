require "test/helper"

class APITest < Test::Unit::TestCase
  context "Enumeration mixin" do

    subject { Thing.new }
    before do
      Thing.send :include, Enumeration
    end

    should_have_class_method :enum

  end
end
