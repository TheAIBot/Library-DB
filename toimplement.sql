#--Procedues--
	#--loaner--
		#create new loaner -- CreateLoaner
        #get the books that a loaner is currently borrowing -- GetCurrentBooksLoanedByLoaner
		#get a loaners loaning history -- GetLoanerHistory
        #get all loans that a loaner returned on time -- GetLoanersArticlesReturnedOnTime
        #get all loans that a loaner returned too late -- GetLoanersArticlesReturnedTooLate
	#--librarian--
		#create new librarian -- CreateLibrarian
        #loan book to loaner -- Can't currently be made
        #return article that a loaner loaned -- Can't currently be made
        #get all articles that a librarian is currently resposible for -- GetLibrarianArticlesResponsibleFor
		#get all articles a librarian has loaned out -- GetLibrarianLoanedOutArticlesHistory
    #--library--
		#get a librarys books -- GetLibraryBooks
		#get librarians that work for a specific library -- GetLibrariansWorkingForLibrary
        #get all loaners that currently loan an article from that library -- GetLibrarysCurrentlyLoanedOutArticles
    #--book--
		#create new book -- CreateBook
	#--article--
		#create new article -- CreateArticle
    
        
#--transactions--
	#move article from one library to another -- ChangeArticleOwnerLibrary
	#move librarian from one library to another -- ChangeLibrarianWorkLibrary

        
#--triggers--