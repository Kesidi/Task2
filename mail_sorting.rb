class MailSorting
  def initialize
    @posts = []
  end
  def add_post(new_post)
    @posts << new_post
  end
  #the number of parcels sent to some city
  def num_parcels_sent_to_city(city)
    count = 0
    @posts.each {|x| count +=1 if x.city == city}
    return count
  end
  #how many parcels with value higher than 10 were sent
  def parcels_value_more10
    count = 0
    @posts.each {|x| count +=1 if x.value > 10}
    return count
  end
  #what is the most popular address
  def popular_address
    adresses = Hash.new(0)
    @posts.each {|x| adresses["#{x.city} #{x.street} #{x.house} #{x.apartment}"] += 1 }
    adresses.max_by {|key,val| val}.first
  end
  def print
    @posts.each {|x| puts x}
  end
end
class Post
  attr_accessor :city, :street, :house, :apartment, :destination, :value
  def initialize(city, street, house, apartment, destination, value)
    @city, @street, @house, @apartment, @destination, @value = city, street, house, apartment, destination, value
  end
  def to_s
    "Post #{city}, #{street}, #{house}, #{apartment}, #{destination}, #{value}"
  end
end

mail_sorting = MailSorting.new
mail_sorting.add_post(Post.new("Dnepr","street","17","145","Jeck",5))
mail_sorting.add_post(Post.new("Dnepr","street","18","145","John",15))
mail_sorting.add_post(Post.new("Dnepr","street","11","145","John",25))
mail_sorting.add_post(Post.new("Dnepr","street","17","145","John",9))
mail_sorting.add_post(Post.new("Dnepr","street","17","145","John",2))
mail_sorting.add_post(Post.new("Dnepr","street","17","145","John",1))
mail_sorting.print
puts mail_sorting.num_parcels_sent_to_city("Dnepr")
puts mail_sorting.parcels_value_more10
puts mail_sorting.popular_address
