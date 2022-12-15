#!/bin/bash

if [[ $(find ./hosts -mmin +2) ]]
then
  echo "found"
fi