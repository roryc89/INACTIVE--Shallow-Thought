beginning = Time.now
require_relative 'braincells1'

textA = "The New Kingdom of Egypt, also referred to as the Egyptian Empire is the period in ancient Egyptian history between the 1600 BC and the 1100 BC, covering the Eighteenth, Nineteenth, and Twentieth Dynasties of Egypt. The New Kingdom followed the Second Intermediate Period and was succeeded by the Third Intermediate Period. It was Egypt’s most prosperous time and marked the peak of its power.[1]

The later part of this period, under the Nineteenth and Twentieth Dynasties (1292-1069 BC) is also known as the Ramesside period, after the eleven pharaohs that took the name of Ramesses.

Radiocarbon dating suggests that the New Kingdom may have started a few years earlier than the conventional date of 1550 BC. The radiocarbon date range for its beginning is 1570-1544 BC, the mean point of which is 1557 BC.[2]

Possibly as a result of the foreign rule of the Hyksos during the Second Intermediate Period, the New Kingdom saw Egypt attempt to create a buffer between the Levant and Egypt, and attained its greatest territorial extent. Similarly, in response to very successful 17th century attacks by the powerful Kingdom of Kush[3] , the New Kingdom felt compelled to expand far south into Nubia and hold wide territories in the Near East. Egyptian armies fought Hittite armies for control of modern-day Syria."


#def textsDates(textA)
#	textAdig = textA.gsub("th century ", "00")
#	#textAdig.gsub!()
#	listBC = textAdig.scan(/\w+\s?bce?/i)
#	listBC = textAdig.scan(/\s\d+\s?bce?/i)
#	listBC.each do |date|
#		datenew = date.gsub(/\D/,"")
#		datenew = " -" + datenew
#		textAdig.gsub!(date, datenew)
#	end
#
#	listBC = textAdig.scan(/\d+-\d+\s?b?c?e?/i)
#	listBC.each do |date|
#		puts date
#		datenew = date.gsub("-"," to ")
#		datenew.gsub!(/[^\d(\sto\s)]/,"")
#		if date =~ /.*bce?$/i
#			puts 'end with BC'
#			datenew.gsub!("to ", " to -")
#			datenew = " -" + datenew
#		end
#		puts datenew
#		textAdig.gsub!(date, datenew)
#	end
#	puts textAdig
#
#	datelist = textAdig.scan(/-?\d+/)
#	return datelist
#end

#puts 'paras: ' + paras(kiwixKeywordSearch('Twist', "dances monkey tulips the one day that I "), 'dances', 'hello','1950','charleston')

#q = 'Starting with the smallest, put these American measures in order of 1823'
#aA = 'Pint'
#aB = 'Peck'
#aC = 'Cup'
#aD = "Gallon"

q = "What do the plus and minus symbols stand for on a standard battery?"
aA = "Pros and cons"
aB = "Positive and negative"
aC = "North and south"
aD = "Top and bottom"

hitCount(['http://wiki.answers.com/Q/What_does_plus_end_of_AA_battery_mean','http://www.rhul.ac.uk/economics/documents/pdf/casiofx-83gtplususerguide.pdf','http://en.wikipedia.org/wiki/Polarity_symbols','http://www.csus.edu/indiv/k/kuhlej/207Files/TI%20Tutorial.doc','http://facstaff.bloomu.edu/skokoska/TI84PlusGuidebook.pdf'], aA, aB, aC, aD)
#
#k = kiwixAnswerSearch(aA, aB, aC, aD, q)
##
#puts "\n\n" + ""
#puts "A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A\n"
#puts paras(k[0], q, aA, aB, aC, aD, 1, 2).to_s + "\n\n"
#puts "B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B\n"
#puts paras(k[1], q, aA, aB, aC, aD, 1, 2).to_s + "\n\n"
#puts "C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C\n"
#puts paras(k[2], q, aA, aB, aC, aD, 1, 2).to_s + "\n\n"
#puts "D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D\n"
#puts paras(k[3], q, aA, aB, aC, aD, 1, 2).to_s + "\n\n"
#ordered(q, aA, aB, aC, aD)
#puts paras(kiwixAnswerSearch(aA, aB, aC, aD)[1])



puts "Reading and scanning took #{Time.now - beginning} seconds"