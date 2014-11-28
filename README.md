# GroovyOneliner

This gem allows you to convert a groovy script file to a single line script. Currently it is being used in a production environment to
convert sane commented and formatted scripts to oneline scripts which will be injected in Elastic Search queries.

### Example 1

```groovy
// This line is amazing
return 1;
```

Converts to
```groovy
return 1;
```

### Example 2

```groovy
a = 3;
return a + 5;
```

Converts to:
```groovy
a = 3; return a + 5;
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

```
GroovyOneliner.compute(file: 'path/to/file')
```

If you want to cache reading the file (recommended for production & staging environments)

```
GroovyOneliner.compute(file: 'path/to/file', cache: true)
```

## Contributing

1. Fork it ( https://github.com/pedrocunha/groovy_oneliner/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
