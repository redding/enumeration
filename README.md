# Enumeration

Add enumerated value attributes to your ruby classes.

## Usage

```ruby
require 'enumeration'

class Thing
  include Enumeration

  # list enumeration
  enum :word, %w{aye bee see}

  # map enumeration
  enum :stuff, {
    :a => "aye",
    :b => "bee",
    :c => "see"
  }
end

# get the enum sets
Thing.word_set      # => ['aye', 'bee', 'see']
Thing.stuff_set     # => [:a, :b, :c]

# lookup mapped enum values
Thing.stuff(:a)     # => "aye"


t = Thing.new

# write list enum values
t.word              # => nil
t.word = "aye"
t.word              # => "aye"
t.word_key          # => "aye" (a list's 'keys' are it's values, vice-versa)
t.word = "dee"
t.word              # => nil  (won't write non enum values)
t.word_key          # => nil

# write mapped enum value
t.stuff             # => nil
t.stuff = :b        #    (write using key)
t.stuff             # => "bee"
t.stuff_key         # => :b
t.stuff = "see"     #    (write using value)
t.stuff             # => "see"
t.stuff_key         # => :c
t.stuff = :d
t.stuff             # => nil (won't write non enum keys)
t.stuff_key         # => nil
t.stuff = "dee"
t.stuff             # => nil (won't write non enum values)
t.stuff_key         # => nil
```

## Installation

Add this line to your application's Gemfile:

    gem 'enumeration'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install enumeration

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
