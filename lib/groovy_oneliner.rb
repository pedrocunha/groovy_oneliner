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
    paths        = Array(options.fetch(:path))
    should_cache = options.fetch(:cache, false) || self.class.always_cache

    cache_path   = paths.join

    if should_cache
      cached_content = @cache[cache_path]
      return cached_content if cached_content
    end

    content = paths.reduce([]) { |script, path| script << File.read(path) }.join(';')

    output  = GroovyOneliner::Converter.new(content).compute

    should_cache ? @cache[cache_path] = output : output
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
