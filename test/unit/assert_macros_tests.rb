require 'assert'
require 'enumeration/assert_macros'

module Enumeration::AssertMacros

  class UnitTests < Assert::Context
    include Enumeration::AssertMacros

    desc "Enumeration::AssertMacros"
    setup do
      @enum_class = Class.new do
        include Enumeration

        enum :list, %w{aye bee see}

        enum :map, {
          :a => "aye",
          :b => "bee",
          :c => "see"
        }
      end
      @enum = @enum_class.new
    end
    subject{ @enum }

    should have_enum :list
    should have_enum :list, ['aye', 'bee', 'see']
    should have_enum :list, 'aye', 'bee', 'see'

    should have_enum :map
    should have_enum :map, :a => "aye", :b => "bee", :c => "see"

  end

end
