%==========Grammar Rules==========

determiner -->[the].
determiner -->[a].

aux_verb --> [did] ; [do] ; [does].

wh_word --> [what] ; [who] ; [whom] ; [where] ; [when] ; [why] ; [how].

noun --> [dog] ; [cat] ; [boy] ; [ball] ; [girl] ; [puzzle] ; [soldier] ; [man].


% ------- Base form for questions-------
verb_base --> [kick] ; [chase] ; [solve] ; [rescue].
singular_verb --> [kicks] ; [chases] ; [solves]; [rescues].



% Past tense for declarative sentences
verb_past --> [kicked] ; [chased] ; [solved] ; [rescued].


%-------- noun phrase Rule --------- 
noun_phrase --> determiner, noun.    


%---------verb phrase Rule ----------
verb_phrase --> verb_past, noun_phrase.     
verb_phrase --> verb_base, noun_phrase.    
verb_phrase --> singular_verb, noun_phrase.  


%------ Sentence --------
sentence --> noun_phrase,verb_phrase.        
sentence --> noun_phrase,[will], verb_phrase.   




% Question forms;

%------- WH Question form------
question -->wh_word, aux_verb, noun_phrase , verb_base.  solve
question -->wh_word, aux_verb, noun_phrase , verb_base,noun_phrase.  


%------- Negative Question form------
question --> aux_verb, noun_phrase, [not], verb_base, noun_phrase.   

%------- Yes/No Question form------
question --> aux_verb, noun_phrase, verb_base, noun_phrase.    




%=========== MAIN PROGRAM ===============

start_checker :-
	nl,
	write('======== Grammar Checking System ========='),nl,
	write('Type a sentence or question : '),nl,
	write("Type 'exit' to end."),nl,
	loop.

loop :-
    write('Enter: '),
    read_line_to_string(user_input, Input), 
    (Input = "exit" ->
	write('Goodbye! ')
    ;
	check_grammar(Input),
	loop
    ).


% --------- Tokenize(split) and check grammar --------

check_grammar(Input) :-
	string_lower(Input, LowerCaseInput),
	split_string(LowerCaseInput, " ", "" ,TempWords),    
	exclude(==( ""), TempWords,WordStrings),           
	maplist(atom_string, WordList, WordStrings),      
	(WordList = [] ->
	    write('Empty input.Try again...'),nl
	;
	   ( phrase(sentence, WordList) ->
		write('Grammatically correct Sentence!'),nl
	   ;
	     phrase(question, WordList) -> 
		write('Grammatically correct question!'),nl
	   ;
	        write('Not grammatically correct.Try again...'),nl
	   )
	).



