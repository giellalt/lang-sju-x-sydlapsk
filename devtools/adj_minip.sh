#!/bin/bash

# script to generate paradigms for generating word forms
# command:
# sh generate_contlex_para.sh PATTERN
# example, when you are in sju-x-sydlapsk:
# sh devtools/adj_minip.sh HUMO  | less
# sh devtools/adj_minip.sh hyeni 
# Only get the lemma you ask for:
# sh devtools/adj_minip.sh '^hyeni[:+]' 

LOOKUP=$(echo $LOOKUP)
GTLANGS=$(echo $GTLANGS)

PATTERN=$1
L_FILE="in.txt"
cut -d '!' -f1 src/fst/morphology/stems/adjectives.lexc | egrep $PATTERN | tr '+' ':' | cut -d ':' -f1>$L_FILE

P_FILE="src/fst/morphology/test/testadjparadigm.txt"
#P_FILE="src/fst/morphology/test/adj_paradigm.txt"

for lemma in $(cat $L_FILE);
do
 for form in $(cat $P_FILE);
 do
#      echo "${lemma}${form}" | $HLOOKUP $GTLANGS/lang-sju-x-sydlapsk/src/fst/generator-gt-norm.hfstol # hfst
      echo "${lemma}${form}" | $HLOOKUP $GTLANGS/lang-sju-x-sydlapsk/src/fst/generator-gt-desc.hfstol # hfst
 done
 rm -f $L_FILE
done

