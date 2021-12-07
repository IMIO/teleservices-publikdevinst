install-utils:
	## VSCode
	# Install dependencies
	sudo apt update && sudo apt upgrade
	sudo apt install software-properties-common apt-transport-https curl -y
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
	

folder = ~/src/imio
init-imio-src:
	test -s ${folder} || mkdir ${folder}
	# common teleservices repositories
	test -s ${folder}/combo-plugin-imio-townstreet || git clone https://git.entrouvert.org/combo-plugin-imio-townstreet.git/ ${folder}/combo-plugin-imio-townstreet
	test -s ${folder}/imio.behavior.teleservices || git clone git@github.com:IMIO/imio.behavior.teleservices.git ${folder}/imio.behavior.teleservices
	test -s ${folder}/imio-publik-themes || git clone https://git.entrouvert.org/imio-publik-themes.git/ ${folder}/imio-publik-themes
	test -s ${folder}/imio-townstreet || git clone git@github.com:IMIO/imio-townstreet.git ${folder}/imio-townstreet
	test -s ${folder}/imio-ts-aes || git clone git@github.com:IMIO/imio-ts-aes.git ${folder}/imio-ts-aes
	test -s ${folder}/scripts-teleservices || git clone git@github.com:IMIO/scripts-teleservices.git ${folder}/scripts-teleservices
	test -s ${folder}/teleservices-german-translations || git clone git@github.com:IMIO/teleservices-german-translations.git ${folder}/teleservices-german-translations
	test -s ${folder}/teleservices-package || git clone git@github.com:IMIO/teleservices-package.git ${folder}/teleservices-package
	test -s ${folder}/teleservices-publikdevinst || git clone git@github.com:IMIO/teleservices-publikdevinst.git ${folder}/teleservices-publikdevinst
	test -s ${folder}/teleservices-scripts-selenium || git clone git@github.com:IMIO/teleservices-scripts-selenium.git ${folder}/teleservices-scripts-selenium
	test -s ${folder}/passerelle-imio-apims-baec || git clone git@github.com:IMIO/passerelle-imio-apims-baec.git ${folder}/passerelle-imio-apims-baec
	test -s ${folder}/passerelle-imio-extra-fees || git clone https://git.entrouvert.org/passerelle-imio-extra-fees.git/ ${folder}/passerelle-imio-extra-fees
	test -s ${folder}/passerelle-imio-aes-meal || git clone git@github.com:IMIO/passerelle-imio-aes-meal.git ${folder}/passerelle-imio-aes-meal
	test -s ${folder}/passerelle-imio-aes-health || git clone git@github.com:IMIO/passerelle-imio-aes-health.git ${folder}/passerelle-imio-aes-health
	test -s ${folder}/passerelle-imio-ia-aes || git clone git@github.com:IMIO/passerelle-imio-ia-aes.git 
	test -s ${folder}/passerelle-imio-ia-delib || git clone git@github.com:IMIO/passerelle-imio-ia-delib.git ${folder}/passerelle-imio-ia-delib
	test -s ${folder}/passerelle-imio-liege-lisrue || git clone https://git.entrouvert.org/passerelle-imio-liege-lisrue.git/ ${folder}/passerelle-imio-liege-lisrue
	test -s ${folder}/passerelle-imio-liege-rn || git clone https://git.entrouvert.org/passerelle-imio-liege-rn.git/ ${folder}/passerelle-imio-liege-rn
	test -s ${folder}/passerelle-imio-tax-compute || git clone https://git.entrouvert.org/passerelle-imio-tax-compute.git/ ${folder}/passerelle-imio-tax-compute
	test -s ${folder}/passerelle-imio-ts1-datasources || git clone https://git.entrouvert.org/passerelle-imio-ts1-datasources.git/ ${folder}/passerelle-imio-ts1-datasources
	test -s ${folder}/publik-imio-industrialisation || git clone https://git.entrouvert.org/publik-imio-industrialisation.git/ ${folder}/publik-imio-industrialisation
	test -s ${folder}/wcs-scripts-teleservices || git clone git@github.com:IMIO/wcs-scripts-teleservices.git ${folder}/wcs-scripts-teleservices

build-e-guichet = ~/src/imio/scripts-teleservices/build-e-guichet

insert = default_position = 50.4988;4.7199
site_option = /var/lib/wcs/tenants/wcs.dev.publik.love/site-options.cfg

wcs_tenant = /var/lib/wcs/tenants/wcs.dev.publik.love

build-e-guichet:
	grep -qxF "${insert}" ${site_option} || sed -i "s/\[options\]/\[options\]\n${insert}/" ${site_option}
	test -s /var/lib/wcs/tenants/wcs.dev.publik.love/categories || mkdir /var/lib/wcs/tenants/wcs.dev.publik.love/categories
	cp ${build-e-guichet}/categories/* ${wcs_tenant}/categories
	test -s /var/lib/wcs/tenants/wcs.dev.publik.love/datasources || mkdir /var/lib/wcs/tenants/wcs.dev.publik.love/datasources
	cp ${build-e-guichet}/datasources/* ${wcs_tenant}/datasources
#	/home/${USER}/envs/publik-env-py3/bin/passerelle-manage tenant_command runscript ${build-e-guichet}/passerelle/build-api-user.py -d passerelle.dev.publik.love
	/home/${USER}/envs/publik-env-py3/bin/passerelle-manage tenant_command import_site -d passerelle.dev.publik.love ${build-e-guichet}/datasources/datasources.json
	/home/${USER}/envs/publik-env-py3/bin/passerelle-manage tenant_command import_site -d passerelle.dev.publik.love ${build-e-guichet}/passerelle/pays.json --import-users
	/home/${USER}/envs/publik-env-py3/bin/authentic2-multitenant-manage tenant_command runscript ${build-e-guichet}/import-authentic-user.py -d authentic.dev.publik.love
	/home/${USER}/envs/publik-env-py3/bin/authentic2-multitenant-manage tenant_command runscript ${build-e-guichet}/auth_fedict_var.py -d authentic.dev.publik.love
	/home/${USER}/envs/publik-env-py3/bin/wcs-manage runscript --vhost=wcs.dev.publik.love ${build-e-guichet}/import-permissions.py full
	/home/${USER}/envs/publik-env-py3/bin/combo-manage tenant_command import_site -d agent-combo.dev.publik.love ${build-e-guichet}/combo-site/combo-portail-agent-structure.json
	/home/${USER}/envs/publik-env-py3/bin/combo-manage tenant_command import_site -d agent-combo.dev.publik.love ${build-e-guichet}/combo-site/combo-site-structure-full.json
	/home/${USER}/envs/publik-env-py3/bin/hobo-manage tenant_command runscript -d hobo.dev.publik.love ${build-e-guichet}/hobo_create_variables.py

clean-imio-src:
	rm -rf ~/src/imio
