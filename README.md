Shallow-Thought
===============

Program that reads question and answers off screen and gives the most likely answer. 

Program that reads question and answers off screen and gives the most likely answer. It is of possible use to read the screen of pub quiz machines and get the correct answer. Although unlikely to be very profitable, it may provide some entertainment.

ShallowThought uses opensource OCR to read a question from a given square on the screen and then reads four answers from other given coordinates.

The program then uses a variety of techniques to work out which answer is the most likely.

The main part of the program goes through the first 4 pages that google returns when the question is used as a search enquiry. The number of occurances of each answer is displayed to the user, along with the number of occurances of individual non common words in each answer.

Whilst this search is being performed, the program simultaneously searches a locally stored download of Wikipedia (accessed using Kiwix) for entries that relate to each of the answers and displays a few paragraphs of each of them, with any word that is related to the question, highlighted in a colour that signifies it's importance.

The program also provides several other options that are designed to deal with certain common formats of quiz question such as fill the blank and choose the correct date. These use alternative methods to find the most likely answer.
