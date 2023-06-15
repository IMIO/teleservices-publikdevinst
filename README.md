# teleservices-publikdevinst

A Makefile to install and manage a publik-devinst instance with our modules.
## List of currently available commands

* `make help` : display help about the available commands

## Troubleshooting problems

### ModuleNotFoundError: No module named 'passerelle_imio_abiware' (or other module)

This can occur on a fresh install when you already had publik-devinst installed and you have not yet run `make remove-custom-installed-apps-py-files` to clean all the `*.py` files addind our modules into `INSTALLED_APPS`.

OR you have not yet run `make init-passerelle-modules` to install the modules. See Makefile for more details.
