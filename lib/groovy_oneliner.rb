require 'groovy_oneliner/version'
require 'groovy_oneliner/cache'
require 'groovy_oneliner/converter'
require 'singleton'

class GroovyOneliner
  include Singleton

  def initialize
    @cache = GroovyOneliner::Cache.new
  end

  def compute(options = {})
    path         = options.fetch(:path)
    should_cache = options.fetch(:cache, false) || self.class.always_cache

    if should_cache
      cached_content = @cache[path]
      return cached_content if cached_content
    end

    content = File.read(path)
    output  = GroovyOneliner::Converter.new(content).compute

    should_cache ? @cache[path] = output : output
  end

  def self.compute(options = {})
    self.instance.compute(options)
  end

  @@always_cache = false

  def self.always_cache=(value)
    @@always_cache = value
  end

  def self.always_cache
    @@always_cache
  end

end

