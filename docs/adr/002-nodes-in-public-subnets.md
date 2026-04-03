# ADR 002: Nodes dans Subnets Publics

## Statut
Accepté (temporaire)

## Contexte
Budget limité (500€), NAT Gateway coûte 96€/mois. 

## Décision
Placer les nodes dans les subnets publics pour Semaine 2. 

## Conséquences
### Positives
- Économie de 96€/mois
- Déploiement plus rapide

### Négatives
- Sécurité réduite (nodes exposés)
- Non conforme aux best practices production

## Plan de Migration
Semaine 3 : Ajouter NAT Gateways et déplacer nodes en subnets privés. (Raison de sécurité)