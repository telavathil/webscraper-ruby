require 'nokogiri'
#require_relative './post.html'

class Post


  attr_accessor :doc, :title, :url, :points, :item_id

  def initialize
    self.doc = Nokogiri::HTML(File.open('./post.html'))
    self.title = self.doc.css('span.score').map {|span| span.inner_text}
    self.url = 'https://news.ycombinator.com/item?id=7663775'
    self.points = self.doc.css('span.score').map {|span| span.inner_text}
    self.item_id = self.url.split('?id=')[1]

  end


  def comments
  end

  def add_comment(comment)
  end
end

p = Post.new
puts p
