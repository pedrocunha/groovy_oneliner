require 'groovy_oneliner'

class GroovyOneliner
  class Converter

    def initialize(content)
      @content = content
    end

    def compute
      @content
           .gsub(/\/\/.*$/, '') # remove all comments //
           .gsub("\n", '')      # remove all line-breaks
           .gsub("\"", "'")     # substitute all double-quote to single-quote
           .gsub(/^$/, '')      # remove all empty lines
           .gsub(/;\s*/, ';')   # remove all whitespace after ;
    end
  end
end
