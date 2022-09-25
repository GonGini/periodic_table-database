#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

DELETE_MTPROP_RESULT=$($PSQL "DELETE FROM properties WHERE atomic_number = 1000")

DELETE_MTELE_RESULT=$($PSQL "DELETE FROM elements WHERE atomic_number = 1000")

DELETE_TYPEPROP_RESULT=$($PSQL "ALTER TABLE properties DROP COLUMN type")

if [[ ! $1 ]]
  then
    echo -e "Please provide an element as an argument."
  else
   
  DEJAR=0

  if [[ $1 =~ ^[0-9]+$ ]]
    then
    NUM=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $1")
    if [[ -z $NUM ]]
      then 
      DEJAR=1
    fi
  fi


  
   
    # echo $INFO
    if [[ $1 =~ ^[0-9]+$ ]] && [[ $DEJAR == 0 ]]
      then
        INFO=$($PSQL "SELECT * FROM elements INNER JOIN properties using(atomic_number) INNER JOIN types using(type_id) WHERE elements.atomic_number = $1")
        echo "$INFO" | while read TYPE_NUM BAR AT_NUM BAR SY BAR EL BAR AT_MASS BAR MP BAR BP BAR TYPE
        do
          echo "The element with atomic number $AT_NUM is $EL ($SY). It's a $TYPE, with a mass of $AT_MASS amu. $EL has a melting point of $MP celsius and a boiling point of $BP celsius."
        done
      else 

        NUM=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$1'")
        if [[ $NUM ]]
          then
          INFO=$($PSQL "SELECT * FROM elements INNER JOIN properties using(atomic_number) INNER JOIN types using(type_id) WHERE elements.atomic_number = $NUM")
          echo "$INFO" | while read TYPE_NUM BAR AT_NUM BAR SY BAR EL BAR AT_MASS BAR MP BAR BP BAR TYPE
          do
            echo "The element with atomic number $AT_NUM is $EL ($SY). It's a $TYPE, with a mass of $AT_MASS amu. $EL has a melting point of $MP celsius and a boiling point of $BP celsius."
          done
          else

            NUM=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$1'")
            if [[ $NUM ]]
              then
              INFO=$($PSQL "SELECT * FROM elements INNER JOIN properties using(atomic_number) INNER JOIN types using(type_id) WHERE elements.atomic_number = $NUM")
                echo "$INFO" | while read TYPE_NUM BAR AT_NUM BAR SY BAR EL BAR AT_MASS BAR MP BAR BP BAR TYPE
              do
                echo "The element with atomic number $AT_NUM is $EL ($SY). It's a $TYPE, with a mass of $AT_MASS amu. $EL has a melting point of $MP celsius and a boiling point of $BP celsius."
              done
              else 
              echo "I could not find that element in the database."
        
          fi  
        fi        
    fi
  fi
