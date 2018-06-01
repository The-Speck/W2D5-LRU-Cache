class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    acc = 1
    self.each_with_index do |el, idx|
      if idx.even?
        acc *= el
      else 
        acc += el
      end 
    end 
    acc 
  end
end

class String
  def hash
    arr = self.unpack('C*')
    arr.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    str = self.to_a.flatten.map(&:to_s)
    hash_value = 1
    str.each do |let|
      hash_value *= let.ord
    end
    hash_value
  end
end
