#!/bin/bash


cd ~/src/k8s/nginx-test/
kubectl delete -k overlays/master
kubectl delete -k overlays/production

cd ~/src/terraform/aws-test/
terraform destroy

