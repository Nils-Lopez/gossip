require 'csv'
class Gossip
	attr_accessor :content, :author

	def initialize(author, content)
		@author = author
		@content = content
	end

	def self.all 
		all_gossips = []
		CSV.read("./db/gossips.csv").each do |line|
			gossip = Gossip.new(line[0], line[1])
			all_gossips << gossip
		end
		return all_gossips
	end

	def save
		CSV.open('./db/gossips.csv', 'ab') do |csv|
			csv << [@author, @content]
		end
	end

	def self.find(id)
		gossips = Gossip.all
		gossips.each_with_index do |gossip, index|
			if index == id.to_i - 1
				return gossip 
			end
		end
	end

	def self.modify(startcontent, newcontent)
		gossips = Gossip.all
		all_gossips = []
		gossips.each do |gossip|
			if gossip == startcontent
				gossip.content = newcontent
			end
			all_gossips << gossip
		end
		File.open("./db/gossips.csv", 'w+') do |line|
			all_gossips.each do |gossip|
     		line.puts(gossip.author, gossip.content)
     	end
    end
	end
end