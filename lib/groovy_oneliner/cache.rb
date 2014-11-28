require 'groovy_oneliner'

class GroovyOneliner
  class Cache

    def initialize
      @cache = {}
    end

    def [](key)
      @cache[key]
    end

    def []=(key, value)
      @cache[key] = value
    end

    def reset!
      @cache = {}
    end

  end
end
