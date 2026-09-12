#!/bin/bash
# check-disk.sh
# Surveillance de l espace disque et de l etat du service Nginx.
SEUIL_ALERTE=80
PARTITION="/"

USAGE=$(df -h "$PARTITION" | awk 'NR==2 {print $5}' | tr -d '%')

if [ "$USAGE" -ge "$SEUIL_ALERTE" ]; then
    echo "[ALERTE] Utilisation disque a ${USAGE}% (seuil : ${SEUIL_ALERTE}%)"
else
    echo "[OK] Utilisation disque a ${USAGE}%"
fi

NGINX_STATUS=$(supervisorctl status nginx | awk '{print $2}')
if [ "$NGINX_STATUS" != "RUNNING" ]; then
    echo "[ALERTE] Nginx n'est pas en cours d'execution (etat : $NGINX_STATUS)"
else
    echo "[OK] Nginx fonctionne normalement"
fi
