class MaxIntSet
  attr_reader :max
  def initialize(max)
    @max = max
    @store = Array.new(max,false)
  end

  def insert(num)
    is_valid?(num)
    self.store[num] = true
  end

  def remove(num)
    is_valid?(num)
    self.store[num] = false 
  end

  def include?(num)
    self.store[num]
  end

  private
  def is_valid?(num)
    if num > max || num < 0 
      raise "Out of bounds"
    else 
      true
    end 
  end

  def validate!(num)
  end
  protected
  attr_accessor :store
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    index = num % num_buckets
    @store[index] << num unless include?(num)
  end

  def remove(num)
    index = num % num_buckets
    @store[index].delete(num) if include?(num)
  end

  def include?(num)
    index = num % num_buckets
    @store[index].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    index = num % num_buckets
    
    unless include?(num)
      @store[index] << num 
      @count += 1
      resize! if @count == num_buckets
    end
  end

  def remove(num)
    index = num % num_buckets
    
    if include?(num)
      @store[index].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    index = num % num_buckets
    @store[index].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_arr = Array.new(num_buckets * 2) { Array.new }
    
    @store.flatten.each do |el|
      index = el % ( num_buckets * 2 )
      new_arr[index] << el
    end
    
    @store = new_arr
  end
end
