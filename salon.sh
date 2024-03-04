#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c "

echo -e "\n~~~~  Welcome to our Salon  ~~~~\n"


MAIN_MENU () {
  echo -e "Please select from the available options:\n"
  # list services
  echo -e "\n1) Haircut \n2) Perm \n3) Color \n4) Shave \n5) Exit"
  read SERVICE_ID_SELECTED
  case $SERVICE_ID_SELECTED in
    1) APPOINTMENT_MENU;;
    2) APPOINTMENT_MENU;;
    3) APPOINTMENT_MENU;;
    4) APPOINTMENT_MENU;;
    5) EXIT ;;
    *) MAIN_MENU "Please select a valid option." ;;
  esac
  # not on list try again
  # on list get info
  # first phone number
  #if no number register name and number
  # make appointment 
  
}
APPOINTMENT_MENU () {
  SERVICE_NAME=$($PSQL "select name from services where service_id = '$SERVICE_ID_SELECTED'")
  echo -e "\nI see that you'd like a $SERVICE_NAME"
  echo -e "\nPlease enter your phone number:"
  read CUSTOMER_PHONE
  CUSTOMER_NAME=$($PSQL "select name from customers where phone = '$CUSTOMER_PHONE'")
  if [[ -z $CUSTOMER_NAME ]]
  then
    echo -e "\nYou must be a first time customer."
    echo -e "\nPlease enter you name"
    read CUSTOMER_NAME
   
    echo -e "Thank you $CUSTOMER_NAME"
    $PSQL "insert into customers(name,phone) values('$CUSTOMER_NAME','$CUSTOMER_PHONE')"

  fi
  echo -e "\nAt what time would you like your$SERVICE_NAME, $CUSTOMER_NAME?"
  read SERVICE_TIME
  CUSTOMER_ID=$($PSQL "select customer_id from customers where phone = '$CUSTOMER_PHONE'")
  echo $CUSTOMER_NAME
  echo $CUSTOMER_ID
  echo $SERVICE_TIME
  $PSQL "insert into appointments(customer_id,service_id,time) values($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')"
  echo -e "I have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
  EXIT
 }
EXIT () {
  echo -e "\nThank you for visiting us today."
}

MAIN_MENU