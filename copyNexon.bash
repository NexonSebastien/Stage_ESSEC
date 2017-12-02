#!/bin/bash
rm -R /Users/student*
cp -R /Volumes/SNEXONUSB/ESSEC/compteur/studentperfect /Users/
cp -R /Users/studentperfect /Users/student
cp /Volumes/SNEXONUSB/ESSEC/compteur/.cleanstudent.bash /
chmod +x /.cleanstudent.bash
defaults write com.apple.loginwindow LoginHook /.cleanstudent.bash
#Permet l’intégration du compteur
cp /Volumes/SNEXONUSB/ESSEC/compteur/compteurStart.bash /
cp /Volumes/SNEXONUSB/ESSEC/compteur/compteurEnd.bash /
defaults write com.apple.loginwindow LogoutHook /compteurEnd.bash