require_relative 'braincells1'

#COMMON_WORDS = ["the", "be", "of", "and", "a", "to", "in", "he", "have", "it", "that", "for", "they", "I", "with", "as", "not", "on", "she", "at", "by", "this", "we", "you", "do", "but", "from", "or", "which", "one", "would", "all", "will", "there", "say", "who", "make", "when", "can", "more", "if", "no", "man", "out", "other", "so", "what", "time", "up", "go"]#, "about", "than", "into", "could", "state", "only", "new", "year", "some", "take", "come", "these", "know", "see", "use", "get", "like", "then", "first", "any", "work", "now", "may", "such", "give", "over", "think", "most", "even", "find", "day", "also", "after", "way", "many", "must", "look", "before", "great", "back", "through", "long", "where", "much", "should", "well", "people", "down", "own", "just", "because", "good", "each", "those", "feel", "seem", "how", "high", "too", "place", "little", "world", "very", "still", "nation", "hand", "old", "life", "tell", "write", "become", "here", "show", "house", "both"]

dictionary = Hash.new
File.open("/Users/rorycampbell/Documents/ruby-on-rails/small-fry/dictionary.txt") do |file|
  file.each do |line|
  	if line.start_with?('Usage')
  		line = ''
  	else
  		definition = line[/(adj\.|adv\.|n\.|v\.|v\.aux\.|abbr\.|abl\.|Abstr\.|Acad\.|acc\.|adjs\.|advb\.|advs\.|\(also|Anat\.|attrib\.|\(brit\.|\(us|colloq\.|comb\.|symb\.|n\.pl\.|objective\ case|past\ part\.|past\ of|prep\.|pl\.|poss\.|predic\.|pro|suffix|prefex|mus\.|int\.|interrog\.|preffix|var\.|contr\.|\-adj\.|\-adv\.|\-n\.|\-v\.|Abbr\.|archaic|Abstr\.|Acad\.|acc\.|adjs\.|advb\.|advs\.|Anat\.|conj\.|symb\.|n\.pl\.|prep\.|suffix|prefix|mus\.|int\.)\s.*/]
  		keyword = line.gsub("#{definition}", "").strip
  		if keyword.end_with?("—")
  			keyword = keyword[0..-2].strip
  		end
    	dictionary[keyword] = definition
    end
  end
end

#Choose option: 0- normal 1- Ans Defs (1para) and word count. 2- Question defintion (3 para) and word count. 3- dot dot dot phrase 4- Spelltest

q = " "
aA = " "
aB = " "
aC = " "
aD = " "
uris = []


qxd, qyd, axd , ayd, qx0, qy0,  aAx0, aAy0, aDx0, aDy0 = 915, 76, 388, 42, 335, 659, 366, 765, 913, 840

while coord != "y" and coord != "n"
	puts "Do you wish to enter your own screen coordinates and dimensions for question and answer boxes? Y/n \n\n"
	coord = gets.chomp.downcase
	if coord == "n"
		puts "As you do not wish to provide coordinates, Who wants to be a Millionaire defaults will be used. These function correctly on recent Mac versions when the game window is touching the top of the screen, the right of the screen and is 190 pixels from the left. However, as precision is important to the success of the OCR, it is recommended that you check the diminesions with a program such as PixelStick.\n\nThe dimensions and coordinates are the following:\n\n Question box width (qxd) = 915, Question box height (qyd) = 76, Answer box width (axd) =  388, Answer box height (ayd) = 42, X co-ord of top left point of question box (qx0) = 335, Y co-ord of top left point of question box (qy0) = 659,  X co-ord of top left point of answer box A (aAx0) = 366, Y co-ord of top left point of answer box A (aAy0) = 765, X co-ord of top left point of answer box D (aDx0) = 913, Y co-ord of top left point of answer box D (aDy0) = 840\n\n "
	elsif coord = "y"
		puts "Enter the coordinates/dimensions in the following order:\n\n Question box width (qxd), Question box height (qyd), Answer box width (axd), Answer box height (ayd), X co-ord of top left point of question box (qx0), Y co-ord of top left point of question box (qy0),  X co-ord of top left point of answer box A (aAx0), Y co-ord of top left point of answer box A (aAy0), X co-ord of top left point of answer box D (aDx0), Y co-ord of top left point of answer box D (aDy0) \n\n"
		puts "qxd:\n"
		qxd = gets.chomp.to_i

		puts "qyd:\n"
		qyd = gets.chomp.to_i
		
		puts "axd:\n"
		axd = gets.chomp.to_i		
		
		puts "ayd:\n"
		ayd = gets.chomp.to_i
		
		puts "qx0:\n"
		qx0 = gets.chomp.to_i
		
		puts "qy0:\n"
		qy0 = gets.chomp.to_i
		
		puts "aAx0\n"
		aAx0 = gets.chomp.to_i
		
		puts "aAy0\n"
		aAy0 = gets.chomp.to_i
		
		puts "aDx0\n"
		aDx0 = gets.chomp.to_i
		
		puts "aDy0\n"
		aDy0 = gets.chomp.to_i
	else
		puts "Reply not understood...\n\n"
	end
# \n\n If you choose no, the default setup for Who Want to be a Millionaire online version will be used where the window border should be touching the top and the left "

while true do
	option = 0
	puts "1- Ans Defs (1para) and word count. 2- Question defintion (3 para) and word count. 3- dot dot dot phrase. 4- Spelltest"
	puts "choose option"
	begin
		option = gets.chomp.to_i
	rescue
		option = 0
	end

	if option == 9
		abort('exiting program')
	end

	if option < 10 or option > 1000
		#system('screencapture /Users/rorycampbell/Documents/smallfrybeta/screenshot.jpg')
		qAndAs = readText(qxd, qyd, axd , ayd, qx0, qy0,  aAx0, aAy0, aDx0, aDy0)

		puts q = qAndAs[0]
		puts aA = qAndAs[1]
		puts aB = qAndAs[2]
		puts aC = qAndAs[3]
		puts aD = qAndAs[4]

		#need to clean up re-use screenshot, especially with option 2 (accronym)

		if option % 10 != 2
			uris = googleSearch(q)
		end
	end


	if option % 10 == 1
		beginning = Time.now

		puts "option 1"

		kiwixHtmls = kiwixAnswerSearch(aA, aB, aC, aD, q)
		
		puts "A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A\n"
		puts paras(kiwixHtmls[0], q, aA, aB, aC, aD) + "\n\n"
		puts "B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B\n"
		puts paras(kiwixHtmls[1], q, aA, aB, aC, aD) + "\n\n"
		puts "C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C\n"
		puts paras(kiwixHtmls[2], q, aA, aB, aC, aD) + "\n\n"
		puts "D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D\n"
		puts paras(kiwixHtmls[3], q, aA, aB, aC, aD) + "\n\n"

	
		hitCount(uris, aA, aB, aC, aD)
		puts "Operation took #{Time.now - beginning} seconds"

	elsif option % 10 == 2 #keywords kiwix search then google hit count

		puts "enter accronym:"
		acc = gets.chomp

		term = accSearch(q, acc)

		uris = googleSearch(term)

		kiwixResult = kiwixKeywordSearch(term, q)

		p1 = paras(kiwixResult, q, aA, aB, aC, aD)
		p2 = paras(kiwixResult, q, aA, aB, aC, aD, 2)

		puts p1 + "\n\n"
		puts p2

		hitCount(uris, aA, aB, aC, aD)

	elsif option % 10 == 3

		kiwixHtmls = dots(q, aA, aB, aC, aD)

		kiwixHtmls.each do |html|

			p = paras(html, q, aA, aB, aC, aD)[0]
			puts p
		end

		hitCount(uris, aA, aB, aC, aD)

	elsif option % 10 == 4
		puts "A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A --- A\n"
		puts dictionary[aA] + "\n\n"
		puts "B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B --- B\n"
		puts dictionary[aB] + "\n\n"
		puts "C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C --- C\n"
		puts dictionary[aC] + "\n\n"
		puts "D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D --- D\n"
		puts dictionary[aD] + "\n\n"

	elsif option % 10 == 5

		htmlA = getHTML(googleSearch(aA + " wikipedia", 1))
				
		
	else

		hitCount(uris, aA, aB, aC, aD)
	end
end

















			

#Option 2

#-Look up relevant question words on Kiwix server

#-Simulaneaously look up hits online

#Option 3

#-Put each answer into dots

#-Look up each answer on Kiwix server


#Option 4

#-Look up each answer in dictionary

#-?Look up each answer in wikipedia

#Return to option choice (possibly make hotkey to do this at other times)