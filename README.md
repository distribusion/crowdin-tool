# Crowdin::Tool

Crowdin-Tool provides a command line tool that implements convenient git branch conventions for crowdin-cli commands. It helps by aligning your
crowdin branch names with the current git branch name, and operating on the master translation branch when on the master branch.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'crowdin-tool'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install crowdin-tool

## Usage

From your git topic branch that needs to be added to the Crowdin translation platform call
```translation init```

This will execute the crowdin-cli commands to initialize a new translation version branch with your current git branch name, and upload the keys and initialize the locales.

Calling
```translation upload```
will synchronize the translations in the Crowdin version branch with your working repo.

Finally calling
```translation download```
will export translations from the Crowdin version branch to your local repo.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment. Run `bundle exec crowdin-tool` to use the code located in this directory, ignoring other installed copies of this gem.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/crowdin-tool/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
