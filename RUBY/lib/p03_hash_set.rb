class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    unless include?(key)    
      @store[index(key)] << key 
      @count += 1
      resize! if count == num_buckets
    end
  end

  def include?(key)
    @store[index(key)].include?(key)
  end

  def remove(key)
    if include?(key)
      @store[index(key)].delete(key)
      @count -= 1
    end 
  end

  private
  
  def index(key)
    index = key.hash % num_buckets
  end

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    array = Array.new(num_buckets * 2) { Array.new }
    
    @store.flatten.each do |el|
      resize_idx = el.hash % array.length
      array[resize_idx] << el
    end 
    @store = array
  end
end
