require "minitest/autorun"
require_relative "ruby_instance_methods"

# Unit tests for `ruby_instance_methods.rb`
#
# @example Run unit tests from terminal
#   ruby test_ruby_instance_methods.rb
# @see http://docs.seattlerb.org/minitest/Minitest/Assertions.html
class TestString < Minitest::Test
  def setup
    @string = "Super Bowl-winner"
  end

  def test_to_underscore
    assert_equal "Super_Bowl_winner", @string.to_underscore
  end

  def test_to_underscore_downcase
    assert_equal "super_bowl_winner", @string.to_underscore_downcase
  end

  def test_to_symbol
    assert_equal :super_bowl_winner, @string.to_symbol
    refute_equal :"Super Bowl-winner", @string.to_symbol
  end

  def test_to_symbol_to_s
    assert_equal "super_bowl_winner", @string.to_symbol.to_s
  end

  def test_to_sym
    assert_equal :"Super Bowl-winner", @string.to_sym
    refute_equal :super_bowl_winner, @string.to_sym
  end

  def test_to_sym_to_symbol
    assert_equal :super_bowl_winner, @string.to_sym.to_symbol
  end

  def test_to_symbol_to_sym
    assert_equal :super_bowl_winner, @string.to_symbol.to_sym
  end
end

class TestSymbol < Minitest::Test
  def setup
    @sym = :"Super Bowl-winner"
    @symbol = :super_bowl_winner
  end

  def test_to_underscore_downcase
    assert_equal "super_bowl_winner", @sym.to_underscore_downcase
    assert_equal "super_bowl_winner", @symbol.to_underscore_downcase
  end

  def test_to_symbol
    assert_equal @symbol, @sym.to_symbol
    refute_equal @sym, @sym.to_symbol
    assert_equal @symbol, @symbol.to_symbol
    refute_equal @sym, @symbol.to_symbol
  end

  def test_to_symbol_to_s
    assert_equal "super_bowl_winner", @sym.to_symbol.to_s
    refute_equal "Super Bowl-winner", @sym.to_symbol.to_s
    assert_equal "super_bowl_winner", @symbol.to_symbol.to_s
    refute_equal "Super Bowl-winner", @symbol.to_symbol.to_s
  end

  def test_to_symbol_to_sym
    assert_equal @symbol, @sym.to_symbol.to_sym
    refute_equal @sym, @sym.to_symbol.to_sym
    assert_equal @symbol, @symbol.to_symbol.to_sym
    refute_equal @sym, @symbol.to_symbol.to_sym
  end
end

