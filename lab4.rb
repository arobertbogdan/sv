a = 10 + 3
b = "NOT"

if a == 13
	puts "#{b}true"
elsif a==15
	# sfg .
else
	puts 'altceva'
end

unless a == 13 # || &&
	# cpd
end

puts "#{b}true" if a == 13

x = ["Games", "Play", "Fun"]

puts x.join("and")

a = [["matt", "plumber"],["phil", "baker"]]

b = a.map{|name| "name: #{name[0]} ocupation: #{name[1]}"}

puts b

a = [1, 2, 3, 4, 5, 6, 7]

b = a.select{|element| element%2 == 0}.map{|element| element*3}

puts b

text = "the car costs 100 and the cat costs 50"

text.split(" ").each{|element|
	if element.length > 4 && element.to_i != nil
		puts element
	end
}

def isPrime(number)
	if number < 2 || number%2 == 0
		return false
	end
	(number/2..number-1).to_a.each{|element|
		if number%element == 0
			return false 
		end
	}
	true
end

puts isPrime(71) == true ? "Is prime" : "Is not prime"