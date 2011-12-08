require 'assert'

require 'enumeration'
require 'enumeration/assert_macros'

module Enumeration::AssertMacros

  class BaseTests < Assert::Context
    desc "Enumeration::AssertMacros"
    include Enumeration::AssertMacros

    before do
      Thing.send :include, Enumeration
      Thing.send(:enum, :list, %w{aye bee see})
      Thing.send(:enum, :map, {
        :a => "aye",
        :b => "bee",
        :c => "see"
      })
      @a_thing = Thing.new
    end
    subject { @a_thing }

    should have_enum :list
    should have_enum :list, ['aye', 'bee', 'see']
    should have_enum :list, 'aye', 'bee', 'see'

    should have_enum :map
    should have_enum :map, :a => "aye", :b => "bee", :c => "see"

  end

end
