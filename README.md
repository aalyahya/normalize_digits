# NormalizeDigits

[![Gem Version](https://badge.fury.io/rb/normalize_digits.svg)](https://badge.fury.io/rb/normalize_digits)

NormalizeDigits is a lightweight ActiveModel extension that automatically converts non-English digits (like Arabic,
Persian, etc.) to standard English digits (`0-9`) before validation. This is useful for applications where users might
input localized numerals, and consistent numeric formatting is required.

## Features

- Automatically normalizes any non-English digits to ASCII numerals.
- Integrates seamlessly with ActiveModel or ActiveRecord attributes.
- Useful for form inputs, APIs, and user-generated content.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'normalize_digits'
```

And then execute:

```shell
bundle install
```

Or install it yourself as:

```shell
gem install normalize_digits
```

## Usage

Simply include the concern in your model and specify which attributes you want to normalize:

```ruby

class User < ApplicationRecord
  include NormalizeDigits

  normalize_digits
  # normalize_digits only: [:username]
  # normalize_digits except: [:username]
end
```

Before validation, any non-English digits in the specified fields will be converted to standard 0-9.

### Example

```ruby
user = User.new(phone_number: "٠٥٠١٢٣٤٥٦٧")
user.valid?
user.phone_number
# => "0501234567"
```

### Supported Digit Sets

The gem currently supports:
• Arabic-Indic digits: `٠١٢٣٤٥٦٧٨٩`
• Eastern Arabic digits: `۰۱۲۳۴۵۶۷۸۹`
• Can be extended easily via the matchers.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/your-username/normalize_digits.
1. Fork the repo
2. Create your feature branch (git checkout -b feature/awesome)
3. Commit your changes (git commit -am 'Add awesome feature')
4. Push to the branch (git push origin feature/awesome)
5. Create a new Pull Request

## License

The gem is available as open source under the terms of the MIT License.
