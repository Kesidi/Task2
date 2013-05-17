class BookOrder
	attr_accessor :name, :order_date, :issue_date
	def initialize(name, issue_date = nil, order_date = Time.now)
		@name = name
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
	def print
		puts "Name "+@name.to_s+" order "+@order_date.to_s+" issue "+@issue_date.to_s
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
		@book_orders.each {|x| x.print}
	end
	def smallest_period
		min = @book_orders.min_by {|x| x.order_time}
		min.order_time
	end
end

library = Library.new
book_order1 = BookOrder.new("Vasya", Time.now+rand(300))
book_order2 = BookOrder.new("Jax", Time.now+rand(300))
library.add_book_order(book_order1)
library.add_book_order(book_order2)
library.add_book_order(BookOrder.new("James"))
library.print
puts library.smallest_period