#!/bin/bash
heure=$(date +%H)
heure=${heure#0}
heureSeconde=$(($heure*3600))
minute=$(date +%M)
minute=${minute#0}
minuteSeconde=$(($minute*60))
seconde=$(date +%S)
seconde=${seconde#0}
tpsDebutEnSeconde=$(($heureSeconde+$minuteSeconde+$seconde))
echo $tpsDebutEnSeconde >> users/support/desktop/tempDebutSession.txt