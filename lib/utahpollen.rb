require 'open-uri'
require 'nokogiri'

class PollenCounts
	LEVEL = {}
	LEVEL['0%'] = "Extremely Low"
	LEVEL['20%'] = "Low"
	LEVEL['40%'] = "Moderate"
	LEVEL['60%'] = "Moderately High"
	LEVEL['80%'] = "High"
	LEVEL['100%'] = "Extremely High"

	def self.get
		begin
			doc = Nokogiri::HTML(open("http://www.intermountainallergy.com/pollen.html"))
			names = []
			doc.xpath('//td/b').each do |node|
				names << node.text  
			end

			counts = []
			doc.xpath('//td/img').each do |node|
  				counts << node[:width] if node[:src] == "images/gl.jpg"
			end

			res = {}
			names.each_with_index do |n,i|
				res[n.lstrip] = LEVEL[counts[i]]
			end
		rescue
			res = {}
		end

		res
	end
end
