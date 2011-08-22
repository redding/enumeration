module Enumeration; end
require 'enumeration/collection'

module Enumeration

  module ClassMethods
    def enum(name, map_or_list)
      # TODO: validate name
      c = Collection.new(map_or_list)

      # define an anonymous Module to extend on
      # defining a class level map reader
      class_methods = Module.new do
        define_method(name.to_s+'_collection') { c.data }
        define_method(name.to_s+'_set') { c.set }
        define_method(name) {|k| class_variable_get("@@#{name}")[k]} if c.map?
      end

      # set a class variable to store the enum map (used by above reader)
      # extend the anonymous module to get tne above class
      #   level reader for the map
      class_eval do
        class_variable_set("@@#{name}", c)
        extend class_methods
      end

      # instance writer for the enum value
      define_method("#{name}=") do |value|
        c = self.class.send(:class_variable_get, "@@#{name}")
        instance_variable_set("@#{name}", c[value])
      end

      # instance reader for the enum value
      define_method(name) { instance_variable_get("@#{name}") }

      # instance reader for the enum key
      define_method(name.to_s+'_key') do
        c = self.class.send(:class_variable_get, "@@#{name}")
        c.key(instance_variable_get("@#{name}"))
      end
    end
  end

  class << self
    def included(receiver)
      receiver.send :extend, ClassMethods
    end
  end

end
