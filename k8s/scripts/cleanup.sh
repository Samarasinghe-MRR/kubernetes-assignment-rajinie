#!/bin/bash
# scripts/cleanup.sh
# Clean up Java API deployment and local resources

echo "Cleaning up Java API deployment..."

# Delete all Kubernetes resources in k8s/ directory
kubectl delete -f k8s/

# Optionally delete the namespace (this removes everything inside it)
kubectl delete namespace java-api-ns

# Clean up Docker images locally
docker rmi java-api:1.0.0

# Remove from Google Artifact Registry (replace variables)
REGION="asia-south1"
PROJECT_ID="betbazar-ops"
REPOSITORY_NAME="java-api-repo"

docker rmi $REGION-docker.pkg.dev/$PROJECT_ID/$REPOSITORY_NAME/java-api:1.0.0
docker rmi $REGION-docker.pkg.dev/$PROJECT_ID/$REPOSITORY_NAME/java-api:latest

echo "Cleanup completed!"
