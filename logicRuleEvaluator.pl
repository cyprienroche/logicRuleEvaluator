:- use_module(library(sets)).

rule/2.

% SLD Resolution

sld( [] ).
sld( [ X | XS ] ) :-
  rule( X, YS ),
  append( XS, YS, ZS ),
  sld( ZS ).

% Checking the least Herband model (for ground positive logic programs)

lhm( XS ) :- nextSet( XS, XS ).

nextSet( XS, YS ) :- findall( X, bodyInSet( X, XS ), YS ).

bodyInSet( X, YS ) :- rule( X, T ), subset( T, YS ).

% SLDNF resolution

sldnf( [] ).
sldnf( [ X | XS ] ) :-
  rule( X, YS ),
  append( XS, YS, ZS ),
  sldnf( ZS ).
sldnf( [ not( X ) | XS ] ) :-
  \+ sldnf( [ X | XS ] ),
  sldnf( XS ).

% Checking stable models (for ground normal logic programs)

stableModel( XS ) :- nextSetReduct( XS, XS ).

nextSetReduct( XS, YS ) :- findall( X, rBodyInSet( X, XS ), YS ).

rBodyInSet( X, YS ) :- rule( X, T ), contained( T, YS ).

contained( [], _ ).
contained( [ not(X) | XS ], YS ) :- \+ member( X, YS ), contained( XS, YS ).
contained( [ X | XS ], YS ) :- member( X, YS ), contained( XS, YS ).
