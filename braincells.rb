require 'RMagick'
require 'tesseract'
require 'HTTParty'
require 'open-uri'
require 'Nokogiri'
require 'google-search'
require 'numbers_in_words'
require 'numbers_in_words/duck_punch'

class String
	def numberize
	begin
		if self =~ /^[\d\.*,*]+$/
			self.to_f
		elsif self =~ /^\D+$/
			self.in_numbers
		else
			self.to_f * self.in_numbers
		end
	rescue
	end
	end
end

def colorize(text, color_code)
  "\e[#{color_code}m#{text}\e[0m"
end

def orange(text); colorize(text, 31); end
def green(text); colorize(text, 32); end
def yellow(text); colorize(text, 33); end
def darkblue(text); colorize(text, 34); end
def pink(text); colorize(text, 35); end
def blue(text); colorize(text, 36); end

#crops a screenshot and reads from relevant sections

def readText(qxd = 915, qyd = 76, axd =  388, ayd = 42, qx0 = 335, qy0 = 659,  aAx0 = 366, aAy0 = 765, aDx0 = 913, aDy0 = 840) #for default measurements to function correctly, left edge of game screen should be around 190 pixels in.
	#r = rand(100000).to_s
	#system('screencapture /Users/rorycampbell/Documents/smallfrybeta/screenshot' + r + '.jpg')
	#img = Magick::Image.read('screenshot' + r + '.jpg').first
	img = Magick::Image.read('screenshotPNI.jpg').first
	question = img.crop(qx0, qy0, qxd, qyd, true).bilevel_channel(17000)
	answerA = img.crop(aAx0, aAy0, axd, ayd, true).bilevel_channel(17000)
	answerB = img.crop(aDx0, aAy0, axd, ayd, true).bilevel_channel(17000)
	answerC = img.crop(aAx0, aDy0, axd, ayd, true).bilevel_channel(17000)
	answerD = img.crop(aDx0, aDy0, axd, ayd, true).bilevel_channel(17000)


	question.write('question.jpg')
	answerA.write('answerA.jpg')
	answerB.write('answerB.jpg')
	answerC.write('answerC.jpg')
	answerD.write('answerD.jpg')

	e = Tesseract::Engine.new {|e|
	  e.language  = :eng
	  e.blacklist = '|_'
	}

	q = e.text_for('question.jpg').strip.gsub(/\n/," ")
	aA = e.text_for('answerA.jpg').strip 
	aB = e.text_for('answerB.jpg').strip 
	aC = e.text_for('answerC.jpg').strip 
	aD = e.text_for('answerD.jpg').strip

	qAndA = []
	qAndA << q << aA << aB << aC << aD
	qAndA.each do |text|
		text.gsub!(')’','y')
	end

	return qAndA 
end




#returns htmls of kiwix answer searches
def kiwixAnswerSearch(aA, aB, aC, aD)
	htmls = []

	begin
		address1 ='http://127.0.0.1:8000/wikipedia_en_all_nopic_01_2012/A/' + URI::encode(aA) + '.html'
	rescue
		puts "address1 not encoded"
	end
	begin
		address2 ='http://127.0.0.1:8000/wikipedia_en_all_nopic_01_2012/A/' + URI::encode(aB) + '.html'
	rescue
		puts "address1 not encoded"
	end
	begin
		address3 ='http://127.0.0.1:8000/wikipedia_en_all_nopic_01_2012/A/' + URI::encode(aC) + '.html'
	rescue
		puts "address1 not encoded"
	end
	begin
		address4 ='http://127.0.0.1:8000/wikipedia_en_all_nopic_01_2012/A/' + URI::encode(aD) + '.html'
	rescue
		puts "address1 not encoded"
	end

	begin
		htmls << HTTParty.get(address1)
	rescue
		puts "address1 not gotten"
	end
	begin
		htmls << HTTParty.get(address2)
	rescue
		puts "address2 not gotten"
	end
	begin
		htmls << HTTParty.get(address3)
	rescue
		puts "address3 not gotten"
	end
	begin
		htmls << HTTParty.get(address4)
	rescue
		puts "address4 not gotten"
	end
end


