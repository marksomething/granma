# Granma, a Grammar module for composing BDD tests in Ruby
module Granma

	# implements frequency grammar
	class Frequency < Granma::Base
		GRAMMAR = [
			{
				:phrases => ["every","all"],
				:lambda => lambda {|true_count,total_count| true_count == total_count }
			},
			{
				:phrases => ["some"],
				:lambda => lambda {|true_count,total_count| true_count > 0 }	
			}
		]
	end

end
