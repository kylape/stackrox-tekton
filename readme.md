# Stackrox Tekton Pipeline

This is a side project to try and just get a tekton pipeline to build StackRox as fast as possible.
I'd also like to try to run a bunch of the test suites in the pipeline as well.

## Prerequisites

* Kind (the only k8s cluster I've tested on)
* Storage driver available on cluster
* Tekton
* `tkn` CLI
* Scanner bundle
* go 1.24 tgz

## Install

```
tkn hub install task git-clone
tkn hub install task buildah
kubectl create -f pipeline.yaml -f pvc.yaml
```

Then to run the pipeline: `kubectl create -f pipelinerun.yaml`
