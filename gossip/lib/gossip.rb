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

	def find(id)
		gossips = Gossip.all
		gossips.each_with_index do |gossip, index|
			if index == id - 1
				return gossip 
			end
		end
	end
end