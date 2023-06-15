# teleservices-publikdevinst

A Makefile to install and manage a publik-devinst instance with our modules.

## Initial setup of a publik-devinst instance with iMio particuliarities

This is a suggest of steps order to follow to install a publik-devinst instance with our modules.

1. Clone publik-devinst repository
2. cd into publik-devinst directory
3. `make install`
4. `make deploy`
5. `cd ~/src/imio/teleservices-publikdevinst`
6. `make init-imio-src` (see `teleservices-publikdevinst/Makefile` for more details).
7. `make init-themes` (see `teleservices-publikdevinst/Makefile` for more details).
8. Browser https://hobo.dev.publik.love/theme/ and select the theme you want to use ("iMio (basic)" is our default theme).
9. `make create-passerelle-api-user-tout-le-monde` (see `teleservices-publikdevinst/Makefile` for more details).
10. `make create-passerelle-pays` (see `teleservices-publikdevinst/Makefile` for more details).
11. `make create-hobo-variables` (see `teleservices-publikdevinst/Makefile` for more details).
12. `make init-publik-imio-industrialisation` (see `teleservices-publikdevinst/Makefile` for more details).
13. `make install-teleservices-package` (see `teleservices-publikdevinst/Makefile` for more details).


## List of currently available commands

* `make help` : display help about the available commands

## Troubleshooting problems

### ModuleNotFoundError: No module named 'passerelle_imio_abiware' (or other module)

This can occur on a fresh install when you already had publik-devinst installed and you have not yet run `make remove-custom-installed-apps-py-files` to clean all the `*.py` files addind our modules into `INSTALLED_APPS`.

OR you have not yet run `make init-passerelle-modules` to install the modules. See Makefile for more details.

### TLS/SSL errors while using make commands of publik-devinst

You can try to use their `make renew-certificate`. What they don't say is that you need to restart NGINX to make it work. So you can use `service nginx restart` to do so.
