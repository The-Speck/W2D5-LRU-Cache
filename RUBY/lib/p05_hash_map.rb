require_relative 'p04_linked_list'

class HashMap
  attr_reader :count
  
  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    self.store[bucket(key)].include?(key)
  end

  def set(key, val)
    if self.store[bucket(key)].include?(key)
      self.store[bucket(key)].update(key, val)
    else
      self.store[bucket(key)].append(key, val)
      @count += 1
      resize! if count == num_buckets
    end
  end

  def get(key)
    self.store[bucket(key)].get(key)
  end

  def delete(key)
    if self.store[bucket(key)].include?(key)
      self.store[bucket(key)].remove(key)
      @count -= 1
    end
  end

  def each(&prc)
    @store.each do |list|
      unless list.empty?
        list.each do |node|
          prc.call(node.key, node.val)
        end
      end
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private
  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets*2) { LinkedList.new }
    
    self.each do |k, v|
      new_store[k.hash % (num_buckets * 2)].append(k,v)
      
    end
    @store = new_store 
  end

  def bucket(key)
    key.hash % num_buckets
  end
  protected 
  attr_accessor :store
end
