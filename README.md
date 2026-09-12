Sécurisation d'un serveur Linux, mission Excellence Cyber

En bref,
Pendant une semaine (25 au 31 août 2026), j'ai joué le rôle d'un administrateur
système junior chargé de sécuriser, de A à Z, le serveur d'un service comptabilité
fictif. L'objectif : appliquer les mêmes réflexes qu'un vrai professionnel,
étape par étape, en testant réellement chaque protection.

Environnement : un serveur Linux (Ubuntu 24.04) dans un conteneur Docker isolé,
pour pouvoir expérimenter sans aucun risque.

Chronologie

| Jour | Ce qui a été fait |
|------|--------------------|
| Jour 1 | Réseau dédié, création des comptes, connexion SSH sécurisée par clés, pare-feu |
| Jour 2 | Séparation des données par service (permissions, héritage automatique) |
| Jour 3 | Sauvegardes chiffrées automatiques + test réel de restauration |
| Jour 4 | Service web toujours disponible, avec redémarrage automatique en cas de panne |
| Jour 5 | Historique des connexions, pour savoir qui a fait quoi et quand |
| Jour 6 | Un incident (facture suspecte) signalé et investigué comme un vrai cas réel |
| Jour 7 | Vérification finale complète et rapport de fin de mission |

Ce qui a été mis en place:

Les accès : chaque administrateur a sa propre clé secrète pour se connecter,
comme une clé personnelle plutôt qu'un mot de passe partagé. Impossible de se
connecter sans cette clé, et impossible de se connecter en tant que super-utilisateur
directement.

Le pare-feu : seul un petit groupe d'adresses autorisées peut même essayer de
se connecter au serveur, tout le reste est bloqué par défaut.

Les sauvegardes : chaque nuit, les données sont copiées, verrouillées avec un
mot de passe (chiffrement), et les sauvegardes de plus de 7 jours sont supprimées
automatiquement. J'ai vérifié que ça marche vraiment en simulant une perte totale
des données et en les restaurant depuis une sauvegarde, avec succès.

La résilience : si le service web plantait, il redémarrait tout seul en moins
d'une seconde. Testé en le tuant volontairement pour vérifier.

La traçabilité : on peut savoir précisément qui s'est connecté, quand, et
depuis où.

La gestion d'incident : un faux incident a été signalé (un client dit avoir
reçu une facture qu'il n'a jamais commandée). J'ai mené une vraie investigation
(sans connaître la réponse à l'avance) et conclu, preuves à l'appui, qu'aucune
compromission du serveur n'était en cause.

Fichiers

- `onboard_user.sh` : création des comptes administrateurs et de service
- `backup.sh` : sauvegarde chiffrée automatique avec rotation
- `check-disk.sh` : surveillance de l'espace disque et du service web
- `docs/rapport-mission.pdf` : le rapport complet, jour par jour

Note d'honnêteté : les fichiers de script ci-dessus ont été reconstitués après la
suppression du conteneur qui les hébergeait. Ils reproduisent fidèlement les
commandes et le comportement documentés dans le rapport original (voir le PDF),
sans rien ajouter qui n'ait pas été réellement fait.
