#!/usr/bin/env bash
#---INFO---
#Le programme teste qu'il y a le bon nombre d'arguments et retourne un message d'erreur sinon
#Le programme génère le fichier html contenant les informations sur les urls du fichier en argument

#---SETUP---
if [ $# -eq 2 ]
then
	echo "Traitement en cours...";
else
	echo "Il y a un problème avec les arguments. Vérifiez bien qu'il y a seulement deux arguments, le premier étant le fichier d'urls et le second la sortie.";
	exit;
fi
fichier_urls=$1; # le fichier d'URL en entrée
fichier_tableau=$2; # le fichier HTML en sortie
search="(I|i)mmigration"; # la regex de recherche pour le mot

#---TRAITEMENT---
echo "<html><head><meta charset=\"UTF-8\" /><title>Tableaux</title></head><body><table><tr><th>ligne</th><th>code</th><th>encodage</th><th>word count</th><th>URL</th></tr>" > $fichier_tableau
linenum=1;
while read -r line
do
	echo "<tr><td>$linenum</td><td>" >> $fichier_tableau;
	curl -I -s $line | egrep "^HTTP" | egrep -o "[0-9]{3}" >> $fichier_tableau;
	echo "</td><td>" >> $fichier_tableau;
	charset=$(curl -I -s $line | grep -Po "charset=[\w-]+" | grep -Po "=[\w-]+" | egrep -o "[^=]+");
	if [ ! $charset ]
	then
		charset="Utf-8";
	fi
	echo $charset >> $fichier_tableau;
	echo "</td><td>" >> $fichier_tableau;
	lynx -dump -nolist -assume_charset=$charset $line | egrep -c $search >> $fichier_tableau;
	echo "</td><td>$line</td></tr>" >> $fichier_tableau;
	linenum=$((linenum+1));
done < $fichier_urls
echo "</table></body></html>" >> $fichier_tableau;
echo "Traitement terminé.";
exit;