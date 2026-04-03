# Runbook: CPU Élevé sur les Pods

## Symptômes
- Alerte Grafana: CPU > 80%
- Latence augmentée
- HPA scale mais insuffisant

## Diagnostic
```bash
# Vérifier CPU pods
kubectl top pods

# Vérifier HPA
kubectl get hpa

# Vérifier nodes
kubectl top nodes
```

## Actions
1. Vérifier si HPA a atteint maxReplicas
2. Si oui, augmenter maxReplicas:
```bash
   kubectl edit hpa frontend-hpa
   # Modifier maxReplicas: 10 → 20
```
3. Vérifier si Cluster Autoscaler crée des nodes
4. Si non, augmenter max_size node group

## Escalade
Si CPU > 90% pendant 10 min → Alert on-call