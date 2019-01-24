require 'spec_helper'

describe Csquery::FieldValue do
  describe '.to_value' do
    specify do
      expect(Csquery::Expression.new('and', *[{'actor' => 'test'}], options: {'boost' => 3}, **{title: 'test'}).query).to eq("(and boost=3 actor:'test' title:'test')")
    end
  end
end
