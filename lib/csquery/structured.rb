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
        return format_range_values(*value) if value.is_a?(Array)

        return "#{value}" if value.is_a?(Numeric)

        return value.query if value.is_a?(Expression)

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
        return '' unless options

        ' ' + options.map{|k,v| "#{k}=#{v}"}.join(' ')
      end

      private

      def escape(string)
        string.gsub(/\\|\'/) {|word| "\\#{word}" }
      end

      def format_range_values(start_val, end_val = nil)
        start_paren = [nil, ''].include?(start_val) ? '{' : '['
        start_value = [nil, ''].include?(start_val) ? '' : start_val
        end_value = [nil, ''].include?(end_val) ? '' : end_val
        end_paren = [nil, ''].include?(end_val) ? '}' : ']'

        "#{start_paren}#{start_value},#{end_value}#{end_paren}"
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
