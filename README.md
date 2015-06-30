# kube2sky

a Makefile to build your own kube2sky image

## Summary
This Makefile and Dockerfile can be used to build your own version
of kube2sky.  There is a dependency on the kubernetes source.


## Usage
These directions may help
### Initial git checkouts
```
mkdir -p ~/git/tacodata
cd ~/git/tacodata
git clone https://github.com/tacodata/kube2sky.git
cd ~/git
git clone https://github.com/GoogleCloudPlatform/kubernetes.git
cd tacodata/kube2sky
```
### to make the current docker image tacodata/kube2sky
```
make IMAGEACCOUNT=tacodata docker
```
### if you wanted to push this to a different repo (e.g.):
```
make IMAGEACCOUNT=gcr.io/google_containers docker
```
### to make a version other than the current version
```
make IMAGEACCOUNT=tacodata V=v0.18.2 docker
```
### if your kubernetes checkout is not in ../../kubernetes
```
make IMAGEACCOUNT=tacodata KUBEROOT=/over/here/kubernetes docker
```

## Notes
If make docker works correctly, you will have pushed an image
to docker hub called $TAGROOT/kube2sky:$VERSION

If you do not supply the V flag, the current version is made.  The current version
is calculated from the script:
```
wget -q -O- https://storage.googleapis.com/kubernetes-release/release/latest.txt
```

Important, although the V flag specifies the executable version of the kube2sky
to include in the image, the files that are included (master.json, safe_format_and_mount)
from the KUBEROOT directory are not examined for version.

