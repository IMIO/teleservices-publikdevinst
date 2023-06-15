# teleservices-publikdevinst

A Makefile to install and manage a publik-devinst instance with our modules.

## Initial setup of a publik-devinst instance with iMio particuliarities

This is a suggest of steps order to follow to install a publik-devinst instance with our modules.

- Clone publik-devinst repository
- cd into publik-devinst directory
- `make install`
- `make deploy`
- `cd ~/src/imio/teleservices-publikdevinst`
- `make init-imio-src` (see `teleservices-publikdevinst/Makefile` for more details).
- `make init-themes` (see `teleservices-publikdevinst/Makefile` for more details).
- Browser https://hobo.dev.publik.love/theme/ and select the theme you want to use ("iMio (basic)" is our default theme).
- `make create-passerelle-api-user-tout-le-monde` (see `teleservices-publikdevinst/Makefile` for more details).
- `make create-passerelle-pays` (see `teleservices-publikdevinst/Makefile` for more details).
- `make create-hobo-variables` (see `teleservices-publikdevinst/Makefile` for more details).
- `make set-imio-basic-theme` (see `teleservices-publikdevinst/Makefile` for more details).
- `make set-default-email-settings` (see `teleservices-publikdevinst/Makefile` for more details).
- `make alter-site-options` (see `teleservices-publikdevinst/Makefile` for more details).
- `make init-publik-imio-industrialisation` (see `teleservices-publikdevinst/Makefile` for more details).
- `make import-passerelle-casier-judiciaire` (now a prerequisite for `teleservices-package` install).
- `make install-teleservices-package` (see `teleservices-publikdevinst/Makefile` for more details).
- Browser https://wcs.dev.publik.love/backoffice/settings/sitename and update "Redirection de la page d’accueil" to `{{portal_url}}demarches` (see https://docs.imio.be/private/teleservices/cheatsheets/initialisation_base_ia_teleservices/index.html for more details).
- Import the essential roles (see https://gitlab.imio.be/teleservices/maintenance-and-validation-scripts/-/tree/main/apps_setup_assets/authentic_roles)

Optionnal / tool :

- ` make remove-custom-installed-apps-py-files` : remove all `*.py` files addind our modules into `INSTALLED_APPS` (see `teleservices-publikdevinst/Makefile` for more details). Because the clean/delete commands of Publik does not remove them, when you're trying to reinstall the publik-devinst, you can have errors because of these files.

## List of currently available commands

* `make help` : display help about the available commands

## Troubleshooting problems

### ModuleNotFoundError: No module named 'passerelle_imio_abiware' (or other module)

This can occur on a fresh install when you already had publik-devinst installed and you have not yet run `make remove-custom-installed-apps-py-files` to clean all the `*.py` files addind our modules into `INSTALLED_APPS`.

OR you have not yet run `make init-passerelle-modules` to install the modules. See Makefile for more details.

### TLS/SSL errors while using make commands of publik-devinst

You can try to use their `make renew-certificate`. What they don't say is that you need to restart NGINX to make it work. So you can use `service nginx restart` to do so.
