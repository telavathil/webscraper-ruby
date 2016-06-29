require 'nokogiri'
#require_relative './post.html'

class Post



  attr_accessor :title, :url, :points, :item_id, :comments

  def initialize
    self.doc = Nokogiri::HTML(File.open('./post.html'))
    self.title = self.doc.css('span.score').map {|span| span.inner_text}
    self.url = 'https://news.ycombinator.com/item?id=7663775'
    self.points = self.doc.css('span.score').map {|span| span.inner_text}
    self.item_id = self.url.split('?id=')[1]
    self.comments = []
  end

  #Post#comments returns all the comments associated with a particular post.
  def comments

    #loop over all the comments
    #store the parent_id and last id on each iteration
    parent_id = 0
    last_id = 0
    comment_list = doc.css('tr.athing.comtr').each {|tr|
      #create a new comment
      c = Comment.new
      #get id
      c.id,last_id = tr['id']
      #get authour
      c.authour = tr.css('a.hnuser')map {|link| link.inner_text}
      #get days_ago
      c.days_ago = tr.css('span.age > a')map {|link| link.inner_text}
      #get text
      c.text = tr.css('span.comment').text

      #create parent_id

      #add comment to the comment list
      add_comment(c)

    #print comments
    comments
  end

  #Post#add_comment takes a Comment object as its input and adds it to the comment list.
  def add_comment(comment)
    self.comments << comment
  end
end

p = Post.new
puts p
