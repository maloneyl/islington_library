# IslingtonLibrary

This gem helps you search the Islington Library's catalogue for a book by the given author and title.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'islington_library'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install islington_library

## Usage

```
$ bin/console
irb(main):002:0> result = IslingtonLibrary.search(title: "21 Lessons for the 21st Century", author: "Yuval Noah Harari")
=> #<IslingtonLibrary::SearchResult:0x00007ff95dbd8950 @book=#<IslingtonLibrary::Book:0x00007ff95dbd89f0 @title="21 lessons for the 21st century", @author="Harari, Yuval N., author.", @year="2018", @link="http://capitadiscovery.co.uk/islington/items/885834", @isbn="1787330672">>
irb(main):003:0> result.book
=> #<IslingtonLibrary::Book:0x00007ff95e120a98 @title="21 lessons for the 21st century", @author="Harari, Yuval N., author.", @year="2018", @link="http://capitadiscovery.co.uk/islington/items/885834", @isbn="1787330672">
irb(main):004:0> result.book.link
=> "http://capitadiscovery.co.uk/islington/items/885834"

# Only book items are returned; non-book items such as DVDs are excluded
irb(main):005:0> IslingtonLibrary.search(title: "Gone Girl", author: "Gillian Flynn")
=> #<IslingtonLibrary::SearchResult:0x00007ff95db03ac0 @book=#<IslingtonLibrary::Book:0x00007ff95db03b88 @title="Gone girl", @author="Flynn, Gillian, 1971- author.", @year="2014", @link="http://capitadiscovery.co.uk/islington/items/831097", @isbn="1780228228">>
irb(main):006:0> IslingtonLibrary.search(title: "The Martian", author: "Andy Weir")
=> #<IslingtonLibrary::SearchResult:0x00007ff95dc26f88 @book=#<IslingtonLibrary::Book:0x00007ff95dc26fd8 @title="The Martian", @author="Weir, Andy, author.", @year="2015", @link="http://capitadiscovery.co.uk/islington/items/872958", @isbn="1785031139">>

# Different subtitles (due to different editions) of the same book are considered
irb(main):007:0> IslingtonLibrary.search(title: "Testosterone Rex: Myths of Sex, Science, and Society", author: "Cordelia Fine")
=> #<IslingtonLibrary::SearchResult:0x00007ff95dbcb3b8 @book=#<IslingtonLibrary::Book:0x00007ff95dbcb408 @title="Testosterone Rex: unmaking the myths of our gendered minds", @author="Fine, Cordelia, author.", @year="2018", @link="http://capitadiscovery.co.uk/islington/items/880059", @isbn="1785783181">>
irb(main):008:0> IslingtonLibrary.search(title: "Testosterone Rex: Unmaking the Myths of Our Gendered Minds", author: "Cordelia Fine")
=> #<IslingtonLibrary::SearchResult:0x00007ff95dad59b8 @book=#<IslingtonLibrary::Book:0x00007ff95dad5a30 @title="Testosterone Rex: unmaking the myths of our gendered minds", @author="Fine, Cordelia, author.", @year="2018", @link="http://capitadiscovery.co.uk/islington/items/880059", @isbn="1785783181">>

# No results
irb(main):009:0> IslingtonLibrary.search(title: "Some Book That Doesn't Exist", author: "Maloney Baloney")
=> #<IslingtonLibrary::SearchResult:0x00007ff95d943780 @book=nil>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/maloneyl/islington_library.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
