# app.js.coffee

# angular module and dependencies
GameApp = angular.module("GameApp", [ "ngRoute", "templates"])

# angular router
GameApp.config ["$routeProvider", "$locationProvider", ($routeProvider, $locationProvider) ->
	$routeProvider
		.when "/",
			templateUrl: "index.html",
			controller: "GameCtrl"
		# test
		.when "hangman",
			templateUrl: "hangman.html",
			controller: "HangCtrl"
	.otherwise
		redirectTo: "/"

	$locationProvider.html5Mode(true).hashPrefix("#")
]

#added routes, routeParams
# angular controller
GameApp.controller "GameCtrl", [ "$scope", "$http", "$routeParams", ($scope, $http, $routeParams) ->

	$scope.alphabet = [ 
		{ chr: "a", chosen: false },
		{ chr: "b", chosen: false },
		{ chr: "c", chosen: false },
		{ chr: "d", chosen: false },
		{ chr: "e", chosen: false },
		{ chr: "f", chosen: false },
		{ chr: "g", chosen: false },
		{ chr: "h", chosen: false }, 
		{ chr: "i", chosen: false },
		{ chr: "j", chosen: false },
		{ chr: "k", chosen: false },
		{ chr: "l", chosen: false },
		{ chr: "m", chosen: false },
		{ chr: "n", chosen: false },
		{ chr: "o", chosen: false },
		{ chr: "p", chosen: false },
		{ chr: "q", chosen: false },
		{ chr: "r", chosen: false },
		{ chr: "s", chosen: false },
		{ chr: "t", chosen: false },
		{ chr: "u", chosen: false },
		{ chr: "v", chosen: false },
		{ chr: "w", chosen: false },
		{ chr: "x", chosen: false },
		{ chr: "y", chosen: false },
		{ chr: "z", chosen: false} 
		
	]

	# create new secret word
	$scope.submitSecretWord = (word) ->
		# take secret word from game page on form submit
		# run validation here, length, alphabet letters
		# could display word and ask for confirmation from player
		# split into array maintains order
		$scope.word = word.secret.split("")
		console.log("word, ", $scope.word)		
		$scope.wordSaved = true
 		# put in scope.secret array of object
		# split into objects allows duplicates
		i = 0
		while i < $scope.word.length
			newSecretLetter = {}
			letter = $scope.word[i]
			newSecretLetter.chr = letter
			newSecretLetter.place = i
			newSecretLetter.guessed = false
			$scope.secrets.push newSecretLetter
			i++
		console.log "0 ,", $scope.secrets[0]
		console.log "1 ,", $scope.secrets[1]
		console.log "end ,", $scope.secrets

	$scope.letterChosen = (character) ->
		# test if letter is in secret word
		if character.chr in $scope.word
			$scope.message = "Correct!"
			# display letter in blanks

		else
			# if it isn't,  show X against
			$scope.message = "Nope, sorry!"
			$scope.strikes += 1
			if ($scope.strikes == $scope.maxGuesses)
				$scope.message = "Game Over!"
				$scope.gameOver = true
		#mark letter as chosen
		character.chr = character.chr.toUpperCase()
		character.chosen = true


	$scope.init = ->
		$scope.word = []
		$scope.secrets = []
		$scope.message = "Get ready to guess!"
		$scope.strikes = 0
		$scope.maxGuesses = 6
		$scope.gameOver = false
		# changed for test, for production should be false
		$scope.wordSaved = false
		for character in $scope.alphabet 
			character.chosen = false

	$scope.init

] 

# Define Config for CSRF token
GameApp.config ["$httpProvider", ($httpProvider)->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]