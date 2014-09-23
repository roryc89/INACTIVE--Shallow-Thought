Shallow-Thought
===============

Program reads a question and answers off the screen and gives the most likely answer. It may be possible use it to read the screen of pub quiz machines and get the correct answer. Although unlikely to be very profitable, it may provide some entertainment and the money for a drink.

ShallowThought uses opensource OCR to read a question from a given square on the screen and then reads four answers from other given coordinates.

The program then uses a variety of techniques to work out which answer is the most likely.

The main part of the program goes through the first 4 pages that google returns when the question is used as a search query. The number of occurences of each answer is displayed to the user, along with the number of occurences of individual non common words in each answer.

Whilst this search is being performed, the program simultaneously searches a locally stored download of Wikipedia (accessed using Kiwix) for entries that relate to each of the answers and displays a few paragraphs of each of them, with any word that is related to the question, highlighted in a colour that signifies it's importance.

The program also provides several other options that are designed to deal with certain common formats of quiz question such as fill the blank, choose the correct spelling and choose the correct date. These use alternative methods to find the most likely answer.

In order to run Shallow Thought you will need Ruby and a number of programs and packages that Shallow Thought employs. These are: ImageMagick (with RMagick), TesseractOCR, Google-search, HTTParty, Numbers in words, Open-uri, Colored and Nokogiri. You will also need to change the path to the dictionary.txt file in shallowthought.rb to make it correct for your computer.

Opening shallowthought.rb from the command line will run the program. Only shallowthought.rb, braincells1.rb and dictionary.rb are necessary to run the program. The other ruby files are code that is being stored for potential improvements and the pictures are to demonstrate what sort of result you should obtain. The answer pictures are an example of what type of picture the OCR should operate on. 
