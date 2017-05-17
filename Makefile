IMAGE_TAG := $(shell git describe --tags --always | tr -d v)

.PHONY: build

build:
	cp -rf python-tools example/
	cp -rf install.sh example/
	cp -rf example/Dockerfile example/Dockerfile.build
	sed -E 's|^RUN\swget.*python-tools.*|COPY . /tmp/python-tools-master|g' -i example/Dockerfile.build
	sed -E 's|^\s&&\s(/tmp/python-tools-\*/install.sh.*)|RUN \1|g' -i example/Dockerfile.build
	docker build -t python-tools:$(IMAGE_TAG) --file example/Dockerfile.build example
	rm -rf example/python-tools
	rm -rf example/install.sh
	rm -rf example/Dockerfile.build

cleanup:
	docker rmi -f python-tools:$(IMAGE_TAG)
