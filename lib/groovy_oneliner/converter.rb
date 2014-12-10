require 'groovy_oneliner'

class GroovyOneliner
  class Converter

    def initialize(content)
      @content = content
    end

    def compute
      @content
           .gsub(/\/\/.*$/, '')                    # remove all comments //
           .gsub("\n", '')                         # remove all line-breaks
           .gsub("\"", "'")                        # substitute all double-quote to single-quote
           .gsub(/^$/, '')                         # remove all empty lines
           .gsub(%r{\/\*(\*(?!\/)|[^*])*\*\/}, '') # remove all /* */ comments
           .gsub(/\s*;\s*/, ';')                   # remove all whitespace before and after ;
           .gsub(/\s*=\s*/, '=')                   # remove all whitespace before and after ;
           .strip
    end
  end
end
