git-config:
	git config --global user.email "daniel.muyshond@imio.be"
	git config --global user.name "Daniel Muyshond"
	git config --global alias.st 'status'
	git config --global alias.ll 'log --oneline'
	git config --global alias.cm 'commit -m'
	git config --global alias.last 'log -1 HEAD --stat' # output last commit
	git config --global alias.rv 'remote -v'
	git config --global alias.d 'diff'
	git config --global alias.gl 'config --global -l' # list all git aliases
	git config --global alias.se '!git rev-list --all | xargs git grep -F' # search specific strings in your commits
	git gl

install-utils:
## VSCode
# Install dependencies
	sudo apt update && sudo apt upgrade
	sudo apt install git vim ansible imagemagick pngquant
	sudo apt install software-properties-common apt-transport-https curl python3-venv -y
# Import GPG keys and Visual Studio repository
	curl -sSL https://packages.microsoft.com/keys/microsoft.asc -o microsoft.asc
	gpg --no-default-keyring --keyring ./ms_signing_key_temp.gpg --import ./microsoft.asc
	gpg --no-default-keyring --keyring ./ms_signing_key_temp.gpg --export > ./ms_signing_key.gpg
	sudo mv ms_signing_key.gpg /etc/apt/trusted.gpg.d/
# Import the VSCode source repository
	echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
	# Finally install VSCode and output version
	sudo apt update && sudo apt install code -y
	code --version
# Install Google Chrome
	wget -nc https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo apt install ./google-chrome-stable_current_amd64.deb -y
	rm ./google-chrome-stable_current_amd64.deb

folder = ~/src/imio

init-themes:
# Init imio-publik-themes and make themes avalaible in Publik
	test -s ${folder}/imio-publik-themes || git clone https://git.entrouvert.org/imio-publik-themes.git/ ${folder}/imio-publik-themes
	test -s /usr/local/share/publik-devinst/themes/imio || sudo ln -s ${folder}/imio-publik-themes /usr/local/share/publik-devinst/themes/imio
	cd /usr/local/share/publik-devinst/themes/imio;git submodule update --init --recursive;make;cd -

