module Enumeration
  class Collection

    def initialize(map_or_list)
      unless map_or_list.kind_of?(::Hash) || map_or_list.kind_of?(::Array)
        raise ArgumentError, "please specify the enum collection as a Hash or Array"
      end
      @data = map_or_list
    end

    def [](value)
      if self.map? && @data.has_key?(value)
        @data[value]
      elsif (self.map? && @data.has_value?(value)) ||
            (@data.include?(value))
        value
      else
        nil
      end
    end

    def list?
      @data.kind_of?(::Array)
    end

    def map?
      @data.kind_of?(::Hash)
    end

    def set
      self.map? ? @data.keys : @data
    end

  end
end