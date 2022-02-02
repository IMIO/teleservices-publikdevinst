# teleservices-publikdevinst

At the moment it is just a Makefile who will init a Teleservices app starting with a Publik developer install on a Debian VM.

## List of currently available commands

* `git-config`

Attention, modifiez `user.email` et `user.name` dans le Makefile avant de lancer cette commande.
Initialise la config globale pour git et quelques alias plus ou moins utiles.

* `install-utils`

Ajoute les sources pour instaler VSCode et l'installe, ainsi que git, vim, ansible, imagemagick, pngquant.

* `init-themes`

Clone le repo si on a pas déjà lancé `make init-imio-src` et quoi qu'il en soit init le submodule publik-base-theme, crée un lien symbolique pour qu'on puisse sass et make depuis les sources.
Contrairement à ce qu'on fait dans docker, il n'y a ici rien à changer dans les fichiers *.scss pour que les modifications apparaissent sur l'instance de développement.

* `init-imio-src`

Initialise les sources courament employées dans l'équipe Téléservices.

* `init-passerelle-modules`

Nécéssite d'avoir déjà initié les repositories avec `init-imio-src`.

Va itérer à travers les sources et installer les paquets python, déloyer les fichiers *.py dans les settings.d, effectuer les migrations et redémarrer le service avec `supervisorctl`.

* `build-e-guichet`

Équivalent du build-e-guichet.sh adapté pour le Makefile et l'environnement développeur Publik.
Le lancer plusieurs fois ne pose pas de problème mais il faudra probablement commenter un élément (une line) alors bloquante.

* `init-publik-imio-industrialisation`

Le Makefile d'Entr'Ouvert à la racine du repository publik-imio-industrialisation sert à installer ce paquet dans l'environnement iMio. Les quelques commandes dans le présent Makefile pour ceci permettent de simuler l'installation.

* `init-teleservices-package`

Équivalent de `./install_teleservice_package.sh` dans un container iMio.

* `update-teleservices-package`

Fait un git pull des sources initialiées par `make init-imio-src` puis redéploie le package afin de le mettre à jour dans l'instance Publik.

* `clean-imio-src`

Supprime tout ce que contiend `~/src/imio`.
