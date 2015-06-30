# build the kube2sky image.

# this is the only variable you need to set.
# it can be set on the make command line:
# make IMAGEACCOUNT=mydockerhub
# or with an exported environment variable:
# export IMAGEACCOUNT=mydockerhub
# you can include the repo if not on dockerhub, like:
# make IMAGEACCOUNT=gcr.io/google_containers
#
IMAGEACCOUNT ?= repo/account

# this picks up the latest VERSION.  You can simply
# hard code it if you want to build an older one:
# V=v0.18.2 for example
#V ?= $(shell wget -q -O- https://storage.googleapis.com/kubernetes-release/release/latest.txt)
V=v0.20.1

# relative to the cluster directory.  specific files are plucked from there.
# if your git checkout of kubernetes is not in ../../kubernetes,
# then set the variable KUBEROOT
KUBEROOT ?= ../../kubernetes
K=cluster/addons/dns/kube2sky

H=kube2sky
IMAGENAME = ${IMAGEACCOUNT}/$H

directions :
	@echo 'to make an image for your docker hub account'
	@echo 'make IMAGEACCOUNT=yourdockerhubaccount docker'

all.tmp: $(KUBEROOT)/_output/local/bin/linux/amd64/$H
	cp $(KUBEROOT)/_output/local/bin/linux/amd64/$H .
	cp $(KUBEROOT)/$K/$H.go .
	touch all.tmp

$(KUBEROOT)/_output/local/bin/linux/amd64/$H: $(KUBEROOT)/$K/$H.go
	@echo 'make the kube2sky'
	(cd $(KUBEROOT); make WHAT=$K)

clean :
	rm -f *.tmp $H $H.go

.PHONY: all
