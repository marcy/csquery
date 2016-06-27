# Csquery

[![Build Status](https://travis-ci.org/marcy/csquery.svg?branch=master)](https://travis-ci.org/marcy/csquery)

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/csquery`. To experiment with that code, run `bin/console` for an interactive prompt.

A simple query builder for Amazon Cloudsearch Structured query parser for ruby.
see: https://github.com/tell-k/csquery

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'csquery'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install csquery

## Usage

```ruby
Csquery::Structured.and_(
    Csquery::Structured.not_('test', field:'genres'),
    Csquery::Structured.or_(
        Csquery::Structured.term_('star', field:'title', boost:2),
        Csquery::Structured.term_('star', field:'plot')
    )
).query
# => "(and (not field=genres 'test') (or (term field=title boost=2 'star') (term field=plot 'star')))"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/csquery. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.
