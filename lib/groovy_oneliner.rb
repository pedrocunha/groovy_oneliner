require 'groovy_oneliner/version'
require 'groovy_oneliner/cache'
require 'groovy_oneliner/converter'
require 'singleton'

class GroovyOneliner
  include Singleton

  def initialize
    @cache = GroovyOneliner::Cache.new
  end

  def compute(file: file, options: {})
    if options[:cache]
      cached_content = @cache[file]
      return cached_content if cached_content
    end

    content = File.read(file)
    output  = GroovyOneliner::Converter.new(content).compute

    options[:cache] ? @cache[file] = output : output
  end

  def self.compute(file: path, options:)
    self.instance.compute(file: file, options: options)
  end

end

