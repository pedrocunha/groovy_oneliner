require 'groovy_oneliner/cache'

RSpec.describe GroovyOneliner::Cache do
  subject { described_class.new }

  describe '#[]' do
    it 'returns empty if nothing on cache' do
      expect(subject['foo']).to be_nil
    end
  end

  describe '#[]=' do
    it 'stores the value in the key' do
      expect(subject['foo'] = 'yadada').to eql('yadada')
    end
  end

  describe '#reset' do
    it 'resets the cache' do
      subject['foo'] = 'bar'
      subject.reset!

      expect(subject['foo']).to be_nil
    end
  end
end