init-imio-src:
# Fetch all the teleservices related repositories
	test -s ${folder} || mkdir ${folder}
	# common teleservices repositories
	test -s ${folder}/combo-plugin-imio-townstreet || git clone https://git.entrouvert.org/combo-plugin-imio-townstreet.git/ ${folder}/combo-plugin-imio-townstreet
	test -s ${folder}/documentation-imio || git clone git@gitlab.imio.be:imio/documentation-imio.git ${folder}/documentation-imio
	test -s ${folder}/documentation-interne || git clone git@gitlab.imio.be:imio/documentation-interne.git ${folder}/documentation-interne
	test -s ${folder}/imio-api-bewapp-endpoints || git clone git@gitlab.imio.be:imio-api/imio-api-bewapp-endpoints.git ${folder}/imio-api-bewapp-endpoints
	test -s ${folder}/imio-api-bosa-endpoints || git clone git@gitlab.imio.be:imio-api/imio-api-bosa-endpoints.git ${folder}/imio-api-bosa-endpoints
	test -s ${folder}/imio-api-imio-aes-endpoints || git clone git@gitlab.imio.be:imio-api/imio-api-imio-aes-endpoints.git ${folder}/imio-api-imio-aes-endpoints
	test -s ${folder}/imio-api-imio-authentic-endpoints || git clone git@gitlab.imio.be:imio-api/imio-api-imio-authentic-endpoints.git ${folder}/imio-api-imio-authentic-endpoints
	test -s ${folder}/imio-api-imio-procedures-townstreet-endpoints || git clone git@gitlab.imio.be:imio-api/imio-api-imio-procedures-townstreet-endpoints.git ${folder}/imio-api-imio-procedures-townstreet-endpoints
	test -s ${folder}/imio-api-imio-taxonomies-endpoints || git clone git@gitlab.imio.be:imio-api/imio-api-imio-taxonomies-endpoints.git ${folder}/imio-api-imio-taxonomies-endpoints
	test -s ${folder}/imio.behavior.teleservices || git clone git@github.com:IMIO/imio.behavior.teleservices.git ${folder}/imio.behavior.teleservices
	test -s ${folder}/imio-publik-themes || git clone https://git.entrouvert.org/imio-publik-themes.git/ ${folder}/imio-publik-themes
	test -s ${folder}/imio-townstreet || git clone git@github.com:IMIO/imio-townstreet.git ${folder}/imio-townstreet
	test -s ${folder}/imio-townstreet-tests || git clone git@gitlab.imio.be:teleservices/townstreet/imio-townstreet-tests.git ${folder}/imio-townstreet-tests
	test -s ${folder}/imio-townstreet-maintenance || git clone git@gitlab.imio.be:teleservices/townstreet/imio-townstreet-maintenance.git ${folder}/imio-townstreet-maintenance
	test -s ${folder}/imio-ts-aes || git clone git@github.com:IMIO/imio-ts-aes.git ${folder}/imio-ts-aes
	test -s ${folder}/industrialisation || git clone git@gitlab.imio.be:infra/industrialisation.git ${folder}/industrialisation
	test -s ${folder}/instances-checker || git clone git@gitlab.imio.be:teleservices/instances-checker.git ${folder}/instances-checker
	test -s ${folder}/issh || git clone git@gitlab.imio.be:infra/issh.git ${folder}/issh
	test -s ${folder}/jenkins-pipeline-scripts || git clone git@gitlab.imio.be:infra/jenkins/jenkins-pipeline-scripts.git ${folder}/jenkins-pipeline-scripts
	test -s ${folder}/locust-teleservices || git clone git@gitlab.imio.be:teleservices/locust-teleservices.git ${folder}/locust-teleservices
	test -s ${folder}/scripts-teleservices || git clone git@github.com:IMIO/scripts-teleservices.git ${folder}/scripts-teleservices
	test -s ${folder}/teleservices-german-translations || git clone git@github.com:IMIO/teleservices-german-translations.git ${folder}/teleservices-german-translations
	test -s ${folder}/teleservices-package || git clone git@github.com:IMIO/teleservices-package.git ${folder}/teleservices-package
	test -s ${folder}/teleservices-publikdevinst || git clone git@github.com:IMIO/teleservices-publikdevinst.git ${folder}/teleservices-publikdevinst
	test -s ${folder}/teleservices-scripts-selenium || git clone git@github.com:IMIO/teleservices-scripts-selenium.git ${folder}/teleservices-scripts-selenium
	test -s ${folder}/passerelle-imio-apims-baec || git clone git@github.com:IMIO/passerelle-imio-apims-baec.git ${folder}/passerelle-imio-apims-baec
	test -s ${folder}/passerelle-imio-extra-fees || git clone https://git.entrouvert.org/passerelle-imio-extra-fees.git/ ${folder}/passerelle-imio-extra-fees
	test -s ${folder}/passerelle-imio-aes-meal || git clone git@github.com:IMIO/passerelle-imio-aes-meal.git ${folder}/passerelle-imio-aes-meal
	test -s ${folder}/passerelle-imio-aes-health || git clone git@github.com:IMIO/passerelle-imio-aes-health.git ${folder}/passerelle-imio-aes-health
	test -s ${folder}/passerelle-imio-ia-aes || git clone git@github.com:IMIO/passerelle-imio-ia-aes.git ${folder}/passerelle-imio-ia-aes
	test -s ${folder}/passerelle-imio-ia-tech || git clone git@github.com:IMIO/passerelle-imio-ia-tech.git ${folder}/passerelle-imio-ia-tech
	test -s ${folder}/passerelle-imio-ia-delib || git clone git@github.com:IMIO/passerelle-imio-ia-delib.git ${folder}/passerelle-imio-ia-delib
	test -s ${folder}/passerelle-imio-liege-lisrue || git clone https://git.entrouvert.org/passerelle-imio-liege-lisrue.git/ ${folder}/passerelle-imio-liege-lisrue
	test -s ${folder}/passerelle-imio-liege-rn || git clone https://git.entrouvert.org/passerelle-imio-liege-rn.git/ ${folder}/passerelle-imio-liege-rn
	test -s ${folder}/passerelle-imio-tax-compute || git clone https://git.entrouvert.org/passerelle-imio-tax-compute.git/ ${folder}/passerelle-imio-tax-compute
	test -s ${folder}/passerelle-imio-ts1-datasources || git clone https://git.entrouvert.org/passerelle-imio-ts1-datasources.git/ ${folder}/passerelle-imio-ts1-datasources
	test -s ${folder}/publik-imio-industrialisation || git clone https://git.entrouvert.org/publik-imio-industrialisation.git/ ${folder}/publik-imio-industrialisation
	test -s ${folder}/sauron || git clone git@gitlab.imio.be:teleservices/sauron.git ${folder}/sauron
	test -s ${folder}/simple-form-post-1 || git clone git@gitlab.imio.be:teleservices/testing/simple-form-post-1.git ${folder}/simple-form-post-1
	test -s ${folder}/simple-form-pull-1 || git clone git@gitlab.imio.be:teleservices/testing/simple-form-pull-1.git ${folder}/simple-form-pull-1
	test -s ${folder}/wcs-scripts-teleservices || git clone git@github.com:IMIO/wcs-scripts-teleservices.git ${folder}/wcs-scripts-teleservices
	cp ${folder}/teleservices-publikdevinst/git-pull-recursif.sh ${folder}/git-pull-recursif.sh
	chmod +x ${folder}/git-pull-recursif.sh
	echo "✅ All repositories related to iA.Téléservices seems to have been set inside ${folder}\n Whenever you want to recursively git pull all the subdirectories :\n run git-pull-recursif.sh to easily keep all the stuff up to date! Keep up the good work and have a nice day! 🌞"

