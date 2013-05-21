require "Base"
# Granma, a Grammar module for composing BDD tests in Ruby
module Granma

	# implements comparison grammar
	class Compare < Granma::Base
		GRAMMAR = [
			{	
				:phrases => ["at least","greater than or equal to"],
				:lambda => lambda {|left,right| left >= right },
				:sql => " >= "
			},
			{
				:phrases => ["at most","less than or equal to"],
				:lambda => lambda {|left,right| left <= right },
				:sql => " <= "
			},
			{
				:phrases => ["more than","greater than"],
				:lambda => lambda {|left,right| left > right },
				:sql => " > "
			},
			{
				:phrases => ["less than"],
				:lambda => lambda {|left,right| left < right },
				:sql => " < "
			},
			{
				:phrases => ["equal to","exactly"],
				:lambda => lambda {|left,right| left == right },
				:sql => " = "
			},
			{
				:phrases => ["not equal to"],
				:lambda => lambda {|left,right| left != right },
				:sql => " <> "
			}
		]
	end

end
