#!/usr/bin/bash
echo "pour l'année $1" > sortie.txt
grep "$2" $1*.ann | wc -l >> sortie.txt
