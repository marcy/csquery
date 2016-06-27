require 'spec_helper'

describe Csquery::FieldValue do
  describe '.to_value' do
    specify do
      expect(Csquery::FieldValue.new(value: 'test').name).to eq(nil)
      expect(Csquery::FieldValue.new(value: 'test').value).to eq("'test'")
      expect(Csquery::FieldValue.new(value: 'test').to_s).to eq("'test'")

      expect(Csquery::FieldValue.new(value: 'test', name: 'name').name).to eq('name')
      expect(Csquery::FieldValue.new(value: 'test', name: 'name').value).to eq("'test'")
      expect(Csquery::FieldValue.new(value: 'test', name: 'name').to_s).to eq("name:'test'")

      expect(Csquery::FieldValue.new(value: [{name: 'test'}]).name).to eq(:name)
      expect(Csquery::FieldValue.new(value: [{name: 'test'}]).value).to eq("'test'")
      expect(Csquery::FieldValue.new(value: [{name: 'test'}]).to_s).to eq("name:'test'")
    end
  end
end
