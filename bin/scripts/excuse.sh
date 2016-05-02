#!/bin/sh


BOSS=(
    "Boss"
)

rand=$[ $RANDOM % ${#BOSS[@]} ]
RBOSS=${BOSS[$rand]}

GREETINGS=(
  "Hey $BOSS,"
  "Hi $BOSS,"
  "Hello $BOSS,"
  "Good Morning $BOSS,"
)

SORRY=(
  "I'm sorry I can't make it to work today,"
  "I wanted to warn you that I wouldn't be able to come today,"
  "I'll be unable to work today,"
  "I won't be coming to work today,"
)

EXCUSES=(
  "I fell."
  "I have to attend a funeral"
  "I'm locked out my house."
  "I'm not feeling well."
  "I'm stuck in traffic."
  "I have to go see my mother at the hospital."
  "I have an appointement to the dentist."
  "my fortune cookie said not to."
)

END=(
    "I'll try to work from home."
    "I should be back tomorrow."
)

SIGNATURE=(
    "Antoine PIRIOU\nEPITA 2018"
)

rand=$[ $RANDOM % ${#EXCUSES[@]} ]
RANDOM_EXCUSE=${EXCUSES[$rand]}

rand=$[ $RANDOM % ${#SORRY[@]} ]
RSORRY=${SORRY[$rand]}

rand=$[ $RANDOM % ${#GREETINGS[@]} ]
RGREETINGS=${GREETINGS[$rand]}

rand=$[ $RANDOM % ${#END[@]} ]
REND=${END[$rand]}

rand=$[ $RANDOM % ${#SIGNATURE[@]} ]
RSIGNATURE=${SIGNATURE[$rand]}

MESSAGE="$RGREETINGS\n\n$RSORRY $RANDOM_EXCUSE\n\n$REND\n\n-- \n$RSIGNATURE"
echo -e "$MESSAGE"
