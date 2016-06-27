module Csquery
  class FieldValue
    attr_reader :name, :value

    def initialize(value:, name: nil)
      value = value[0] if value.is_a?(Array) and value[0].is_a?(Hash)

      if value.is_a?(Hash)
        @name = value.keys[0]
        @value = Structured.format_value(value.values[0])
      else
        @name = name
        @value = Structured.format_value(value)
      end
    end

    def to_value
      return "#{@name}:#{@value}" if @name

      @value
    end

    def to_s
      to_value
    end
  end
end
