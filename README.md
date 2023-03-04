# Phlex::Slots

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/phlex/slots`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'phlex-slots'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install phlex-slots

## Usage

```ruby
class Alert < Phlex::HTML
  include Phlex::Slots
  
  # Slots are defined with the slot macro
  # They can optionally have a proc that defines their default content
  slot :title, -> { default_title_for_style }
  slot :body
  
  def initialize(style: :info)
    @style = style
  end
  
  def template
    div(class: "border rounded p-6") do
      # Slot content can be accessed via the slot method, which returns a hash 
      # of slots keyed by the slot name.
      #
      # Slot attributes can be accessed by calling #attributes on the slot
      #
      # Slot content can be accessed either via #content, or by coercing the
      # slot to a proc with the &
      h1(**mix({class: "text-xl"}, slot[:title].attributes), &slot[:title])
      p(**slot[:body].attributes, &slot[:body])
    end
  end
  
  private
  
  def default_title_for_style
    case @style
    when :info then "Heads up!"
    when :error then "Uh oh!"
    else
      "Alert!"
    end
  end
end

# Slot content can be set to a string value through the initializer
Alert.new(title: "My Alert Title") do |a|
  # Or for more complex content, you can define it with a block
  # Slots set this way can also have arbitrary attributes captured
  a.body(class: "prose") do
    img(src: "hang-in-there-cat.jpg")
    plain("Don't worry, everything is going to be fine.")
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/phlex-slots.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
