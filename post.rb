require 'nokogiri'
require './comment.rb'
require 'pry'
#require_relative './post.html'

class Post
  attr_accessor :title, :url, :points, :item_id, :all_comments

  def initialize
    doc = Nokogiri::HTML(File.open('./post.html'))
    self.title = doc.css('span.score').map {|span| span.inner_text}
    self.url = 'https://news.ycombinator.com/item?id=7663775'
    self.points = doc.css('span.score').map {|span| span.inner_text}
    self.item_id = self.url.split('?id=')[1]
    self.all_comments = []

    #loop over all the comments
    #store the parent_id and last id on each iteration
    parents=[-1]
    previous = 0
    last_id = 0
    doc.css('tr.athing.comtr').each {|tr|
      #create a new comment
      c = Comment.new
      #get id
      c.id = tr['id']
      #get authour
      c.author = tr.css('a.hnuser').map {|link| link.inner_text}
      #get days_ago
      c.days_ago = tr.css('span.age > a').map {|link| link.inner_text}
      #get text
      c.text = tr.css('span.comment').text

      #create parent_id in a stack
      #store indent
      #binding.pry
      current = tr.css('td.ind > img')[0]['width'].to_i
      if current > previous
        parents << last_id
      elsif current < previous
        parents.pop((previous-current)/40)
      end
      c.parent_id = parents.last
      previous = current
      last_id = c.id

      #add comment to the comment list
      #binding.pry
      add_comment(c)
    }
  end

  #Post#comments returns all the comments associated with a particular post.
  def comments
    #print comments
    self.all_comments
  end

  #Post#add_comment takes a Comment object as its input and adds it to the comment list.
  def add_comment(comment)
    self.all_comments << comment
  end
end

p = Post.new
puts p.comments
