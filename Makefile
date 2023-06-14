imio_src = ~/src/imio
build-e-guichet = ~/src/imio/scripts-teleservices/scripts_teleservices/build-e-guichet/datasources/passerelle_legacy_motifs_et_destinations.json
wcs_tenant = /var/lib/wcs/tenants/wcs.dev.publik.love
publik-env-py3 = /home/${USER}/envs/publik-env-py3/
build-e-guichet_path = /home/${USER}/src/imio/scripts-teleservices/scripts_teleservices/build-e-guichet/

help:
# list commands
	@echo "- make init-imio-src: Fetch all the teleservices related repositories (see Makefile for details)"
	@echo "- make install-passerelle-modules-with-dev-mode: Install the passerelle modules in dev mode using publik-env-py3 (Entr'Ouvert venv used by publik-devinst, see Makefile for details)"
	@echo "  This will also do : cp -r /home/${USER}/src/imio/teleservices-publikdevinst/settingsd_files/passerelle/*.py /home/${USER}/.config/publik/settings/passerelle/settings.d/ do add theses packages to relevant django INSTALLED_APPS."
	@echo "- make migrate-passerelle-schemas: Migrate the passerelle schemas."
	@echo "  This will run '~/envs/publik-env-py3/bin/passerelle-manage migrate_schemas' to properly make passerelle modules available in the Publik backoffice."
	@echo "  Then it will restart the django service using 'sudo supervisorctl restart django:passerelle'."
	@echo "- make set-default-position: Patch site-options.json to apply a lat/lon (Geodata) default_position setting under [options]."
	@echo "- make import-passerelle-motifs-et-destinations-ts1: Import legacy 'ts1_datasource' passerelle module (motifs et destinations)..."
	@echo "- make create-passerelle-api-user-tout-le-monde: Create passerelle API user 'tout-le-monde'"
	@echo "- make create-passerelle-pays: Create "Pays" passerelle"
	@echo "- make create-hobo-variables: Create Hobo variables"
	@echo "- make init-publik-imio-industrialisation: Make it work on a fresh publik-devinst."
	@echo "- make install-teleservices-package: Install teleservices package in publik-devinst."
	@echo "- make init-portail-parent: Install portail-parent package in publik-devinst."
	@echo "- make update-teleservices-package: Update teleservices package in publik-devinst."
	@echo "- make install-townstreet: Install townstreet package in publik-devinst."
	@echo "- make import-townstreet-passerelle: Import townstreet passerelle module."


init-themes:
# Init imio-publik-themes and make themes avalaible in Publik
	test -s ${imio_src}/imio-publik-themes || git clone gitea@git.entrouvert.org:entrouvert/imio-publik-themes.git ${imio_src}/imio-publik-themes
	test -s /usr/local/share/publik-devinst/themes/imio || sudo ln -s ${imio_src}/imio-publik-themes /usr/local/share/publik-devinst/themes/imio
	cd /usr/local/share/publik-devinst/themes/imio;git submodule update --init --recursive;make;cd -

