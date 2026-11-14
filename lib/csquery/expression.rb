module Csquery
  class Expression
    def initialize(operator, *args, options: {}, **kwargs)
      @operator = operator
      @options = options
      @fields = []

      args.each do |arg|
        if arg.is_a? FieldValue
          @fields << arg
        else
          @fields << FieldValue.new(value: arg)
        end
      end

      kwargs.sort_by {|k, _| k }.each do |k, v|
        @fields << FieldValue.new(name: k, value: v)
      end
    end

    def query
      options = Structured.format_options(@options).strip
      parts = [@operator]
      parts << options unless options.empty?
      parts.concat(@fields.map(&:to_s))
      "(#{parts.join(' ')})"
    end

    def to_s
      query
    end
  end
end
