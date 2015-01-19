# GroovyOneliner
[![Build Status](https://travis-ci.org/pedrocunha/groovy_oneliner.svg)](https://travis-ci.org/pedrocunha/groovy_oneliner?branch=master) [![Code Climate](https://codeclimate.com/github/pedrocunha/groovy_oneliner/badges/gpa.svg)](https://codeclimate.com/github/pedrocunha/groovy_oneliner)

Convert any groovy script file to a single line script. It is recommended (and also in order for this gem to work) that all lines must be terminated with `;`.

### What would this help with ?
In order to do scripting in [ElasticSearch](https://github.com/elasticsearch/elasticsearch) you can pick an handful of languages to inject code in your queries however ElasticSearch requires you that any script is written as a single line of code (not to mention the obvious properly formatted with `;`) at query time. 

One of the languages supported is Groovy. Groovy is very similar to Java. 

`GroovyOneliner` was extracted from one of the production apps at [HouseTrip](http://housetrip.com), since it allows to have a separate file for the Groovy script, which benefits: syntax highlighting, multilines, comments etc... and convert that script into one liner that you can use for queries. Nevertheless is important to say this is being used in production.

It is simple as it is, i.e, there are no external dependencies and while it's a very small task, it should allow to avoid repeating the same parsing code over and over.

This gem won't do for you:
- Check if there is any syntax errors
- Check if you hate semi-colons

What does it actually do:
- Removes all `//` & `\* ... */` comments
- Attempts to remove as much white space as possible such as empty lines, between `;`, etc..

Some file examples and the corresponding output when using this gem:

### Example

```groovy
// This line is amazing
a = 1;

/*
 * Foo
 */
b = 2;
```

Converts to
```groovy
a = 1;b = 2;
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'groovy_oneliner'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install groovy_oneliner

## Usage

Simplest case
```ruby
GroovyOneliner.compute(path: 'path/to/file')
```

You can also concat files
```ruby
GroovyOneliner.compute(path: ['path/to/file1', 'path/to/file2'])
```

If you want to cache reading the file (recommended for production & staging environments)

```ruby
GroovyOneliner.compute(path: 'path/to/file', cache: true)
```

You can also set the cache at class level
```ruby
GroovyOneliner.always_cache = true
GroovyOneliner.compute(path: 'path/to/file')
```

## Contributing

1. Fork it ( https://github.com/pedrocunha/groovy_oneliner/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
