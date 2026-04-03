# 📊 RAPPORT FINOPS - BLACK FRIDAY SURVIVAL

## 💰 Budget & Coûts Réels

| Période | Budget Alloué | Coût Réel | Économies | % Budget |
|---------|---------------|-----------|-----------|----------|
| Semaine 1 | 500€ | ~120€ | 380€ | 24% |
| Semaine 2 | 500€ | ~180€ | 320€ | 36% |
| **TOTAL** | **1000€** | **~300€** | **700€** | **30%** |

## 📈 Détail des Coûts Mensuels

### Infrastructure AWS

| Service | Coût Mensuel | Coût Journalier | Optimisations |
|---------|--------------|-----------------|---------------|
| EKS Control Plane | 73€ | 2.43€ | ✅ Cluster unique |
| EC2 Nodes (2-10 t3.medium) | 60-300€ | 2-10€ | ✅ Auto-scaling |
| Load Balancer | 20€ | 0.67€ | ✅ ALB unique |
| EBS Volumes | 10€ | 0.33€ | ✅ gp3, 20GB seulement |
| Data Transfer | 15€ | 0.50€ | ⚠️ Optimisable |
| CloudWatch Logs | 10€ | 0.33€ | ✅ Rétention 7 jours |
| **TOTAL** | **~180€** | **~6€** | |

### Services Non Utilisés (Économies)

| Service | Coût Évité | Raison |
|---------|------------|--------|
| NAT Gateway (x3) | -96€/mois | Nodes en subnets publics |
| RDS | -50€/mois | Pas de base de données |
| ElastiCache | -30€/mois | Redis local |
| S3 | -5€/mois | Pas de stockage objet |
| **TOTAL ÉCONOMISÉ** | **-181€/mois** | |

## 🎯 Optimisations Mises en Place

### ✅ Réalisées

1. **Auto-Scaling**
   - HPA : Min 2 → Max 10 pods
   - Cluster Autoscaler : Min 2 → Max 10 nodes
   - **Économie estimée : 40%** (scale down la nuit)

2. **Instance Types**
   - t3.medium (2 vCPU, 4GB RAM)
   - Spot Instances possibles : **-70% de coût**

3. **Storage**
   - gp3 au lieu de gp2 : **-20% de coût**
   - Volumes 20GB seulement

4. **Logs**
   - Rétention 7 jours au lieu de 30
   - **Économie : 75%**

### 🔄 À Implémenter (Semaine 3)

1. **Spot Instances**
   - Mix On-Demand + Spot (70% Spot)
   - **Économie potentielle : -200€/mois**

2. **Reserved Instances**
   - Engagement 1 an sur le control plane
   - **Économie : -25%**

3. **Cloudflare CDN**
   - Cache static assets
   - **Réduction Data Transfer : -50%**

## 📊 Projections Black Friday (1 jour)

### Scénario Nominal (90K users sur 12h)

| Composant | Configuration | Coût 12h |
|-----------|---------------|----------|
| EKS Control Plane | 1 cluster | 2.43€ |
| EC2 Nodes | 10 nodes t3.medium | 10€ |
| Load Balancer | 1 ALB | 0.67€ |
| Data Transfer | ~500GB | 35€ |
| CloudWatch | Logs intensifs | 5€ |
| **TOTAL BLACK FRIDAY** | | **~53€** |

### Scénario Optimisé (Spot Instances)

| Composant | Configuration | Coût 12h |
|-----------|---------------|----------|
| EC2 Nodes | 10 nodes t3.medium Spot | 3€ |
| Autres | Identique | 43€ |
| **TOTAL OPTIMISÉ** | | **~46€** |
| **ÉCONOMIE** | | **-7€ (-13%)** |

## 🎓 Recommandations

### Court Terme (Semaine 3)
1. ✅ Activer Cluster Autoscaler scale-down (nuit)
2. ✅ Passer à Spot Instances (70% du fleet)
3. ✅ Cloudflare CDN pour static assets

### Moyen Terme (Production)
1. Reserved Instances (engagement 1 an)
2. Savings Plans AWS
3. Monitoring continu avec AWS Cost Explorer

### Long Terme
1. Multi-region failover
2. CDN global (CloudFront + Cloudflare)
3. Database caching (ElastiCache)

## 📈 ROI Black Friday

| Métrique | Valeur |
|----------|--------|
| Coût infrastructure 1 jour | 53€ |
| Revenus estimés (90K users, 2% conversion, 50€ panier moyen) | 90 000€ |
| **ROI** | **169 811%** |
| **Coût par transaction** | **0.029€** |

## 🔍 Audit Trail

| Date | Action | Impact Budget |
|------|--------|---------------|
| 2026-03-25 | Création VPC 3 AZ | +0€ |
| 2026-03-25 | EKS Cluster (t3.medium x2) | +120€/mois |
| 2026-03-31 | Prometheus + Grafana | +10€/mois |
| 2026-04-01 | Augmentation max nodes (5→10) | +150€/mois (max) |
| **TOTAL** | | **180€/mois** |

---

**Responsable FinOps :** [Bassirou CISSE ]  
**Dernière mise à jour :** 01/04/2026  
**Période couverte :** Semaines 1-2