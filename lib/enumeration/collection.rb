module Enumeration
  class Collection

    attr_reader :data

    def initialize(map_or_list)
      unless map_or_list.kind_of?(::Hash) || map_or_list.kind_of?(::Array)
        raise ArgumentError, "please specify the enum collection as a Hash or Array"
      end
      @data = map_or_list
    end

    # lookup collection value by a key
    def [](key)
      if self.map? && @data.has_key?(key)
        @data[key]
      elsif (self.map?  && @data.has_value?(key)) ||
            (self.list? && @data.include?(key))
        key
      else
        nil
      end
    end

    # lookup collection key by a value
    def key(value)
      if self.map? && @data.has_value?(value)
        @data.index(value)
      elsif (self.map?  && @data.has_key?(value)) ||
            (self.list? && @data.include?(value))
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