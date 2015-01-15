require 'groovy_oneliner'

RSpec.describe GroovyOneliner do

  it 'does not allow to initialize an instance of this class' do
    expect { described_class.new }.to raise_error
  end

  describe '.compute' do

    let(:path)    { 'path/to/file' }
    let(:options) { { path: path } }

    before  { Singleton.__init__(GroovyOneliner) }
    subject { described_class }

    it 'allows to compute a file' do
      expect(File).to receive(:read).once.with(path).and_return("foo = 1;")
      subject.compute(options)
    end

    context 'file contents' do
      it 'returns the file contents' do
        allow(File).to receive(:read).with(path).and_return("foo = 1;")
        expect(subject.compute(options)).to eql('foo=1;')
      end

      context 'with multiple files' do
        let(:path) { ['path/to/file', 'path/to/file2'] }

        before do
          allow(File).to receive(:read).with(path[0]).and_return("foo = 1;")
          allow(File).to receive(:read).with(path[1]).and_return("bar = 2;")
        end

        it 'returns contents with ; added in between each file content' do
          expect(subject.compute(options)).to eql('foo=1;;bar=2;')
        end
      end
    end

    context 'when caching is off' do
      context 'with single file' do
        it 'reads the file as many times as calls to compute' do
          expect(File).to receive(:read).twice.with(path).and_return("foo = 1;")
          subject.compute(options)
          subject.compute(options)
        end
      end

      context 'with multiple files' do
        let(:path) { ['path/to/file', 'path/to/file2'] }

        it 'reads both files as many times as calls to compute' do
          expect(File).to receive(:read).twice.with(path[0]).and_return("foo = 1;")
          expect(File).to receive(:read).twice.with(path[1]).and_return("foo = 1;")
          subject.compute(options)
          subject.compute(options)
        end
      end
    end

    context 'when caching is on' do
      let(:options) { { path: path, cache: true } }

      context 'with single file' do
        it 'reads the file only once' do
          expect(File).to receive(:read).once.with(path).and_return("foo = 1;")
          subject.compute(options)
          subject.compute(options)
        end
      end

      context 'with multiple files' do
        let(:path) { ['path/to/file', 'path/to/file2'] }

        it 'reads both files as many times as calls to compute' do
          expect(File).to receive(:read).once.with(path[0]).and_return("foo = 1;")
          expect(File).to receive(:read).once.with(path[1]).and_return("foo = 1;")
          subject.compute(options)
          subject.compute(options)
        end
      end
    end

    context 'when caching is on through the class variable' do
      before { described_class.always_cache = true }

      it 'reads the file only once' do
        expect(File).to receive(:read).once.with(path).and_return("foo = 1;")
        subject.compute(options)
        subject.compute(options)
      end

      after  { described_class.always_cache = false }
    end

  end


end