init-imio-src:
# Fetch all the teleservices related repositories
	test -s ${imio_src} || mkdir ${imio_src}
	test -s ${imio_src}/combo-plugin-imio-townstreet || git clone gitea@git.entrouvert.org:entrouvert/combo-plugin-imio-townstreet.git/ ${imio_src}/combo-plugin-imio-townstreet
	test -s ${imio_src}/documentation-imio || git clone git@gitlab.imio.be:imio/documentation-imio.git ${imio_src}/documentation-imio
	test -s ${imio_src}/documentation-interne || git clone git@gitlab.imio.be:imio/documentation-interne.git ${imio_src}/documentation-interne
	test -s ${imio_src}/imio-api-bewapp-endpoints || git clone git@gitlab.imio.be:imio-api/imio-api-bewapp-endpoints.git ${imio_src}/imio-api-bewapp-endpoints
	test -s ${imio_src}/imio-api-bosa-endpoints || git clone git@gitlab.imio.be:imio-api/imio-api-bosa-endpoints.git ${imio_src}/imio-api-bosa-endpoints
	test -s ${imio_src}/imio-api-imio-aes-endpoints || git clone git@gitlab.imio.be:imio-api/imio-api-imio-aes-endpoints.git ${imio_src}/imio-api-imio-aes-endpoints
	test -s ${imio_src}/imio-api-imio-authentic-endpoints || git clone git@gitlab.imio.be:imio-api/imio-api-imio-authentic-endpoints.git ${imio_src}/imio-api-imio-authentic-endpoints
	test -s ${imio_src}/imio-api-imio-procedures-townstreet-endpoints || git clone git@gitlab.imio.be:imio-api/imio-api-imio-procedures-townstreet-endpoints.git ${imio_src}/imio-api-imio-procedures-townstreet-endpoints
	test -s ${imio_src}/imio-api-imio-taxonomies-endpoints || git clone git@gitlab.imio.be:imio-api/imio-api-imio-taxonomies-endpoints.git ${imio_src}/imio-api-imio-taxonomies-endpoints
	test -s ${imio_src}/imio.behavior.teleservices || git clone git@github.com:IMIO/imio.behavior.teleservices.git ${imio_src}/imio.behavior.teleservices
	test -s ${imio_src}/imio-publik-themes || git clone gitea@git.entrouvert.org:entrouvert/imio-publik-themes.git ${imio_src}/imio-publik-themes
	test -s ${imio_src}/imio-townstreet || git clone git@github.com:IMIO/imio-townstreet.git ${imio_src}/imio-townstreet
	test -s ${imio_src}/imio-townstreet-tests || git clone git@gitlab.imio.be:teleservices/townstreet/imio-townstreet-tests.git ${imio_src}/imio-townstreet-tests
	test -s ${imio_src}/imio-townstreet-maintenance || git clone git@gitlab.imio.be:teleservices/townstreet/imio-townstreet-maintenance.git ${imio_src}/imio-townstreet-maintenance
	test -s ${imio_src}/imio-ts-aes || git clone git@github.com:IMIO/imio-ts-aes.git ${imio_src}/imio-ts-aes
	test -s ${imio_src}/industrialisation || git clone git@gitlab.imio.be:infra/industrialisation.git ${imio_src}/industrialisation
	test -s ${imio_src}/instances-checker || git clone git@gitlab.imio.be:teleservices/instances-checker.git ${imio_src}/instances-checker
	test -s ${imio_src}/issh || git clone git@gitlab.imio.be:infra/issh.git ${imio_src}/issh
	test -s ${imio_src}/jenkins-pipeline-scripts || git clone git@gitlab.imio.be:infra/jenkins/jenkins-pipeline-scripts.git ${imio_src}/jenkins-pipeline-scripts
	test -s ${imio_src}/locust-teleservices || git clone git@gitlab.imio.be:teleservices/locust-teleservices.git ${imio_src}/locust-teleservices
	test -s ${imio_src}/scripts-teleservices || git clone git@github.com:IMIO/scripts-teleservices.git ${imio_src}/scripts-teleservices
	test -s ${imio_src}/teleservices-german-translations || git clone git@github.com:IMIO/teleservices-german-translations.git ${imio_src}/teleservices-german-translations
	test -s ${imio_src}/teleservices-package || git clone git@github.com:IMIO/teleservices-package.git ${imio_src}/teleservices-package
	test -s ${imio_src}/teleservices-publikdevinst || git clone git@github.com:IMIO/teleservices-publikdevinst.git ${imio_src}/teleservices-publikdevinst
	test -s ${imio_src}/teleservices-scripts-selenium || git clone git@github.com:IMIO/teleservices-scripts-selenium.git ${imio_src}/teleservices-scripts-selenium
	test -s ${imio_src}/passerelle-imio-abiware || git clone git@github.com:IMIO/passerelle-imio-abiware.git ${imio_src}/passerelle-imio-abiware
	test -s ${imio_src}/passerelle-imio-apims-baec || git clone git@github.com:IMIO/passerelle-imio-apims-baec.git ${imio_src}/passerelle-imio-apims-baec
	test -s ${imio_src}/passerelle-imio-extra-fees || git clone gitea@git.entrouvert.org:entrouvert/passerelle-imio-extra-fees.git/ ${imio_src}/passerelle-imio-extra-fees
	test -s ${imio_src}/passerelle-imio-aes-meal || git clone git@github.com:IMIO/passerelle-imio-aes-meal.git ${imio_src}/passerelle-imio-aes-meal
	test -s ${imio_src}/passerelle-imio-aes-health || git clone git@github.com:IMIO/passerelle-imio-aes-health.git ${imio_src}/passerelle-imio-aes-health
	test -s ${imio_src}/passerelle-imio-ia-aes || git clone git@github.com:IMIO/passerelle-imio-ia-aes.git ${imio_src}/passerelle-imio-ia-aes
	test -s ${imio_src}/passerelle-imio-ia-tech || git clone git@github.com:IMIO/passerelle-imio-ia-tech.git ${imio_src}/passerelle-imio-ia-tech
	test -s ${imio_src}/passerelle-imio-ia-delib || git clone git@github.com:IMIO/passerelle-imio-ia-delib.git ${imio_src}/passerelle-imio-ia-delib
	test -s ${imio_src}/passerelle-imio-liege-lisrue || git clone gitea@git.entrouvert.org:entrouvert/passerelle-imio-liege-lisrue.git/ ${imio_src}/passerelle-imio-liege-lisrue
	test -s ${imio_src}/passerelle-imio-liege-rn || git clone gitea@git.entrouvert.org:entrouvert/passerelle-imio-liege-rn.git ${imio_src}/passerelle-imio-liege-rn
	test -s ${imio_src}/passerelle-imio-sso-agents || git clone git@github.com:IMIO/passerelle-imio-sso-agents.git/ ${imio_src}/passerelle-imio-sso-agents
	test -s ${imio_src}/passerelle-imio-tax-compute || git clone gitea@git.entrouvert.org:entrouvert/passerelle-imio-tax-compute.git/ ${imio_src}/passerelle-imio-tax-compute
	test -s ${imio_src}/passerelle-imio-ts1-datasources || git clone gitea@git.entrouvert.org:entrouvert/passerelle-imio-ts1-datasources.git/ ${imio_src}/passerelle-imio-ts1-datasources
	test -s ${imio_src}/passerelle-imio-wca|| git clone git@github.com:IMIO/passerelle-imio-wca.git ${imio_src}/passerelle-imio-wca
	test -s ${imio_src}/publik-imio-industrialisation || git clone gitea@git.entrouvert.org:entrouvert/publik-imio-industrialisation.git/ ${imio_src}/publik-imio-industrialisation
	test -s ${imio_src}/sauron || git clone git@gitlab.imio.be:teleservices/sauron.git ${imio_src}/sauron
	test -s ${imio_src}/simple-form-post-1 || git clone git@gitlab.imio.be:teleservices/testing/simple-form-post-1.git ${imio_src}/simple-form-post-1
	test -s ${imio_src}/simple-form-pull-1 || git clone git@gitlab.imio.be:teleservices/testing/simple-form-pull-1.git ${imio_src}/simple-form-pull-1
	test -s ${imio_src}/wcs-scripts-teleservices || git clone git@github.com:IMIO/wcs-scripts-teleservices.git ${imio_src}/wcs-scripts-teleservices
	cp ${imio_src}/teleservices-publikdevinst/git-pull-recursif.sh ${imio_src}/git-pull-recursif.sh
	chmod +x ${imio_src}/git-pull-recursif.sh
	echo "✅ All repositories related to iA.Téléservices seems to have been set inside ${imio_src}\n Whenever you want to recursively git pull all the subdirectories :\n run git-pull-recursif.sh to easily keep all the stuff up to date! Keep up the good work and have a nice day! 🌞"

