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
end
