module Csquery
  class Structured
    class FieldValue
      def initialize(value:, name: nil)
        if value.is_a? Array and value[0].is_a? Hash
          @name = value[0].keys[0]
          @value = Structured.format_value(value[0].values[0])
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
end