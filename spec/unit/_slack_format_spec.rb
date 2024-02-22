# frozen_string_literal: true

require './spec/spec_helper'
require './lib/slack_format'

describe SlackFormat do
  describe '#hyper_text_pattern' do
    let(:text) { 'Hola <@LUC14AN>' }
    let(:fake_text) { 'Hola humano' }
    let(:dc) { DummyClass.new.extend(SlackFormat) }

    context 'when match succeeds' do
      it { expect(dc.hyper_text_pattern(text).captures[0]).to eq('LUC14AN') }
    end

    context 'when match fails' do
      it { expect(dc.hyper_text_pattern(fake_text)).to be nil }
      it { expect(dc.hyper_text_pattern(fake_text).respond_to?(:captures)).to be false }
    end
  end

  describe '#channel_pattern' do
    let(:dc) { DummyClass.new.extend(SlackFormat) }

    context 'when match succeeds' do
      it {
        expect(dc.channel_pattern('\echo #comunidad-seguridad un saludo')).to eq(['un saludo', '#comunidad-seguridad',
                                                                                  nil])
      }
      it {
        expect(dc.channel_pattern('\echo #comunidad-seguridad 1231 saludo')).to eq(['1231 saludo', '#comunidad-seguridad',
                                                                                    nil])
      }
      it {
        expect(dc.channel_pattern('\echo #comunidad-seguridad \!#as saludo')).to eq(['\!#as saludo', '#comunidad-seguridad',
                                                                                     nil])
      }
      it { expect(dc.channel_pattern('\echo <@LUC14AN|Lucio> un saludo')).to eq(['un saludo', 'LUC14AN', nil]) }
      it { expect(dc.channel_pattern('\echo LUC14AN un saludo')).to eq(['un saludo', 'LUC14AN', nil]) }
      it {
        expect(dc.channel_pattern('\echo CH4NN3L-1588015518.007300 un saludo')).to eq(['un saludo', 'CH4NN3L',
                                                                                       '1588015518.007300'])
      }
      it {
        expect(dc.channel_pattern('\dm #comunidad-seguridad un saludo')).to eq(['un saludo', '#comunidad-seguridad',
                                                                                nil])
      }
      it {
        expect(dc.channel_pattern('\dm #comunidad-seguridad \!#as saludo')).to eq(['\!#as saludo', '#comunidad-seguridad',
                                                                                   nil])
      }
      it { expect(dc.channel_pattern('\dm <@LUC14AN|Lucio> un saludo')).to eq(['un saludo', 'LUC14AN', nil]) }
      it {
        expect(dc.channel_pattern('\dm CH4NN3L-1588015518.007300 un saludo')).to eq(['un saludo', 'CH4NN3L',
                                                                                     '1588015518.007300'])
      }
      it {
        expect(dc.channel_pattern('\history #comunidad-seguridad un saludo')).to eq(['un saludo', '#comunidad-seguridad',
                                                                                     nil])
      }
      it {
        expect(dc.channel_pattern('\history CH4NN3L-1588015518.007300 un saludo')).to eq(['un saludo', 'CH4NN3L',
                                                                                          '1588015518.007300'])
      }
    end

    context 'when match fails' do
      # it { expect(dc.echo('\echo #comunidad-seguridadun saludo')).to eq(['saludo', '#comunidad-seguridadun', nil]) }
    end
  end

  describe '#coin_transaction' do
    let(:dc) { DummyClass.new.extend(SlackFormat) }

    context 'when intention is detected' do
      it { expect(dc.coin_pattern('<@rspec_test> ++ For testing')).to eq ['rspec_test', '++', ' For testing'] }
      it { expect(dc.coin_pattern('<@rspec_test> ++For testing')).to eq ['rspec_test', '++', 'For testing'] }
      it { expect(dc.coin_pattern('<@rspec_test>++For testing')).to eq ['rspec_test', '++', 'For testing'] }
      it { expect(dc.coin_pattern('<@rspec_test> ++ ')).to eq ['rspec_test', '++', ' '] }
      it { expect(dc.coin_pattern('<@rspec_test> --')).to eq ['rspec_test', '--', ''] }
      it { expect(dc.coin_pattern('<@rspec_test> balance ')).to eq ['rspec_test', 'balance', ' '] }
    end

    context 'when intention fails' do
      it { expect(dc.coin_pattern('<@rspec_test>//  ')).to eq false }
    end
  end
end
