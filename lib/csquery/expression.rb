module Csquery
  class Expression
    def initialize(operator, *args, options: {}, **kwargs)
      @operator = operator
      @options = options
      @fields = []

      args.each do |a|
        if a.is_a? FieldValue
          @fields << a
        else
          @fields << FieldValue.new(value: a)
        end
      end

      kwargs.sort_by {|k, _| k }.each do |k, v|
        @fields << FieldValue.new(name: k, value: v)
      end
    end

    def query
      "(#{@operator}#{Structured::format_options(@options)} #{@fields.map(&:to_s).join(' ')})".gsub(/\s+/, ' ')
    end

    def to_s
      query
    end
  end
end
