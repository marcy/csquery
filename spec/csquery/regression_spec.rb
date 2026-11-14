require 'spec_helper'

# Reproduction specs for two suspected bugs found by code review.
# All examples in this file are EXPECTED TO FAIL against the current
# implementation. They document the intended behavior; the fixes are
# intentionally not part of the change that introduces these specs.
describe 'regression reproductions' do
  describe 'exclusive range strings passed to range_' do
    it 'passes a {a,b} range through unquoted' do
      expect(Csquery::Structured.range_('{1990,2000}').query).to eq('(range {1990,2000})')
    end

    it 'passes a {,b} range (open start, exclusive end) through unquoted' do
      expect(Csquery::Structured.range_('{,2000}').query).to eq('(range {,2000})')
    end
  end

  describe 'whitespace inside quoted values' do
    it 'preserves consecutive spaces in a phrase value' do
      expect(Csquery::Structured.phrase_('a  b').query).to eq("(phrase 'a  b')")
    end

    it 'preserves a tab character in a term value' do
      expect(Csquery::Structured.term_("a\tb").query).to eq("(term 'a\tb')")
    end
  end
end
