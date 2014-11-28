# GroovyOneliner

This gem allows you to convert any groovy script file to a single line script. It is recommended (and also in order for this gem to work) that all lines must be terminated with `;`.

Currently it is being used in a production environment to convert sane commented and formatted groovy scripts to oneline scripts which will be injected in ElasticSearch queries.

This gem won't do for you:
- Check if there is any syntax errors
- Check if you hate semi-colons

Some file examples and the corresponding output when using this gem

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

### Example 3
```groovy
/*
 * Foo
 */
a = 3;
```

Converts to:
```groovy
a = 3;
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
