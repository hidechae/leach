[![Build Status](https://travis-ci.org/hidechae/leach.svg?branch=master)](https://travis-ci.org/hidechae/leach)

# Leach

Validate and filter parameters.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'leach', github: 'hidechae/leach'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install leach

## Usage

You can define validations with type to cast.

```ruby
Leach.filter(parameters) do
  requires :key1, type: Integer
  requires :key2, type: String
  requires :key3, type: Symbol
  requires :key4, type: Date
  optional :key5, type: Time
end
```

You can define validations recursively.

```ruby
# array of integer values
Leach.filter(parameters) do
  requires :key1, type: Array do
    requires type: Integer
  end
end

# hash
Leach.filter(parameters) do
  requires :key1, type: Hash do
    requires :key11, type: Integer
    requires :key12, type: String
  end
end

# array of hash
Leach.filter(parameters) do
  requires :key1, type: Array do
    requires type: Hash do
      requires :key11, type: Integer
      requires :key12, type: String
    end
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/leach.

