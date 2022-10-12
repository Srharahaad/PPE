#!/usr/bin/bash
echo "pour l'année 2016" > sortie.txt
grep "Location" 2016*.ann | wc -l >> sortie.txt
echo "pour l'année 2017" > sortie.txt
grep "Location" 2017*.ann | wc -l >> sortie.txt
echo "pour l'année 2018" > sortie.txt
grep "Location" 2018*.ann | wc -l >> sortie.txt
