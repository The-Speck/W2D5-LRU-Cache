require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      update_node!(key)
    else
      value = @prc.call(key)
      calc!(key, value)
    end
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key, value)
    # suggested helper method; insert an (un-cached) key
    # eject! if count >= @max
      
    @map.set(key, value)
    @store.append(key, value)
  end

  def update_node!(key)
    value = @store.get(key)
    @store.remove(key)
    
    @store.append(key, value)
  end

  def eject!
    # delete @map.delete(key)
  end
end