class TestObject < Minitest::Test
  def setup
    @hash = {
      "Effective Date" => "4/8/2016",
      "Amount" => "20.00",
      "Recursive-Item" => {
        "one two" => [1,2],
        "Boolean-here" => true
      }
    }
  end

  def test_keys_to_sym
    expected = {
      :"Effective Date" => "4/8/2016",
      :Amount => "20.00",
      :"Recursive-Item" => {
        :"one two" => [1, 2],
        :"Boolean-here" => true
      }
    }
    assert_equal expected, @hash.keys_to_sym

    expected = {:a => "a", :b => "b"}
    assert_equal expected, {'a' => 'a', 'b' => 'b'}.keys_to_sym
    expected = [{}]
    assert_equal expected, [{}].keys_to_sym
    expected = {:a => "a", :b => {:c => "c", :d => "d"}}
    assert_equal expected, { 'a' => 'a', 'b' => {'c' => 'c', 'd' => 'd'} }.keys_to_sym
    expected = [{:a => "a", :b => "b"}]
    assert_equal expected, [{'a' => 'a', 'b' => 'b'}].keys_to_sym
    expected = [{:a => "a", :b => {:c => "c", :d => "d"}}]
    assert_equal expected, [{ 'a' => 'a', 'b' => {'c' => 'c', :d => 'd'} }].keys_to_sym
    expected = [{:a => ["a1", "a2"], :b => {:c => "c", :d => "d"}}]
    assert_equal expected, [{ 'a' => ['a1','a2'], 'b' => {'c' => 'c', :d => 'd'} }].keys_to_sym
    expected = [{:a => ["a1", "a2"], :b => [{:c => "c", :d => "d"}]}]
    assert_equal expected, [{ 'a' => ['a1','a2'], 'b' => [{'c' => 'c', :d => 'd'}] }].keys_to_sym
    expected = [{:a => ["a1", "a2"], :b => [{:c => ["c1", "c2"], :d => "d"}]}]
    assert_equal expected, [{ 'a' => ['a1','a2'], 'b' => [{'c' => ['c1','c2'], :d => 'd'}] }].keys_to_sym
    expected = [{:a => ["a1", "a2"], :b => [{:c => ["c1", "c2"], :d => {}}]}]
    assert_equal expected, [{ 'a' => ['a1','a2'], 'b' => [{'c' => ['c1','c2'], :d => {}}] }].keys_to_sym
    expected = [{:a => ["a1", "a2"], :b => [{:c => ["c1", "c2"], :d => [{}]}]}]
    assert_equal expected, [{ 'a' => ['a1','a2'], 'b' => [{'c' => ['c1','c2'], :d => [{}]}] }].keys_to_sym
    expected = [{:a => ["a1", "a2"], :b => [{:c => ["c1", "c2"], :d => nil}]}]
    assert_equal expected, [{ 'a' => ['a1','a2'], 'b' => [{'c' => ['c1','c2'], :d => nil }] }].keys_to_sym
  end

  def test_keys_to_sym!
    hash_copy = @hash.dup
    assert_equal hash_copy, @hash
    hash_copy.keys_to_sym!
    assert_equal hash_copy, @hash.keys_to_sym
    refute_equal hash_copy, @hash
  end

  def test_keys_to_symbol
    expected = {
      :effective_date => "4/8/2016",
      :amount => "20.00",
      :recursive_item => {
        :one_two => [1, 2],
        :boolean_here => true
      }
    }
    assert_equal expected, @hash.keys_to_symbol

    expected = {:a => "a", :b => "b"}
    assert_equal expected, {'a' => 'a', 'b' => 'b'}.keys_to_symbol
    expected = [{}]
    assert_equal expected, [{}].keys_to_symbol
    expected = {:a => "a", :b => {:c => "c", :d => "d"}}
    assert_equal expected, { 'a' => 'a', 'b' => {'c' => 'c', 'd' => 'd'} }.keys_to_symbol
    expected = [{:a => "a", :b => "b"}]
    assert_equal expected, [{'a' => 'a', 'b' => 'b'}].keys_to_symbol
    expected = [{:a => "a", :b => {:c => "c", :d => "d"}}]
    assert_equal expected, [{'a' => 'a', 'b' => {'c' => 'c', :d => 'd'}}].keys_to_symbol
    expected = [{:a => ["a1", "a2"], :b => {:c => "c", :d => "d"}}]
    assert_equal expected, [{'a' => ['a1','a2'], 'b' => {'c' => 'c', :d => 'd'}}].keys_to_symbol
    expected = [{:a => ["a1", "a2"], :b => [{:c => "c", :d => "d"}]}]
    assert_equal expected, [{'a' => ['a1','a2'], 'b' => [{'c' => 'c', :d => 'd'}]}].keys_to_symbol
    expected = [{:a => ["a1", "a2"], :b => [{:c => ["c1", "c2"], :d => "d"}]}]
    assert_equal expected, [{'a' => ['a1','a2'], 'b' => [{'c' => ['c1','c2'], :d => 'd'}]}].keys_to_symbol
    expected = [{:a => ["a1", "a2"], :b => [{:c => ["c1", "c2"], :d => {}}]}]
    assert_equal expected, [{'a' => ['a1','a2'], 'b' => [{'c' => ['c1','c2'], :d => {}}]}].keys_to_symbol
    expected = [{:a => ["a1", "a2"], :b => [{:c => ["c1", "c2"], :d => [{}]}]}]
    assert_equal expected, [{'a' => ['a1','a2'], 'b' => [{'c' => ['c1','c2'], :d => [{}]}]}].keys_to_symbol
    expected = [{:a => ["a1", "a2"], :b => [{:c => ["c1", "c2"], :d => nil}]}]
    assert_equal expected, [{'a' => ['a1','a2'], 'b' => [{'c' => ['c1','c2'], :d => nil }]}].keys_to_symbol
  end

  def test_keys_to_symbol!
    hash_copy = @hash.dup
    assert_equal hash_copy, @hash
    hash_copy.keys_to_symbol!
    assert_equal hash_copy, @hash.keys_to_symbol
    refute_equal hash_copy, @hash
  end

  def test_keys_to_symbol_recursive
    expected = [
      {:effective_date => "4/8/2016", :amount => "20.00", :recursive_item => {:one_two => [1, 2], :boolean_here => true}},
      {:effective_date => "4/8/2016", :amount => "20.00", :recursive_item => {:one_two => [1, 2], :boolean_here => true}}
    ]
    assert_equal expected, [@hash, @hash].keys_to_symbol
  end

  def test_keys_to_string
    expected = {
      "effective_date" => "4/8/2016",
      "amount" => "20.00",
      "recursive_item" => {
        "one_two" => [1, 2],
        "boolean_here" => true
      }
    }
    assert_equal expected, @hash.keys_to_string

    expected = {"a" => "a", "b" => "b"}
    assert_equal expected, {:a => 'a', :b => 'b'}.keys_to_string
    expected = [{}]
    assert_equal expected, [{}].keys_to_string
    expected = {"a" => "a", "b" => {"c" => "c", "d" => "d"}}
    assert_equal expected, { :a => 'a', :b => {'c' => 'c', 'd' => 'd'} }.keys_to_string
    expected = [{"a" => "a", "b" => "b"}]
    assert_equal expected, [{:a => 'a', :b => 'b'}].keys_to_string
    expected = [{"a" => "a", "b" => {"c" => "c", "d" => "d"}}]
    assert_equal expected, [{:a => 'a', :b => {'c' => 'c', :d => 'd'}}].keys_to_string
    expected = [{"a" => ["a1", "a2"], "b" => {"c" => "c", "d" => "d"}}]
    assert_equal expected, [{:a => ['a1','a2'], :b => {'c' => 'c', :d => 'd'}}].keys_to_string
    expected = [{"a" => ["a1", "a2"], "b" => [{"c" => "c", "d" => "d"}]}]
    assert_equal expected, [{:a => ['a1','a2'], :b => [{'c' => 'c', :d => 'd'}]}].keys_to_string
    expected = [{"a" => ["a1", "a2"], "b" => [{"c" => ["c1", "c2"], "d" => "d"}]}]
    assert_equal expected, [{:a => ['a1','a2'], :b => [{'c' => ['c1','c2'], :d => 'd'}]}].keys_to_string
    expected = [{"a" => ["a1", "a2"], "b" => [{"c" => ["c1", "c2"], "d" => {}}]}]
    assert_equal expected, [{:a => ['a1','a2'], :b => [{'c' => ['c1','c2'], :d => {}}]}].keys_to_string
    expected = [{"a" => ["a1", "a2"], "b" => [{"c" => ["c1", "c2"], "d" => [{}]}]}]
    assert_equal expected, [{:a => ['a1','a2'], :b => [{'c' => ['c1','c2'], :d => [{}]}]}].keys_to_string
    expected = [{"a" => ["a1", "a2"], "b" => [{"c" => ["c1", "c2"], "d" => nil}]}]
    assert_equal expected, [{:a => ['a1','a2'], :b => [{'c' => ['c1','c2'], :d => nil }]}].keys_to_string
  end

  def test_keys_to_string!
    hash_copy = @hash.dup
    assert_equal hash_copy, @hash
    hash_copy.keys_to_string!
    assert_equal hash_copy, @hash.keys_to_string
    refute_equal hash_copy, @hash
  end

  def test_keys_to_string_recursive
    expected = [
      {"effective_date" => "4/8/2016", "amount" => "20.00", "recursive_item" => {"one_two" => [1, 2], "boolean_here" => true}},
      {"effective_date" => "4/8/2016", "amount" => "20.00", "recursive_item" => {"one_two" => [1, 2], "boolean_here" => true}}
    ]
    assert_equal expected, [@hash, @hash].keys_to_string
  end
end
