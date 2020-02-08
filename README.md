# logicRuleEvaluator
Given a set of logic rules, allows users to check the sldnf and stable model resolution 

The logic programs used as data will be defined with the predicate rule/2.
The arguments are the head and the body of a rule in a logic program, where the body is represented as a list.

Examples:
```
rule(p,[q,r]).
rule(p,[]).
rule(p(X),[q(X,Y)]).
rule(p,[q,not(r)]).
rule(p(X),[not(q(X,Y))]).
```

Use Sicstus Prolog to launch the program. 


## SLDNF resolution
sldnf/1 takes as input a list of atoms  succeeding if there exists an SLDNF-refutation for the literals.

Example:
```
given;
rule(p(X),[]). 
rule(q(X),[r(X,Y),not(s(Y))]). 
rule(r(1,2),[]). 
rule(s(1),[]).

sldnf([p(1)]) and sldnf([p(X),q(X)]) will succeed.
sldnf([q(2)]) and sldnf([not(p(1))]) will fail.
```

## Checking stable models (for ground normal logic programs)
stableModel/1 takes as input a list of atoms, succeeding if the list is a stable model of the normal logic program defined by all facts in the predicate rule/2.

Example:
```
given:
myRule(p,[q,not(r)]). 
myRule(q,[]).

stableModel([p,q]) will succeed. 

stableModel([p,q,r]) and stableModel([p]) will fail.
```
