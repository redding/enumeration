require "assert"

require 'enumeration'

class APITest < Assert::Context
  desc "Enumeration mixin"

  subject { Thing.new }
  before do
    Thing.send :include, Enumeration
  end

  should have_class_method :enum

end
