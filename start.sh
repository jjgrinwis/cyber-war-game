#!/bin/bash
while true
do
   terraform apply -auto-approve
   sleep 60
   terraform destroy -auto-approve
done
