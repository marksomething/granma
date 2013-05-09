
# Granma::Compare.to_r()

module Granma

	class Base

		GRAMMAR = []

		def self.to_r()
			phrases = self.const_get("GRAMMAR").map(){|elem|
				elem[:phrases]
			}.reduce([]){|carry,elem|
				carry + elem
			}
			'(' + phrases.join('|') + ')'
		end

		def self.to_l(phrase)

			match = self.const_get("GRAMMAR").select(){|elem| elem[:phrases].include?(phrase.downcase)}
			
			if match.length > 1
				# perhaps move to test suite
				raise "more than one matching phrase"
			elsif match.length == 0
				raise "no matching phrase"
			elsif not match[0].include?(:lambda)
				raise "no lambda defined for phrase: #{phrase}"
			end

			match[0][:lambda]

		end

		def self.to_other(type,phrase)

			match = self.const_get("GRAMMAR").select(){|elem| elem[:phrases].include?(phrase.downcase)}
			
			if match.length > 1
				# perhaps move to test suite
				raise "more than one matching phrase"
			elsif match.length == 0
				raise "no matching phrase"
			elsif not match[0].include?(type)
				raise "no #{type} defined for phrase: #{phrase}"
			end

			match[0][type]

		end

		def self.call(phrase,*args)
			to_l(phrase).call(*args)
		end
	end

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