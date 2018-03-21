# This Makefile automates possible operations of this project.
#
# Images and description on Docker Hub will be automatically rebuilt on
# pushes to `master` branch of this repo and on updates of
# parent `alpine` image.
#
# Note! Docker Hub `post_push` hook must be always up-to-date with default
# values of current Makefile. To update it just use:
#	make post-push-hook
#
# It's still possible to build, tag and push images manually. Just use:
#	make release


IMAGE_NAME := instrumentisto/nmap
VERSION ?= 7.60
TAGS ?= 7.60,7,latest


comma := ,
eq = $(if $(or $(1),$(2)),$(and $(findstring $(1),$(2)),\
                                $(findstring $(2),$(1))),1)



# Build Docker image.
#
# Usage:
#	make image [VERSION=<image-version>]
#	           [no-cache=(no|yes)]

no-cache-arg = $(if $(call eq, $(no-cache), yes), --no-cache, $(empty))

image:
	docker build --network=host $(if $(call eq,$(no-cache),yes),--no-cache,) \
		-t $(IMAGE_NAME):$(VERSION) .



# Tag Docker image with given tags.
#
# Usage:
#	make tags [VERSION=<image-version>]
#	          [TAGS=<docker-tag-1>[,<docker-tag-2>...]]

tags:
	(set -e ; $(foreach tag, $(subst $(comma), ,$(TAGS)), \
		docker tag $(IMAGE_NAME):$(VERSION) $(IMAGE_NAME):$(tag); \
	))



# Manually push Docker images to Docker Hub.
#
# Usage:
#	make push [TAGS=<docker-tag-1>[,<docker-tag-2>...]]

push:
	(set -e ; $(foreach tag, $(subst $(comma), ,$(TAGS)), \
		docker push $(IMAGE_NAME):$(tag) ; \
	))



# Make manual release of Docker images to Docker Hub.
#
# Usage:
#	make release [VERSION=<image-version>] [no-cache=(no|yes)]
#	             [TAGS=<docker-tag-1>[,<docker-tag-2>...]]

release: | image tags push



# Create `post_push` Docker Hub hook.
#
# When Docker Hub triggers automated build all the tags defined in `post_push`
# hook will be assigned to built image. It allows to link the same image with
# different tags, and not to build identical image for each tag separately.
# See details:
# http://windsock.io/automated-docker-image-builds-with-multiple-tags
#
# Usage:
#	make post-push-hook [TAGS=<docker-tag-1>[,<docker-tag-2>...]]

post-push-hook:
	@mkdir -p hooks/
	docker run --rm  -v "$(PWD)/post_push.tmpl.php":/post_push.php:ro \
		php:alpine php -f /post_push.php -- \
			--image_tags='$(TAGS)' \
		> hooks/post_push



# Run tests for Docker image.
#
# Documentation of Bats:
#	https://github.com/sstephenson/bats
#
# Usage:
#	make test [VERSION=<image-version>]

test: deps.bats
	IMAGE=$(IMAGE_NAME):$(VERSION) test/bats/bats test/suite.bats



# Resolve project dependencies for running tests.
#
# Usage:
#	make deps.bats [BATS_VER=<bats-version>]

BATS_VER ?= 0.4.0

deps.bats:
ifeq ($(wildcard test/bats),)
	@mkdir -p test/bats/vendor/
	curl -fL -o test/bats/vendor/bats.tar.gz \
		https://github.com/sstephenson/bats/archive/v$(BATS_VER).tar.gz
	tar -xzf test/bats/vendor/bats.tar.gz -C test/bats/vendor/
	@rm -f test/bats/vendor/bats.tar.gz
	ln -s $(PWD)/test/bats/vendor/bats-$(BATS_VER)/libexec/* test/bats/
endif



.PHONY: image tags push release post-push-hook test deps.bats
