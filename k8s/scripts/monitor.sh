#!/bin/bash
# scripts/monitor.sh
# Monitor Java API deployment status with colors and icons

# Colors
GREEN="\e[32m"
CYAN="\e[36m"
YELLOW="\e[33m"
NC="\e[0m" # No color

echo -e "${CYAN}🚀 === Java API Monitoring ===${NC}"
echo -e "${YELLOW}📦 Namespace:${NC} java-api\n"

echo -e "${GREEN}🟢 Pods Status:${NC}"
kubectl get pods -n java-api
echo -e "\n"

echo -e "${GREEN}🔵 Service Status:${NC}"
kubectl get svc -n java-api
echo -e "\n"

echo -e "${GREEN}🌐 Ingress Status:${NC}"
kubectl get ingress -n java-api
echo -e "\n"

echo -e "${GREEN}📈 HPA Status:${NC}"
kubectl get hpa -n java-api
echo -e "\n"

echo -e "${GREEN}🕒 Recent Events:${NC}"
kubectl get events -n java-api --sort-by='.lastTimestamp' | tail -10
