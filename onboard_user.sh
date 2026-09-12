#!/bin/bash
set -e

if [ "$#" -ne 2 ]; then
    echo "Usage : $0 <nom_utilisateur> <role: admin|service>"
    exit 1
fi

USERNAME="$1"
ROLE="$2"

case "$ROLE" in
    admin)
        useradd -m -s /bin/bash -c "Compte admin" "$USERNAME"
        usermod -aG sudo "$USERNAME"
        mkdir -p "/home/$USERNAME/.ssh"
        chmod 700 "/home/$USERNAME/.ssh"
        touch "/home/$USERNAME/.ssh/authorized_keys"
        chmod 600 "/home/$USERNAME/.ssh/authorized_keys"
        chown -R "$USERNAME:$USERNAME" "/home/$USERNAME/.ssh"
        echo "Compte admin $USERNAME cree. Deposer sa cle publique dans authorized_keys."
        ;;
    service)
        useradd -r -s /usr/sbin/nologin -c "Compte de service" "$USERNAME"
        echo "Compte de service $USERNAME cree (sans connexion interactive)."
        ;;
    *)
        echo "Role inconnu : utiliser admin ou service"
        exit 1
        ;;
esac
