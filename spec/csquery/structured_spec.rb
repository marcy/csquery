require 'spec_helper'

describe Csquery::Structured do
  describe '.and_' do
    specify do
      expect(Csquery::Structured.and_(title: 'star', actors: 'Harrison Ford', year: ['', 2000]).query).to eq("(and actors:'Harrison Ford' title:'star' year:{,2000])")

      expect(Csquery::Structured.and_(['title' => 'star'], ['title' => 'star2']).query).to eq("(and title:'star' title:'star2')")


      expect(Csquery::Structured.and_(Csquery::Structured.field('star', 'title'),
                                      Csquery::Structured.field('star2', 'title')).query).to eq("(and title:'star' title:'star2')")

      expect(Csquery::Structured.and_(['title' => 'star'], ['title' => 'star2'], boost: 2).query).to eq("(and boost=2 title:'star' title:'star2')")
    end

    context 'complex query' do
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

  describe '.or_' do
    specify do
      expect(Csquery::Structured.or_(title: 'star', actors: 'Harrison Ford', year: ['', 2000]).query).to eq("(or actors:'Harrison Ford' title:'star' year:{,2000])")

      expect(Csquery::Structured.or_([{'title': 'star'}], [{'title': 'star2'}]).query).to eq("(or title:'star' title:'star2')")


      expect(Csquery::Structured.or_(Csquery::Structured.field('star', 'title'),
                                     Csquery::Structured.field('star2', 'title')).query).to eq("(or title:'star' title:'star2')")

      expect(Csquery::Structured.or_([{'title': 'star'}], [{'title': 'star2'}], boost: 2).query).to eq("(or boost=2 title:'star' title:'star2')")
    end
  end

  describe '.not_' do
    specify do
      expect(Csquery::Structured.not_(
              Csquery::Structured.and_(actors: 'Harrison Ford', year: ['', 2010])
            ).query).to eq("(not (and actors:'Harrison Ford' year:{,2010]))")


      expect(Csquery::Structured.not_(
              Csquery::Structured.and_(actors: 'Harrison Ford', year: ['', 2010]),
              boost: 2
            ).query).to eq("(not boost=2 (and actors:'Harrison Ford' year:{,2010]))")
    end
  end

  describe '.near_' do
    specify do
      expect(Csquery::Structured.near_('teenage vampire').query).to eq("(near 'teenage vampire')")

      expect(Csquery::Structured.near_('teenage vampire',
                                       boost: 2, field: 'plot', distance: 2
                                      ).query).to eq("(near field=plot distance=2 boost=2 'teenage vampire')")
    end
  end

  describe '.phrase_' do
    specify do
      expect(Csquery::Structured.phrase_('teenage girl').query).to eq("(phrase 'teenage girl')")

      expect(Csquery::Structured.phrase_('teenage girl', boost: 2, field: 'plot').query).to eq("(phrase field=plot boost=2 'teenage girl')")
    end
  end


  describe '.prefix_' do
    specify do
      expect(Csquery::Structured.prefix_('star').query).to eq("(prefix 'star')")

      expect(Csquery::Structured.prefix_('star', boost: 2, field: 'title').query).to eq("(prefix field=title boost=2 'star')")
    end
  end

  describe '.term_' do
    specify do
      expect(Csquery::Structured.term_('star').query).to eq("(term 'star')")

      expect(Csquery::Structured.term_(2000).query).to eq('(term 2000)')

      expect(Csquery::Structured.term_(2000, field: 'year', boost: 2).query).to eq('(term field=year boost=2 2000)')
    end
  end

  describe '.range_' do
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

  describe '.format_options' do
    subject { Csquery::Structured.format_options(test: 'test') }

    it { is_expected.to eq(' test=test') }
  end
end
