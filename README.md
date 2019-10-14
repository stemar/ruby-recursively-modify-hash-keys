# Ruby recursively modify hash keys

`module RubyInstanceMethods` contains instance methods that are included in String, Symbol and Object classes in Ruby core.

The String and Symbol instance methods help the Object methods to recursively modify keys in a Ruby Hash.

- `Object::keys_to_sym`
- `Object::keys_to_symbol`
- `Object::keys_to_string`

Each of them have a self-modifying bang method.

## Installation

```bash
gem install minitest
git clone https://github.com/stemar/ruby-recursively-modify-hash-keys.git
cd ruby-recursively-modify-hash-keys
ruby test_ruby_instance_methods.rb
```

## Usage

Require this library in a top class so that it's available everywhere in your code.

```ruby
require_relative "ruby_instance_methods"
```

## Examples

Try:

```ruby
@hash = {
  "Effective Date" => "4/8/2016",
  "Amount" => "20.00",
  "Recursive-Item" => {
    "one two" => [1,2],
    "Boolean-here" => true
  }
}
hash_with_symbolized_keys = @hash.keys_to_symbol
```

Result:

```ruby
hash_with_symbolized_keys = {
  :effective_date => "4/8/2016",
  :amount => "20.00",
  :recursive_item => {
    :one_two => [1, 2],
    :boolean_here => true
  }
}
```

Try:

```ruby
@hash.keys_to_symbol!
```

Result:

```ruby
@hash = {
  :effective_date => "4/8/2016",
  :amount => "20.00",
  :recursive_item => {
    :one_two => [1, 2],
    :boolean_here => true
  }
}
```

Try:

```ruby
@hash.keys_to_string!
```

Result:

```ruby
@hash = {
  "effective_date" => "4/8/2016",
  "amount" => "20.00",
  "recursive_item" => {
    "one_two" => [1, 2],
    "boolean_here" => true
  }
}
```
