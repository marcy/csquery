require 'spec_helper'

describe Csquery do
  it 'has a version number' do
    expect(Csquery::VERSION).not_to be nil
  end

  describe 'Complex query' do
    subject {
      Csquery::Structured.and_(
        Csquery::Structured.not_('test', field:'genres'),
        Csquery::Structured.or_(
          Csquery::Structured.term_('star', field:'title', boost:2),
          Csquery::Structured.term_('star', field:'plot')
        )
      ).query
    }

    it { is_expected.to eq("(and (not field=genres 'test') (or (term field=title boost=2 'star') (term field=plot 'star')))")}
  end

  describe '#format_options' do
    subject { Csquery::Structured.format_options(test: 'test') }

    it { is_expected.to eq(' test=test') }
  end

  describe '#range_' do
    specify do
      expect(Csquery::Structured.range_([1990, 2000]).query).to eq('(range [1990,2000])')

      expect(Csquery::Structured.range_('[1990,2000]').query).to eq('(range [1990,2000])')

      expect(Csquery::Structured.range_([nil, 2000]).query).to eq('(range {,2000])')

      expect(Csquery::Structured.range_('{,2000]').query).to eq('(range {,2000])')

      expect(Csquery::Structured.range_([1990, nil]).query).to eq('(range [1990,})')

      expect(Csquery::Structured.range_('[1990,}').query).to eq('(range [1990,})')

      expect(Csquery::Structured.range_(['1967-01-31T23:20:50.650Z',
                                         '1967-01-31T23:59:59.999Z']).query).to eq('(range [1967-01-31T23:20:50.650Z,1967-01-31T23:59:59.999Z])')

      expect(Csquery::Structured.range_([1990, 2000], field: 'date', boost: 2).query).to eq('(range field=date boost=2 [1990,2000])')
    end
  end
end
