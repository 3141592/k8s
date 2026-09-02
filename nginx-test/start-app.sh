#!/bin/bash
aws eks update-kubeconfig \
  --region us-east-1 \
  --name roy-eks \
  --profile personal

kubectl apply -k overlays/master
kubectl apply -k overlays/production
