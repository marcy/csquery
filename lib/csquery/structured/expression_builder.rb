module Csquery
  class Structured
    class ExpressionBuilder
      attr_reader :expressions

      def initialize(&block)
        @expressions = []
        instance_exec(&block) if block_given?
      end

      def method_missing(m, *args, **kwargs, &block)
        args = ExpressionBuilder.new(&block).expressions if block_given?
        @expressions << Structured.public_send(m, *args, **kwargs)
      end

      def or_concat_(&block)
        expressions = ExpressionBuilder.new(&block).expressions

        if expressions.length > 1
          or_(*expressions)
        else
          @expressions.concat(expressions)
        end
      end
    end
  end
end
