#!/bin/bash

cd ~/src/k8s/nginx-test/

ALB_DNS=$(kubectl get ingress nginx-test -n master \
  -o jsonpath='{.status.loadBalancer.ingress[0].hostname}' 2>/dev/null || true)

echo "ALB: ${ALB_DNS:-none}"

kubectl delete -k overlays/master
kubectl delete -k overlays/production

echo "Waiting for ALB cleanup..."
kubectl wait \
  --for=delete ingress/nginx-test \
  -n master \
  --timeout=5m 2>/dev/null || true

if [ -n "$ALB_DNS" ]; then
  echo "Waiting for AWS ALB deletion..."

  while aws elbv2 describe-load-balancers \
      --region us-east-1 \
      --query "LoadBalancers[?DNSName=='$ALB_DNS'].DNSName" \
      --output text 2>/dev/null | grep -q .; do
    sleep 10
  done
fi

cd ~/src/terraform/aws-test/
terraform destroy

