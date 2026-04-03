# ADR 001: Déploiement Multi-AZ

## Statut
Accepté

## Contexte
L'application doit supporter 90K utilisateurs avec une disponibilité 99.9%.

## Décision
Déployer sur 3 zones de disponibilité (us-east-1a/b/c).

## Conséquences
### Positives
- Haute disponibilité
- Résilience aux pannes de zone
- Latence réduite

### Négatives
- Coût légèrement supérieur
- Complexité réseau accrue

## Alternatives Considérées
- 2 AZ : Moins résilient
- 1 AZ : Risque de panne totale