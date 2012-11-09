module Application
  module Enum
    def initialize(key, value)
      @key = key
      @value = value
    end

    def key
      @key
    end

    def value
      @value
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def define(key, value)
        @hash = ActiveSupport::OrderedHash.new if @hash.nil?
        @hash[key] = value

        @array ||= []
        @array << [key, value]
      end

      def const_missing(key)
        val(key)
      end

      def val(key)
        @hash[key]
      end

      def key(val)
        @array.each do |element|
          if element[1] == val
            return element[0]
          end
        end
        return nil
      end

      def key_string(val)
        key(val).to_s.downcase
      end

      def each
        @array.each do |element|
          key = element[0]
          value = element[1]
          yield key, value
        end
      end

      def map
        @hash.map
      end

      def collect
        @hash.keys.collect
      end

      def all
        @hash.keys
      end

      def all_to_hash
        hash = {}
        each do |key, value|
          hash[key] = value.value
        end
        hash
      end

      def t(key)
        I18n.t("#{self.to_s.underscore}.#{key}")
      end
    end
  end
end