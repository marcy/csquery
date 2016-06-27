module Csquery
  class Structured
    class << self
      def field(value, name = nil)
        FieldValue.new(value: value, name: name)
      end

      def and_(*args, **kwargs)
        Expression.new('and', *args, options: _get_option([:boost], kwargs), **kwargs)
      end


      def not_(*args, **kwargs)
        Expression.new('not', *args, options: _get_option([:field, :boost], kwargs), **kwargs)
      end

      def or_(*args, **kwargs)
        Expression.new('or', *args, options: _get_option([:boost], kwargs), **kwargs)
      end


      def term_(*args, **kwargs)
        Expression.new('term', *args, options: _get_option([:field, :boost], kwargs), **kwargs)
      end

      def near_(*args, **kwargs)
        Expression.new('near', *args, options: _get_option([:field, :distance, :boost], kwargs), **kwargs)
      end

      def phrase_(*args, **kwargs)
        Expression.new('phrase', *args, options: _get_option([:field, :boost], kwargs), **kwargs)
      end


      def prefix_(*args, **kwargs)
        Expression.new('prefix', *args, options: _get_option([:field, :boost], kwargs), **kwargs)
      end

      def range_(*args, **kwargs)
        Expression.new('range', *args, options: _get_option([:field, :boost], kwargs), **kwargs)
      end

      def format_value(value)
        if value.is_a? Array
          return format_range_values(*value)
        end

        if value.is_a? Expression
          return value.query
        end

        value = value.to_s

        if(value.start_with?('(') and value.end_with?(')'))\
          or(value.start_with?('{') and value.end_with?(']'))\
          or(value.start_with?('[') and value.end_with?('}'))\
          or(value.start_with?('[') and value.end_with?(']'))

          return value
        end

        "'#{escape(value)}'"
      end

      def format_options(options={})
        unless options
          return ''
        end

        ' ' + options.map{|k,v| "#{k}=#{v}"}.join(' ')
      end

      private

      def escape(string)
        string.gsub(/\\|\'/) {|word| "\\#{word}" }
      end

      def format_range_values(start, end_=nil)
        a = [nil, ''].include?(start) ? '{' : '['
        b = [nil, ''].include?(start) ? '' : start
        c = [nil, ''].include?(end_) ? '' : end_
        d = [nil, ''].include?(end_) ? '}' : ']'

        "#{a}#{b},#{c}#{d}"
      end

      def _get_option(keys, options)
        opts = {}

        keys.each do |key|
          opts[key] = options.delete(key) if options.keys.include?(key)
        end

        opts
      end
    end
  end
end
