require 'groovy_oneliner'

RSpec.describe GroovyOneliner do

  it 'does not allow to initialize an instance of this class' do
    expect { described_class.new }.to raise_error
  end

  describe '.compute' do

    let(:path)    { 'path/to/file' }
    let(:options) { { path: path } }

    subject { described_class }

    it 'allows to compute a file' do
      expect(File).to receive(:read).once.with(path).and_return("foo = 1;")
      subject.compute(options)
    end

    context 'when caching is off' do
      it 'reads the file as many times as calls to compute' do
        expect(File).to receive(:read).twice.with(path).and_return("foo = 1;")
        subject.compute(options)
        subject.compute(options)
      end
    end

    context 'when caching is on' do
      let(:options) { { path: path, cache: true } }

      it 'reads the file only once' do
        expect(File).to receive(:read).once.with(path).and_return("foo = 1;")
        subject.compute(options)
        subject.compute(options)
      end
    end

  end


end
