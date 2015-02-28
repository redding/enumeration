module Enumeration

  module AssertMacros

    # a set of Assert macros to help write enum definition and
    # regression tests in Assert (https://github.com/teaminsight/assert)

    def self.included(receiver)
      receiver.class_eval do
        extend MacroMethods
      end
    end

    module MacroMethods

      def have_enum(name, *args)
        values = [*args].flatten
        type = nil
        if values.first.kind_of?(::Hash)
          values = values.first
          type = 'map'
        elsif !values.empty?
          type = 'list'
        end

        called_from = caller.first
        macro_name =  "have the"
        macro_name += " #{type}" if type
        macro_name += " enum '#{name}'"
        macro_name += " with #{values.inspect} values" if !values.empty?

        Assert::Macro.new(macro_name) do
          should have_accessor name, [called_from]

          should have_class_method "#{name}_collection", [called_from]

          if type == 'map'
            should have_class_method name, [called_from]
          end

          if !values.empty?
            should "know its '#{name}' enum values", called_from do
              assert_equal values, subject.class.send("#{name}_collection")
            end

            if type == 'map'
              should "map the '#{name}' enum values at the class level", called_from do
                values.each {|k,v| assert_equal v, subject.class.send(name, k)}
              end
            end
          end

        end
      end

    end

  end

end
