require 'test/unit'
require 'prime'
require 'stringio'

class TestPrime < Test::Unit::TestCase
  # The first 100 prime numbers
  PRIMES = [
    2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37,
    41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 
    89, 97, 101, 103, 107, 109, 113, 127, 131, 
    137, 139, 149, 151, 157, 163, 167, 173, 179, 
    181, 191, 193, 197, 199, 211, 223, 227, 229, 
    233, 239, 241, 251, 257, 263, 269, 271, 277, 
    281, 283, 293, 307, 311, 313, 317, 331, 337, 
    347, 349, 353, 359, 367, 373, 379, 383, 389, 
    397, 401, 409, 419, 421, 431, 433, 439, 443, 
    449, 457, 461, 463, 467, 479, 487, 491, 499, 
    503, 509, 521, 523, 541,
  ]
  def test_each
    primes = []
    Prime.each do |p|
      break if p > 541
      primes << p
    end
    assert_equal PRIMES, primes
  end

  def test_each_by_prime_number_theorem
    3.upto(15) do |i|
      max = 2**i
      primes = []
      Prime.each do |p|
        break if p >= max
        primes << p
      end

      # Prime number theorem
      assert primes.length >= max/Math.log(max)  
      delta = 0.05
      li = (2..max).step(delta).inject(0){|sum,x| sum + delta/Math.log(x)}
      assert primes.length <= li
    end
  end

  def test_each_without_block
    enum = Prime.each
    assert enum.respond_to?(:each)
    assert enum.kind_of?(Enumerable)
    assert enum.respond_to?(:with_index)
    assert enum.respond_to?(:next)
    assert enum.respond_to?(:succ)
    assert enum.respond_to?(:rewind)
  end

  def test_new
    buf = StringIO.new('', 'w')
    orig, $stderr = $stderr, buf

    enum = Prime.new
    assert !buf.string.empty?
    $stderr = orig

    assert enum.respond_to?(:each)
    assert enum.kind_of?(Enumerable)
    assert enum.respond_to?(:succ)

    assert Prime === enum
  ensure
    $stderr = orig
  end

  def test_enumerator_succ
    enum = Prime.each
    assert_equal PRIMES[0, 50], 50.times.map{ enum.succ }
    assert_equal PRIMES[50, 50], 50.times.map{ enum.succ }
    enum.rewind
    assert_equal PRIMES[0, 100], 100.times.map{ enum.succ }
  end

  def test_enumerator_with_index
    enum = Prime.each
    last = -1
    enum.with_index do |p,i|
      break if i >= 100
      assert_equal last+1, i
      assert_equal PRIMES[i], p
      last = i
    end
  end

  class TestInteger < Test::Unit::TestCase
    def test_prime_division
      pd = PRIMES.inject(&:*).prime_division
      assert_equal PRIMES.map{|p| [p, 1]}, pd
    end

    def test_from_prime_division
      assert_equal PRIMES.inject(&:*), Integer.from_prime_division(PRIMES.map{|p| [p,1]})
    end

    def test_prime?
      # small primes
      assert 2.prime?
      assert 3.prime?

      # squared prime
      assert !4.prime?
      assert !9.prime?

      # mersenne numbers
      assert (2**31-1).prime?
      assert !(2**32-1).prime?

      # fermat numbers
      assert (2**(2**4)+1).prime?
      assert !(2**(2**5)+1).prime? # Euler!

      # large composite
      assert !((2**13-1) * (2**17-1)).prime?

      # factorial
      assert !(2...100).inject(&:*).prime?
    end
  end
end
