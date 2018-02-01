require 'spec_helper'

describe Csquery::Structured::Builder do
  describe '#query' do
    let(:builder) do
      Csquery::Structured::Builder.new(:and_) do
        not_('test', field:'genres')

        or_ do
          term_('star', field:'title', boost:2)
          term_('star', field:'plot')
        end
      end
    end

    specify do
      expect(builder.query).to eq(
        <<-CSQUERY.strip.gsub(/\s+/, ' ')
          (and
            (not field=genres 'test')
            (or
              (term field=title boost=2 'star')
              (term field=plot 'star')))
        CSQUERY
      )
    end
  end

  describe '#or_concat_' do
    context 'with one sub-expression' do
      let(:builder) do
        Csquery::Structured::Builder.new(:and_) do
          not_('test', field:'genres')

          or_concat_ do
            term_('star', field:'title', boost:2)
          end
        end
      end

      specify do
        expect(builder.query).to eq(
          <<-CSQUERY.strip.gsub(/\s+/, ' ')
            (and
              (not field=genres 'test')
              (term field=title boost=2 'star'))
          CSQUERY
        )
      end
    end

    context 'with multiple sub-expression' do
      let(:builder) do
        Csquery::Structured::Builder.new(:and_) do
          not_('test', field:'genres')

          or_concat_ do
            term_('star', field:'title', boost:2)
            term_('star', field:'plot')
          end
        end
      end

      specify do
        expect(builder.query).to eq(
          <<-CSQUERY.strip.gsub(/\s+/, ' ')
            (and
              (not field=genres 'test')
              (or
                (term field=title boost=2 'star')
                (term field=plot 'star')))
          CSQUERY
        )
      end
    end
  end
end