# This will install all the modules in dev mode
# with the publik-env-py3 virtualenv and pip
install-passerelle-modules-with-dev-mode:
	cd ~/src/imio/passerelle-imio-abiware;~/envs/publik-env-py3/bin/pip install -e .
	cd ~/src/imio/passerelle-imio-aes-health;~/envs/publik-env-py3/bin/pip install -e .
	cd ~/src/imio/passerelle-imio-aes-meal;~/envs/publik-env-py3/bin/pip install -e .
	cd ~/src/imio/passerelle-imio-apims-baec;~/envs/publik-env-py3/bin/pip install -e .
	cd ~/src/imio/passerelle-imio-extra-fees;~/envs/publik-env-py3/bin/pip install -e .
	cd ~/src/imio/passerelle-imio-ia-delib;~/envs/publik-env-py3/bin/pip install -e .
	cd ~/src/imio/passerelle-imio-ia-aes;~/envs/publik-env-py3/bin/pip install -e .
	cd ~/src/imio/passerelle-imio-ia-tech;~/envs/publik-env-py3/bin/pip install -e .
	cd ~/src/imio/passerelle-imio-liege-lisrue;~/envs/publik-env-py3/bin/pip install -e .
	cd ~/src/imio/passerelle-imio-liege-rn;~/envs/publik-env-py3/bin/pip install -e .
	cd ~/src/imio/passerelle-imio-tax-compute;~/envs/publik-env-py3/bin/pip install -e .
	cd ~/src/imio/passerelle-imio-ia-tech;~/envs/publik-env-py3/bin/pip install -e .
	cd ~/src/imio/passerelle-imio-sso-agents;~/envs/publik-env-py3/bin/pip install -e .
	cd ~/src/imio/passerelle-imio-ts1-datasources;~/envs/publik-env-py3/bin/pip install -e .
	cd ~/src/imio/passerelle-imio-wca;~/envs/publik-env-py3/bin/pip install -e .
	cp -r /home/${USER}/src/imio/teleservices-publikdevinst/settingsd_files/passerelle/*.py /home/${USER}/.config/publik/settings/passerelle/settings.d/

# This will apply django migrations for all the modules
# using publik-env-py3/bin/passerelle-manage migrate_schemas
migrate-passerelle-schemas:
	~/envs/publik-env-py3/bin/passerelle-manage migrate_schemas
	sudo supervisorctl restart django:passerelle

# Define variables for default_position settings (patching site-options.cfg)
# And set default position settings after '[options]' in the site-options.cfg file
default_position_settings = default_position = 50.4988;4.7199
site_option_path = /var/lib/wcs/tenants/wcs.dev.publik.love/site-options.cfg

add-default-pos-settings:
	if grep -q "\[options\]" ${site_option_path}; then \
		grep -qxF "${default_position_settings}" ${site_option_path} || sed -i "/\[options\]/a\\${default_position_settings}" ${site_option_path}; \
	else \
		echo "❌ '[options]' not found in ${site_option_path}, cannot set default position."; \
	fi

verify-default-pos-settings:
	if grep -qxF "${default_position_settings}" ${site_option_path}; then \
		echo "✅ Default position set successfully."; \
	else \
		echo "❌ Failed to set default position."; \
	fi

set-default-position: add-default-pos-settings verify-default-pos-settings

# Import legacy "ts1_datasource" passerelle
# module (motifs et destinations)
import-passerelle-motifs-et-destinations-ts1:
	@echo "Importing legacy 'ts1_datasource' passerelle module (motifs et destinations)..."
	${publik-env-py3}bin/passerelle-manage tenant_command import_site --overwrite -d passerelle.dev.publik.love /home/${USER}/src/imio/scripts-teleservices/scripts_teleservices/build-e-guichet/datasources/passerelle_legacy_motifs_et_destinations.json

create-passerelle-api-user-tout-le-monde:
	@echo "Creating passerelle API user 'tout-le-monde'..."
	${publik-env-py3}bin/passerelle-manage tenant_command runscript ${build-e-guichet_path}/passerelle/build-api-user.py -d passerelle.dev.publik.love

create-passerelle-pays:
	@echo "Creating passerelle pays..."
	${publik-env-py3}bin/passerelle-manage tenant_command import_site --overwrite --import-users -d passerelle.dev.publik.love ${build-e-guichet_path}/passerelle/pays.json

create-hobo-variables:
	@echo "Creating hobo variables..."
	${publik-env-py3}bin/hobo-manage tenant_command runscript -d hobo.dev.publik.love ${build-e-guichet_path}/hobo_create_variables.py

init-publik-imio-industrialisation:
# publik-imio-industrialisation make install does not install-teleservices-packagework with publik-devinst (see #57805)
	cp ~/src/imio/publik-imio-industrialisation/combo/*.py ~/src/combo/combo/data/management/commands/
	cp ~/src/imio/publik-imio-industrialisation/hobo/*.py ~/src/hobo/hobo/environment/management/commands/
	cp ~/src/imio/publik-imio-industrialisation/wcs/*.py ~/src/wcs/wcs/ctl/

install-teleservices-package:
	${publik-env-py3}bin/hobo-manage imio_indus_deploy -d hobo.dev.publik.love --directory ${imio_src}/teleservices-package/teleservices_package

init-portail-parent:
	${publik-env-py3}bin/hobo-manage imio_indus_deploy -d hobo.dev.publik.love --directory ${imio_src}/imio-ts-aes/imio_ts_aes

update-teleservices-package:
	cd ~/src/imio/teleservices-package
	git pull
	cd -
	make install-teleservices-package

install-townstreet:
	${publik-env-py3}bin/hobo-manage imio_indus_deploy -d hobo.dev.publik.love --directory ${imio_src}/imio-townstreet/imio_townstreet/

import-townstreet-passerelle:
	${publik-env-py3}bin/passerelle-manage tenant_command import_site -d passerelle.dev.publik.love ${imio_src}/teleservices-publikdevinst/passerelle_elements/export_passerelle-imio-ia-tech_atal-demov6_20220228.json --import-users
