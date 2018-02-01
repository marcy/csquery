module Csquery
  class Structured
    class Builder < ExpressionBuilder
      attr_reader :root

      def initialize(root, &block)
        @root = root
        super(&block)
      end

      def query
        Structured.public_send(root, *expressions).query
      end
    end
  end
end
