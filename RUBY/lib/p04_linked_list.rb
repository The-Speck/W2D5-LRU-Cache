require "byebug"

class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    self.next.prev = @prev
    self.prev.next = @next
    
    # self.val = nil 
    # self.key = nil 
    
    # self.next = nil
    # self.prev = nil
  end
end

class LinkedList
  attr_accessor :head, :tail, :count
  
  def initialize
    @head = Node.new
    @tail = Node.new
    @count = 0
  end
  
  include Enumerable
  
  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    head
  end

  def last
    tail
  end

  def empty?
    count == 0
  end

  def get(key)
    node = head
    until node == nil
      if node.key == key
        return node.val
      else
        node = node.next
      end
    end
    nil
  end

  def include?(key)
    node = head
    until node == nil
      if node.key == key
        return true 
      else
        node = node.next
      end
    end
    false 
  end

  def append(key, val)
    new_node = Node.new(key, val)
    new_node.prev = tail
    tail.next = new_node
    
    self.head = new_node if count == 0
    self.tail = new_node
    
    self.count += 1
  end

  def update(key, val)
    node = head
    
    until node == nil
      if node.key == key
        node.val = val
        break
      else
        node = node.next
      end
    end
    
    nil
  end

  def remove(key)
    node = head
    
    until node == nil
      if node.key == key
        self.head = node.next if node == head
        node.remove
        break
      else
        node = node.next
      end
    end
    nil
  end

  def each
    node = head
    
    until node == nil
      yield node 
      node = node.next
    end
    nil
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
