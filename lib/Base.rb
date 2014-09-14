# Granma, a Grammar module for composing BDD tests in Ruby
module Granma

	# Superclass, defines the functionality but not the grammar components
	class Base

		GRAMMAR = []

		# Returns a regex sub-match with all of the phrases in a class
		def self.to_r()
			phrases = self.const_get("GRAMMAR").map(){|elem|
				elem[:phrases]
			}.reduce([]){|carry,elem|
				carry + elem
			}
			'(' + phrases.join('|') + ')'
		end

		# Returns the translated entries of a given type for a given phrase
		def self.to_x(type,phrase)

			# walk grammar structure looking for a entry whick includes the phrase supplied
			match = self.const_get("GRAMMAR").select(){|elem| elem[:phrases].include?(phrase.downcase)}
			
			if match.length > 1
				# this is a sign of bad grammar structure, perhaps move to test suite
				raise "more than one matching entry for phrase: #{phrase}"
			elsif match.length == 0
				raise "no matching phrase"
			elsif not match[0].include?(type)
				raise "no #{type} defined for phrase: #{phrase}"
			end

			match[0][type]

		end

		# returns a ruby lambda which implements the phrase given
		def self.to_lambda(phrase)
			to_x(:lambda,phrase)
		end

		# returns a SQL fragment which implements the phrase given
		def self.to_sql(phrase)
			to_x(:sql,phrase)
		end

		# calls the ruby lambda which implements the phrase given
		def self.call(phrase,*args)
			to_lambda(phrase).call(*args)
		end
	end

end
