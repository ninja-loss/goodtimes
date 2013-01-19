# Goodtimes

Tools for formatting date and time, including an Activerecord extension.


## Installation

Add this line to your application's Gemfile:

    gem 'goodtimes'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install goodtimes


## Usage

Define some date_time_formats:

config/initializers/date_time_formats.rb

```ruby
{
  :isdn                          => "%Y-%m-%d",
  :isdn_with_time                => "%Y-%m-%d %I:%M %p"
}.each do |name, pattern|
  Date::DATE_FORMATS.merge!( name => pattern )
  Time::DATE_FORMATS.merge!( name => pattern )
end

{
  :default  => "%m/%d/%Y",
  :db       => "%Y-%m-%d"
}.each do |name, pattern|
  Date::DATE_FORMATS.merge!( name => pattern )
end

{
  :default                 => "%m/%d/%Y %R %Z",
  :db                      => "%Y-%m-%d %H:%M:%S"
}.each do |name, pattern|
  Time::DATE_FORMATS.merge!( name => pattern )
end
```

Now when you call #to_s on an ActiveRecord instance you will get the
default format output:

```ruby
person = Person.new( :date_of_birth => '1999-01-01' )
person.date_of_birth #=> 01/01/1999
```

However, the converse is not true.  If you try to set #date_of_birth
with the default format, you will get an 'invalid date' exception (if it
is not a date that Date can already parse).

```ruby
person.date_of_birth = '1/1/1999' #=> invalid date
```

In order to fix this:

```ruby
class Person

  date_attr_writer :date_of_birth

end

person = Person.new( :date_of_birth => '1/1/1999' )
person.date_of_birth #=> 01/01/1999
```

When date_attr_writer is called with no options, it tries to use the
default date format defined for your Rails application:
Date::DATE_FORMATS[:default].

You can also specify a format to use in multiple ways.  You can provide
a symbol and goodtimes will look for a format in Date::DATE_FORMATS that
matches.

```ruby
date_attr_writer :date_of_birth, :format => :isdn
```

Additionally you can give the :format option a string and goodtimes will
use it as the format.

```ruby
date_attr_writer :date_of_birth, :format => '%m-%d-%Y'
date_attr_writer :date_of_birth, :format => Date::DATE_FORMATS[:isdn]
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
