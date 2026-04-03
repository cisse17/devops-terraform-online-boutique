# Post-Mortem Black Friday - 25 Novembre 2026

## Résumé Exécutif
- **Durée événement :** 12h (8h-20h)
- **Pic utilisateurs :** 90 000 simultanés
- **Disponibilité :** 99.95%
- **Incidents :** 1 mineur

## Chronologie

### 08:00 - Début Black Friday
- Trafic initial: 5K users
- Infrastructure: 3 nodes, tous les pods Running

### 10:00 - Premier pic (30K users)
- HPA scale: Frontend 2→8 pods
- Cluster Autoscaler: 3→6 nodes
- Latence moyenne: 800ms ✅

### 12:00 - Pic maximal (90K users)
- HPA: Tous les services à maxReplicas
- Nodes: 10/10 (limite atteinte)
- Latence moyenne: 1.8s ✅
- **INCIDENT :** CurrencyService OOM (2 restarts)

### 14:00 - Résolution incident
- Augmentation mémoire: 256Mi→512Mi
- Redémarrage pods
- Service restauré en 3 min

### 20:00 - Fin événement
- Scale down progressif
- Retour à 3 nodes baseline

## Métriques

| Métrique | Objectif | Réalisé | ✅/❌ |
|----------|----------|---------|------|
| Disponibilité | 99.9% | 99.95% | ✅ |
| Latence P95 | < 2s | 1.8s | ✅ |
| Taux d'erreur | < 1% | 0.05% | ✅ |
| Utilisateurs simultanés | 90K | 90K | ✅ |

## Leçons Apprises

### Ce qui a bien fonctionné ✅
1. Auto-scaling (HPA + CA) performant
2. Monitoring Grafana temps réel efficace
3. Multi-AZ = aucune panne de zone

### À améliorer ⚠️
1. Limites mémoire trop basses (CurrencyService)
2. Max nodes insuffisant (atteint 100%) 
3. Pas d'alerting automatique

## Actions Correctives

| Action | Priorité | Deadline | Responsable |
|--------|----------|----------|-------------|
| Augmenter limites mémoire | P0 | Immédiat | DevOps |
| Max nodes 10→20 | P0 | J+1 | DevOps |
| Alerting Prometheus | P1 | J+3 | DevOps |
| Load testing 150K | P2 | J+7 | QA |