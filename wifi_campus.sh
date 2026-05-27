#!/bin/bash

echo "=================================================="
echo "   Connexion automatique - Campus Connecté FSR   "
echo "=================================================="

# 1. Demande des identifiants au clavier
read -p "Entrez votre identifiant (ex: prenom.nom@fsr.ac.ma) : " USERNAME
read -s -p "Entrez votre mot de passe : " PASSWORD
echo ""

SSID="Campus Connecte"

echo "-> Nettoyage des anciennes configurations..."
# Supprime l'ancienne connexion si elle existe pour éviter les conflits
nmcli connection delete "$SSID" &>/dev/null

echo "-> Création du nouveau profil Wi-Fi..."
# Création de la connexion WPA2-Entreprise (PEAP / MSCHAPv2)
nmcli connection add \
    type wifi \
    ifname "*" \
    con-name "$SSID" \
    ssid "$SSID" \
    -- \
    wifi-sec.key-mgmt wpa-eap \
    802-1x.eap peap \
    802-1x.phase2-auth mschapv2 \
    802-1x.identity "$USERNAME" \
    802-1x.password "$PASSWORD" \
    lsb.ca-cert "ignore" &>/dev/null

# Si l'université utilise l'ancien protocole (TTLS/PAP), on applique cette variante en secours si la première échoue
if [ $? -ne 0 ]; then
    echo "Ajustement pour protocole alternatif (TTLS/PAP)..."
    nmcli connection add \
        type wifi \
        ifname "*" \
        con-name "$SSID" \
        ssid "$SSID" \
        -- \
        wifi-sec.key-mgmt wpa-eap \
        802-1x.eap ttls \
        802-1x.phase2-auth pap \
        802-1x.identity "$USERNAME" \
        802-1x.password "$PASSWORD"
fi

echo "-> Activation du Wi-Fi..."
nmcli radio wifi on

echo "-> Tentative de connexion au réseau '$SSID'..."
nmcli connection up "$SSID"

if [ $? -eq 0 ]; then
    echo "=================================================="
    echo " 🎉 SUCCÈS ! Vous êtes connecté au Wi-Fi Campus."
    echo "=================================================="
else
    echo "=================================================="
    echo " ❌ ÉCHEC de la connexion."
    echo " Vérifiez vos identifiants ou l'heure de votre PC."
    echo "=================================================="
fi

