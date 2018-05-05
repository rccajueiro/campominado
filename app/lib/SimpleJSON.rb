require 'json'

class SimpleJSON
	def stringfy(data)
		return data.to_json
	end

	def pretty(data)
		return JSON.pretty_generate(data)
	end
end