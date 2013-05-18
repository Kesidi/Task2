class BookOrder
  attr_accessor :name, :book, :order_date, :issue_date
  def initialize(name, book, issue_date = nil, order_date = Time.now)
    @name = name
    @book = book
    @order_date = order_date
    @issue_date = issue_date
  end
  def order_time
    if @issue_date
      @issue_date - @order_date
    else
      nil
    end
  end
  def to_s
    "Name #{@name} Book #{book} order #{@order_date} issue #{@issue_date}"
  end
end
class Library
  attr_accessor :book_orders
  def initialize
    @book_orders = []
  end
  def add_book_order(new_book_order)
    @book_orders << new_book_order
  end
  def print
    puts "Orders"
    @book_orders.each {|x| puts x}
  end
  # the smallest period for which library found a book 
  def smallest_period
    min = 301 
    @book_orders.each {|x| min = x.order_time if x.order_time != nil}
    @book_orders.each {|x| min = x.order_time if (x.order_time != nil and  min > x.order_time)}
    #return Time.at(min).getgm.strftime("%H:%M:%S")
    #min = @book_orders.min_by {|x| x.order_time}
    #min.order_time
    if (min == 301) 
      "No complete orders"
    else
      Time.at(min).getgm.strftime("%H:%M:%S")
    end
  end
  # how many orders were not satisfied
  def count_uncomplete_orders
    count = 0
    @book_orders.each {|x| count+=1 if (x.issue_date == nil) }
    return count 
  end
  # who often takes the book
  def often_take_book(book)
    readers = Hash.new(0)
    @book_orders.each {|x| readers[x.name] += 1 if book == x.book}
    reader = readers.max_by {|key, value| value}.first
  end
  #  what is the most popular book
  def most_popular_book
    books = Hash.new(0)
    @book_orders.each {|x| books[x.book] += 1}
    popular_book = books.max_by {|key,value| value}.first
  end
  # how many people ordered one of the three most popular books.
  def count_people_ordered_most_popular_books
    books = Hash.new(0)
    @book_orders.each {|x| books[x.book] += 1}
    books = books.sort_by {|k,v| v}.reverse
    index_book = rand(2)
    books[index_book].first
    people = Hash.new(0)
    count = 0
    @book_orders.each {|x|  count += 1 if x.book == books[index_book].first}
    "count people ordered #{books[index_book].first} - #{count}"
  end
end

library = Library.new
book_order1 = BookOrder.new("Vasya", "book1",Time.now+rand(300))
book_order2 = BookOrder.new("Jax", "book2", Time.now+rand(300))
library.add_book_order(book_order1)
library.add_book_order(book_order2)
library.add_book_order(BookOrder.new("James", "book3"))
library.add_book_order(BookOrder.new("John", "book3"))
library.add_book_order(BookOrder.new("John", "book3", Time.now+rand(300)))
library.add_book_order(BookOrder.new("John", "book3",Time.now+rand(300)))
library.print
puts library.smallest_period
puts " count uncomplete orders - "+library.count_uncomplete_orders.to_s
puts library.most_popular_book
puts library.often_take_book("book3")
puts library.count_people_ordered_most_popular_books