init-passerelle-modules:
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
	cd ~/src/imio/passerelle-imio-ts1-datasources;~/envs/publik-env-py3/bin/pip install -e .
	~/envs/publik-env-py3/bin/passerelle-manage migrate_schemas
# Add modules to INSTALLED_APPS
	cp -r /home/${USER}/src/imio/teleservices-publikdevinst/settingsd_files/passerelle/*.py /home/${USER}/.config/publik/settings/passerelle/settings.d/
	ls /home/publikdev/.config/publik/settings/passerelle/settings.d/
# Restart service
	sudo supervisorctl restart passerelle

build-e-guichet = ~/src/imio/scripts-teleservices/build-e-guichet
insert = default_position = 50.4988;4.7199
site_option = /var/lib/wcs/tenants/wcs.dev.publik.love/site-options.cfg
wcs_tenant = /var/lib/wcs/tenants/wcs.dev.publik.love

build-e-guichet:
# Do what the bash script did but translated for Makefile / Publik-dev inst
# Beware : you must comment the line related to 'build-api-user.py' to build again.
	grep -qxF "${insert}" ${site_option} || sed -i "s/\[options\]/\[options\]\n${insert}/" ${site_option}
	/home/${USER}/envs/publik-env-py3/bin/passerelle-manage tenant_command runscript ${build-e-guichet}/passerelle/build-api-user.py -d passerelle.dev.publik.love
	/home/${USER}/envs/publik-env-py3/bin/passerelle-manage tenant_command import_site -d passerelle.dev.publik.love ${build-e-guichet}/datasources/datasources.json
	/home/${USER}/envs/publik-env-py3/bin/passerelle-manage tenant_command import_site -d passerelle.dev.publik.love ${build-e-guichet}/passerelle/pays.json --import-users
	/home/${USER}/envs/publik-env-py3/bin/authentic2-multitenant-manage tenant_command runscript ${build-e-guichet}/import-authentic-user.py -d authentic.dev.publik.love
	/home/${USER}/envs/publik-env-py3/bin/authentic2-multitenant-manage tenant_command runscript ${build-e-guichet}/auth_fedict_var.py -d authentic.dev.publik.love
	/home/${USER}/envs/publik-env-py3/bin/wcs-manage runscript --vhost=wcs.dev.publik.love ${build-e-guichet}/import-permissions.py full
	/home/${USER}/envs/publik-env-py3/bin/combo-manage tenant_command import_site -d agent-combo.dev.publik.love ${build-e-guichet}/combo-site/combo-portail-agent-structure.json
	/home/${USER}/envs/publik-env-py3/bin/combo-manage tenant_command import_site -d combo.dev.publik.love ${build-e-guichet}/combo-site/combo-site-structure-full.json
	/home/${USER}/envs/publik-env-py3/bin/hobo-manage tenant_command runscript -d hobo.dev.publik.love ${build-e-guichet}/hobo_create_variables.py

init-publik-imio-industrialisation:
# publik-imio-industrialisation make install does not work with publik-devinst (see #57805)
	cp ~/src/imio/publik-imio-industrialisation/combo/*.py ~/src/combo/combo/data/management/commands/
	cp ~/src/imio/publik-imio-industrialisation/hobo/*.py ~/src/hobo/hobo/environment/management/commands/
	cp ~/src/imio/publik-imio-industrialisation/wcs/*.py ~/src/wcs/wcs/ctl/

init-teleservices-package:
	/home/${USER}/envs/publik-env-py3/bin/hobo-manage imio_indus_deploy -d hobo.dev.publik.love --directory ${folder}/teleservices-package/teleservices_package

update-teleservices-package:
	cd ~/src/imio/teleservices-package
	git pull
	cd -
	make init-teleservices-package

init-townstreet:
	/home/${USER}/envs/publik-env-py3/bin/hobo-manage imio_indus_deploy -d hobo.dev.publik.love --directory ${folder}/imio-townstreet/imio_townstreet/

init-townstreet-passerelle:
	/home/${USER}/envs/publik-env-py3/bin/passerelle-manage tenant_command import_site -d passerelle.dev.publik.love ${folder}/teleservices-publikdevinst/passerelle_elements/export_passerelle-imio-ia-tech_atal-demov6_20220228.json --import-users


clean-imio-src:
	rm -rf ~/src/imio
