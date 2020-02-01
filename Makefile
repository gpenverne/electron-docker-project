DOCKER = docker run --rm -it  -v $$(pwd):/home/app -w /home/app
ELECTRON = $(DOCKER)  --env="ELECTRON_ENABLE_LOGGING=1" --net=host --env="DISPLAY" --volume="$$HOME/.Xauthority:/root/.Xauthority:rw" project
NODE = $(DOCKER) project
NPM = $(NODE) npm

##
## DEV tools
## -------
##
build: ## Build the docker container and install nodejs dependencies
	docker build -t project .
	$(NPM) install

install: ## Install dependencies
	$(NPM) install
	$(NODE) mv ./node_modules/angular/angular.min.js ./www/lib/
	$(NODE) mv ./node_modules/bootstrap/dist ./www/lib/bootstrap

serve-html: ## Serve the html ui using nginx
	docker run  --rm -v $$(pwd)/www:/usr/share/nginx/html:ro -p 8088:80 nginx:latest

package: ## Build a distruable binary
	$(ELECTRON) ./node_modules/.bin/electron-builder
	$(DOCKER) project ./node_modules/.bin/cordova build
	$(DOCKER) project mv platforms/android/app/build/outputs/apk/debug/app-debug.apk dist/android.apk

android: ## Add a cordova android platform
	$(DOCKER) project ./node_modules/.bin/cordova platform add android

gui: ## Launch the GUI using docker
	$(ELECTRON) npm run gui

.DEFAULT_GOAL := help
help: Makefile
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'
