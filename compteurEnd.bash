#!/bin/bash

#LECTURE FICHIER DE TEMP DE CONNEXION
	while read ligne
	do
		tpsDebutEnSeconde=$ligne
	done <users/support/desktop/tempDebutSession.txt
#FIN

#HEURE A LA FERMETURE DE LA SESSION
	heureFin=$(date +%H)
	heureFin=${heureFin#0}
	heureFinSeconde=$(($heureFin*3600))
	minuteFin=$(date +%M)
	minuteFin=${minuteFin#0}
	minuteFinSeconde=$(($minuteFin*60))
	secondeFin=$(date +%S)
	secondeFin=${secondeFin#0}
	tpsFinEnSeconde=$(($heureFinSeconde+$minuteFinSeconde+$secondeFin))
#FIN

#CALCUL DU TEMP DE CONNEXION
	tempTotalEnSeconde=$(($tpsFinEnSeconde-$tpsDebutEnSeconde))
	if [ $tempTotalEnSeconde -le 0 ]
		then
		tempTotalEnSeconde=86400-$tpsDebut+$tpsFinEnSeconde 
	fi
	
	heureTotal=0
	minuteTotal=0
	secondeTotal=0

	while [ $tempTotalEnSeconde -ne 0 ]
	do
		if [ $tempTotalEnSeconde -ge 3600 ]
		then
			heureTotal=$(($heureTotal+1))
			tempTotalEnSeconde=$(($tempTotalEnSeconde-3600))
		elif [ $tempTotalEnSeconde -ge 60 ]
		then
			minuteTotal=$(($minuteTotal+1))
			tempTotalEnSeconde=$(($tempTotalEnSeconde-60))
		else
			secondeTotal=$tempTotalEnSeconde
			tempTotalEnSeconde=0
		fi
	done
#FIN

IFS=“/n” #Permet de choisir le séparateur
mois=$(date +%m)
#LECTURE DE compteur$mois.csv
	if [ -e users/support/desktop/compteur$mois.csv ]
	then
		while read ligne
		do
			nbrAct=$(echo $ligne | awk 'BEGIN{FS=";"} {print $1}')
		done <users/support/desktop/compteur$mois.csv
#FIN
	#ECRITURE DANS compteur$mois.csv
		nouveauCompteur=$(($nbrAct+1))
		#echo $nouveauCompteur
		echo $nouveauCompteur\;$heureTotal\;$minuteTotal\;$secondeTotal\;$(date +%d)\;$mois\;$(date +%Y) >> users/support/desktop/compteur$mois.csv
	#FIN
	else 
		echo CONNEXION\;HEURE\;MINUTE\;SECONDE\;JOUR\;MOIS\;ANNEE >> users/support/desktop/compteur$mois.csv
		echo 1\;$heureTotal\;$minuteTotal\;$secondeTotal\;$(date +%d)\;$mois\;$(date +%Y) >> users/support/desktop/compteur$mois.csv
	fi
rm users/support/desktop/tempDebutSession.txt