# returns html of keywords kiwix search
def kiwixKeywordSearch(question, acc)
	if acc[-1] == '2'
		puts 'end with 2'
		if acc.length == 2
			acc = acc[0..-2]
			puts acc		
			term = question.scan(/\b#{acc[0]}\w*/)[1]
		else
			acc = acc[0..-2]
			puts acc		
			term = question.scan(/\b#{acc[0]}\w*\s#{acc[1]}\w*/)[1]
		end
	elsif acc[-1] == '3'
		if acc.length == 2
			acc = acc[0..-2]
			puts acc		
			term = question.scan(/\b#{acc[0]}\w*/)[2]
		else
			acc = acc[0..-2]
			puts acc		
			term = question.scan(/\b#{acc[0]}\w*\s#{acc[1]}\w*/)[2]
		end
	elsif acc.length == 1
		term = question[/\b#{acc[0]}\w*/]
	elsif acc.length == 2
		term = question[/\b#{acc[0]}\w*\s#{acc[1]}\w*/]
	elsif acc.length == 3
		term = question[/\b#{acc[0]}\w*\s#{acc[1]}\w*\s#{acc[2]}\w*/]
	elsif acc.length == 4
		term = question[/\b#{acc[0]}\w*\s#{acc[1]}\w*\s#{acc[2]}\w*\s#{acc[3]}\w*/]
	elsif acc.length == 5
		term = question[/\b#{acc[0]}\w*\s#{acc[1]}\w*\s#{acc[2]}\w*\s#{acc[3]}\w*\s#{acc[0]}\w*/]
	elsif acc.length == 6
		term = question[/\b#{acc[0]}\w*\s#{acc[1]}\w*\s#{acc[2]}\w*\s#{acc[3]}\w*\s#{acc[0]}\w*\s#{acc[0]}\w*/]
	else 
		term = question[/\b#{acc[0]}\w*\s#{acc[1]}\w*\s#{acc[2]}\w*\s#{acc[3]}\w*\s#{acc[0]}\w*\s#{acc[0]}\w*\s#{acc[0]}\w*/]
	end

																		
	print "term = " + term.to_s + "\n\n"

	begin
		address ='http://127.0.0.1:8000/wikipedia_en_all_nopic_01_2012/A/' + URI::encode(term) + '.html'
	rescue
		puts "address encoding error"
	#---------------------------To be removed?
	html = HTTParty.get(address)
	#puts html +"\n\n\n"
	return html
end


# puts a colour aided wikipedia article to screen, with pnum the number of the paragraph
def paras(text, q, aA, aB, aC, aD, pnum = 0)
	common_words = ["the", "be", "of", "and", "a", "is", "to", "in", "he", "have", "it", "that", "for", "they", "I", "with", "as", "not", "on", "she", "at", "by", "this", "we", "you", "do", "but", "from", "or", "which", "one", "would", "all", "will", "there", "say", "who", "make", "when", "can", "more", "if", "no", "man", "out", "other", "so", "what", "time", "up", "go", "about", "than", "into", "could", "only", "these", "come", "these", "some", "then", "any"] #, "state", "only", "new", "year", "some", "take", "come", "these", "know", "see", "use", "get", "like", "then", "first", "any", "work", "now", "may", "such", "give", "over", "think", "most", "even", "find", "day", "also", "after", "way", "many", "must", "look", "before", "great", "back", "through", "long", "where", "much", "should", "well", "people", "down", "own", "just", "because", "good", "each", "those", "feel", "seem", "how", "high", "too", "place", "little", "world", "very", "still", "nation", "hand", "old", "life", "tell", "write", "become", "here", "show", "house", "both"]

	numberWords = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety", "hundred", "thousand", "million", "billion", "trillion"] 
	numberWords = Regexp.union(numberWords)

	aWords = []
	aWords << aA << aB << aC << aD	
	qWords = q.split(" ")
	allWords = aWords + qWords
 	text = text.scan(/(\<p\>)(.*?)(\<\/p\>)/m).map(&:join)[pnum]
 	writtenNumbers = []

 	puts "allWords = " + allWords.to_s


	text.gsub!(/<\/?[^>]*>/,"")
	text.gsub!(/(&#160;)/,"")
	text.gsub!(/(\[\d+\])/,"")
	writtenNumbers = text.downcase.scan(/\b#{numberWords}(?:(?:\s+and\s+|\s+)#{numberWords})*\b/i)
	writtenNumbers.concat text.scan(/\b[\d\.*,*]+\b/)
	puts "writtenNumbers = " + writtenNumbers.to_s

	aWords.each do |i|
		i2 = i.gsub(/(\?|\.|\,|\!)/,"")
		if common_words.include?(i2) == false
			text.gsub!(/\b#{i2}\b/i, orange(i2))
		end
	end

	qWords.each do |i|
		i2 = i.gsub(/(\?|\.|\,|\!)/,"")
		if common_words.include?(i2) == false
			text.gsub!(/\b#{i2}\b/i, pink(i2))
		end
	end		

	writtenNumbers.each do |wnum|
		if wnum.numberize != 0 
			puts "wnum = " + wnum.numberize.to_s
		end
		allWords.each do |qora|
			if qora.numberize != 0
				puts "qora = " + qora.numberize.to_s 
			end 
			if wnum.numberize < qora.numberize * 1.05 and wnum.numberize > qora.numberize * 0.95
				text.gsub!(/\b#{wnum.to_s}\b/i, blue(wnum.to_s))
			end
		end
	end
	return text
end



#returns list of uris from a google search
def googleSearch(q, n = 5)

	search = Google::Search::Web.new do |search|
	  search.query = q
	  search.size = :small
	end
	begin
		uris = search.first(n).map(&:uri)
	rescue
		"uri fault"
	end

	return uris
end


#iterably counts number of hits of each answer in a list of uris
def hitCount(uris, aA, aB, aC, aD)

	hitCountStart = Time.now
	aAll = []
	aAll << aA << aB << aC << aD

    countA = 0
	countB = 0
	countC = 0
	countD = 0


	aA = aA.downcase
	aB = aB.downcase
	aC = aC.downcase
	aD = aD.downcase
	

	aTotal = []
	bTotal = []
	cTotal = []
	dTotal = []

	plaintexts=[]

	n = uris.size

	n.times {|i|
		if Time.now - hitCountStart < 8
			begin
				begin
			    	doc = Nokogiri::HTML(open(uris[i]))
			    	doc.css('script, link').each { |node| node.remove }
			   		plaintexts << doc.css('body').text.downcase.split("\n"). collect { |line| line.strip }.join("\n")
			   	rescue
			   		puts "Nokogiri could not read"
			   	end
		   	#rescue
		   	#	"Nokogiri fault"

		    					
			plaintexts[i].each_line { |bar|

				begin
					countA += bar.scan(/\b#{aA}\b/i).size
				rescue
				end					
				begin
					countB += bar.scan(/\b#{aB}\b/i).size
				rescue
				end
				begin					
					countC += bar.scan(/\b#{aC}\b/i).size
				rescue
				end	
				begin				
					countD += bar.scan(/\b#{aD}\b/i).size
				rescue

				end

			}
			puts "A = " + countA.to_s +	" B = " + countB.to_s + " C = " + countC.to_s +	" D = " + countD.to_s
		end
	end
	}
end


def definitionAnswers(aA, aB, aC, aD)
	aAll = []
	aAll << aA << aB << aC << aD
	aAll.each do |answer|
	if Dictionary.key?(answer)
		puts "\n" + answer + ":  " + Dictionary[answer] +"\n\n"
	else
		puts "\n" + answer + ' not found' +"\n\n"
	end
end
end


def dots(q, aA, aB, aC, aD)
	dotA = q.sub(/\.\.\./," " + aA)[/(‘|').*?(‘|')/][1..-2]
	dotB = q.sub(/\.\.\./," " + aB)[/(‘|').*?(‘|')/][1..-2]
	dotC = q.sub(/\.\.\./," " + aC)[/(‘|').*?(‘|')/][1..-2]
	dotD = q.sub(/\.\.\./," " + aD)[/(‘|').*?(‘|')/][1..-2]
	 

	address1 ='http://127.0.0.1:8000/wikipedia_en_all_nopic_01_2012/A/' + URI::encode(dotA) + '.html'
	address2 ='http://127.0.0.1:8000/wikipedia_en_all_nopic_01_2012/A/' + URI::encode(dotB) + '.html'
	address3 ='http://127.0.0.1:8000/wikipedia_en_all_nopic_01_2012/A/' + URI::encode(dotC) + '.html'
	address4 ='http://127.0.0.1:8000/wikipedia_en_all_nopic_01_2012/A/' + URI::encode(dotD) + '.html'

	htmls = []
	htmls << HTTParty.get(address1) << HTTParty.get(address2) << HTTParty.get(address3) << HTTParty.get(address4)
	return htmls
end
end

