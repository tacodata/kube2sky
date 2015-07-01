# build the kube2sky image.

# relative to the cluster directory.  specific files are plucked from there.
# if your git checkout of kubernetes is not in ../../kubernetes,
# then set the variable KUBEROOT
KUBEROOT ?= ../../kubernetes
K=cluster/addons/dns/kube2sky

H=kube2sky

V ?= unknown

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
