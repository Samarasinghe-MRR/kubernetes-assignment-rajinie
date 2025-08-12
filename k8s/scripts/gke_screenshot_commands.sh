#!/bin/bash

echo "==================== 1. RUNNING PODS ===================="
kubectl get pods -n java-api -o wide
echo

echo "==================== 2. DEPLOYMENT DETAILS ===================="
kubectl describe deployment java-api-deployment -n java-api
echo

echo "==================== 3. INGRESS DETAILS ===================="
kubectl describe ingress java-api-ingress -n java-api
echo

echo "==================== 4. HPA STATUS ===================="
kubectl get hpa -n java-api
echo

echo "==================== 5. CURL TESTS ===================="
echo "Health Endpoint:"
curl -k https://api.104.199.209.164.sslip.io/health
echo

echo "Sample Endpoint (change <your-endpoint>):"
curl -k https://api.104.199.209.164.sslip.io/api/users
echo

echo "==================== 6. VERBOSE CURL (For Debug) ===================="
curl -v -k https://api.104.199.209.164.sslip.io/health
