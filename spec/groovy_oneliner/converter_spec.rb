require 'groovy_oneliner/converter'

RSpec.describe GroovyOneliner::Converter do

  describe '#initialization' do
    it 'raises an error on missing argument' do
      expect { described_class.new }.to raise_error
    end

    it 'returns an instance when good argument' do
      expect { described_class.new("foo") }.to_not raise_error
    end
  end

  describe '#compute' do

    it 'removes all // comments' do
      subject = described_class.new <<-TEXT
// This is a comment and will be ignored
return 1;
      TEXT

      expect(subject.compute).to eql("return 1;")
    end

    it 'removes all line breaks' do
      subject = described_class.new <<-TEXT
a = 3;
return 1;
      TEXT

      expect(subject.compute).to eql("a = 3;return 1;")
    end

    it 'removes all empty lines' do
      subject = described_class.new <<-TEXT
a = 4;

b = 5;
      TEXT

      expect(subject.compute).to eql("a = 4;b = 5;")
    end

    it 'removes all whitespace after ;' do
      subject = described_class.new <<-TEXT
a = 4; b = 5;
      TEXT

      expect(subject.compute).to eql("a = 4;b = 5;")
    end

    it 'removes all /* comment */ blocks' do
      subject = described_class.new <<-TEXT
/*
 * This is a comment and will be ignored
 */
return 1;
      TEXT

      expect(subject.compute).to eql("return 1;")
    end

  end
end
