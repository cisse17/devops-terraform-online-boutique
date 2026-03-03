# 🛒 Black Friday Survival - Projet HETIC MT5

Simulation de crise e-commerce sur AWS - Déploiement et optimisation d'une plateforme capable de tenir **90 000 utilisateurs simultanés**.

## 📊 Contexte du Projet

Ce projet déploie et optimise **Online Boutique** (Google microservices demo) sur AWS pour simuler les conditions réelles d'un Black Friday.

**Objectifs :**
- ✅ Maîtriser l'Infrastructure as Code (Terraform)
- ✅ Configurer auto-scaling et load balancing sur EKS
- ✅ Implémenter une stratégie de sécurité cloud complète
- ✅ Gérer le monitoring et l'observabilité
- ✅ Optimiser les coûts cloud (FinOps)
- 🎯 **Tenir 90K utilisateurs simultanés sans crash**

## 🏗️ Architecture

### Stack Technique
- **Cloud Provider:** AWS
- **Infrastructure as Code:** Terraform
- **Container Orchestration:** Amazon EKS (Kubernetes)
- **CI/CD:** GitHub Actions + ArgoCD
- **Monitoring:** Prometheus + Grafana + CloudWatch
- **Load Testing:** Locust + K6
- **Application:** Online Boutique (11 microservices)

### Architecture AWS
```
┌─────────────────────────────────────────────────────────────┐
│                         AWS Cloud                            │
│                                                              │
│  ┌────────────────────────────────────────────────────┐    │
│  │                    VPC (10.0.0.0/16)                │    │
│  │                                                      │    │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐│    │
│  │  │   Public    │  │   Public    │  │   Public    ││    │
│  │  │  Subnet 1   │  │  Subnet 2   │  │  Subnet 3   ││    │
│  │  │ eu-west-3a  │  │ eu-west-3b  │  │ eu-west-3c  ││    │
│  │  │             │  │             │  │             ││    │
│  │  │  NAT GW     │  │  NAT GW     │  │  NAT GW     ││    │
│  │  └─────────────┘  └─────────────┘  └─────────────┘│    │
│  │                                                      │    │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐│    │
│  │  │   Private   │  │   Private   │  │   Private   ││    │
│  │  │  Subnet 1   │  │  Subnet 2   │  │  Subnet 3   ││    │
│  │  │ eu-west-3a  │  │ eu-west-3b  │  │ eu-west-3c  ││    │
│  │  │             │  │             │  │             ││    │
│  │  │ EKS Nodes   │  │ EKS Nodes   │  │ EKS Nodes   ││    │
│  │  └─────────────┘  └─────────────┘  └─────────────┘│    │
│  │                                                      │    │
│  │                   ┌──────────────┐                  │    │
│  │                   │   EKS        │                  │    │
│  │                   │   Cluster    │                  │    │
│  │                   └──────────────┘                  │    │
│  └────────────────────────────────────────────────────┘    │
│                                                              │
│  ┌────────────────────────────────────────────────────┐    │
│  │          Application Load Balancer (ALB)            │    │
│  └────────────────────────────────────────────────────┘    │
│                                                              │
│  ┌────────────────────────────────────────────────────┐    │
│  │              WAF + Security Groups                  │    │
│  └────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────┘
```

## 📁 Structure du Projet

```
black-friday-survival/
├── terraform/              # Infrastructure as Code
│   ├── modules/           # Modules Terraform réutilisables
│   │   ├── vpc/          # VPC, Subnets, NAT Gateway
│   │   ├── eks/          # Cluster EKS + Node Groups
│   │   ├── security/     # Security Groups, IAM, WAF
│   │   ├── monitoring/   # CloudWatch, Alarms
│   │   └── finops/       # Budget alerts, cost tracking
│   └── environments/
│       ├── dev/          # Environnement de développement
│       └── prod/         # Environnement de production
│
├── k8s/                   # Manifests Kubernetes
│   ├── base/             # Manifests de base (Online Boutique)
│   ├── overlays/         # Kustomize overlays (dev/prod)
│   └── helm/             # Helm charts (monitoring, ingress)
│
├── ci-cd/                 # CI/CD Pipeline
│   ├── github-actions/   # GitHub Actions workflows
│   └── argocd/           # ArgoCD configuration
│
├── monitoring/            # Observabilité
│   ├── prometheus/       # Configuration Prometheus
│   ├── grafana/          # Dashboards Grafana
│   └── alerts/           # Alerting rules
│
├── load-testing/          # Tests de charge
│   ├── locust/           # Scripts Locust
│   └── k6/               # Scripts K6
│
├── docs/                  # Documentation
│   ├── architecture/     # Schémas d'architecture
│   ├── adr/              # Architecture Decision Records
│   ├── runbooks/         # Procédures opérationnelles
│   └── post-mortem/      # Analyses post-incident
│
└── scripts/               # Scripts utilitaires
    ├── setup-aws.ps1     # Setup initial AWS
    ├── deploy.ps1        # Déploiement complet
    └── cleanup.ps1       # Nettoyage des ressources
```

## 🚀 Démarrage Rapide

### Prérequis
- AWS CLI configuré (`aws configure`)
- Terraform >= 1.10
- kubectl >= 1.28
- Docker Desktop avec Kubernetes activé (pour tests locaux)

### 1. Cloner le projet
```bash
git clone https://github.com/<ton-username>/black-friday-survival.git
cd black-friday-survival
```

### 2. Configuration initiale
```bash
# Copier les variables d'environnement
cp terraform/environments/dev/terraform.tfvars.example terraform/environments/dev/terraform.tfvars

# Éditer avec tes valeurs
# Région AWS: eu-west-3 (Paris)
```

### 3. Déployer l'infrastructure
```bash
# Initialiser Terraform
cd terraform/environments/dev
terraform init

# Planifier les changements
terraform plan

# Appliquer (créer l'infrastructure)
terraform apply
```

### 4. Déployer l'application
```bash
# Configurer kubectl pour EKS
aws eks update-kubeconfig --region eu-west-3 --name black-friday-eks-dev

# Déployer Online Boutique
kubectl apply -k ../../k8s/overlays/dev/

# Vérifier les pods
kubectl get pods -n online-boutique
```

### 5. Accéder à l'application
```bash
# Obtenir l'URL du Load Balancer
kubectl get svc frontend-external -n online-boutique

# URL: http://<alb-dns-name>
```

## 📊 Monitoring et Observabilité

### Accéder aux dashboards

**Grafana:**
```bash
kubectl port-forward -n monitoring svc/grafana 3000:80
# http://localhost:3000
# user: admin / pass: voir dans secrets
```

**Prometheus:**
```bash
kubectl port-forward -n monitoring svc/prometheus 9090:9090
# http://localhost:9090
```

**CloudWatch:**
- Console AWS → CloudWatch → Dashboards → "Black-Friday-EKS"

## 🧪 Tests de Charge

### Locust (Interface Web)
```bash
cd load-testing/locust
locust -f locustfile.py --host=http://<alb-dns-name>
# Interface: http://localhost:8089
```

### Tests progressifs
1. **Warmup:** 1 000 users → Vérifier stabilité
2. **Phase 1:** 5 000 users → Observer auto-scaling
3. **Phase 2:** 20 000 users → Tester limites
4. **Phase 3:** 50 000 users → Optimisations
5. **Phase 4:** 70 000 users → Répétition générale
6. **Black Friday:** 90 000 users → Objectif final !

## 💰 Gestion des Coûts (FinOps)

### Budget alloué
- **Semaine 1:** 200€ (Setup)
- **Semaine 2:** 500€ (Optimisation)
- **Semaine 3:** 600€ (Pre-production)
- **Demo:** 200€ (Black Friday)
- **Total:** ~1 500€

### Optimisations coûts
- ✅ Spot Instances pour nodes EKS
- ✅ Auto-scaling agressif (scale to zero hors tests)
- ✅ Budget alerts AWS
- ✅ Arrêt automatique hors horaires (Lambda)
- ✅ Right-sizing des instances

### Voir les coûts actuels
```bash
# Via AWS CLI
aws ce get-cost-and-usage \
  --time-period Start=2026-01-01,End=2026-01-31 \
  --granularity DAILY \
  --metrics BlendedCost

# Via Console AWS
# AWS Cost Explorer → Coûts et utilisation
```

## 🔒 Sécurité

### Checklist sécurité implémentée
- ✅ IAM Roles avec Least Privilege
- ✅ Security Groups restrictifs
- ✅ Private subnets pour EKS nodes
- ✅ AWS WAF sur ALB
- ✅ Network ACLs
- ✅ Secrets Manager pour credentials
- ✅ Encryption at rest (EBS, RDS)
- ✅ Encryption in transit (TLS)
- ✅ Vulnerability scanning (Trivy)
- ✅ RBAC Kubernetes

## 📚 Documentation

### Architecture Decision Records (ADR)
- [ADR-001: Choix d'AWS comme cloud provider](docs/adr/001-cloud-provider.md)
- [ADR-002: EKS vs ECS vs Fargate](docs/adr/002-orchestration.md)
- [ADR-003: Terraform pour IaC](docs/adr/003-infrastructure-as-code.md)
- [ADR-004: Stratégie multi-AZ](docs/adr/004-high-availability.md)

### Runbooks
- [Incident: Pod CrashLoopBackOff](docs/runbooks/pod-crash.md)
- [Incident: High latency](docs/runbooks/high-latency.md)
- [Incident: Out of memory](docs/runbooks/oom.md)
- [Scale up manuel](docs/runbooks/manual-scale.md)

## 🎯 Objectifs et Critères d'Évaluation

| Critère | Poids | Points | Status |
|---------|-------|--------|--------|
| Infrastructure as Code | 20% | /20 | 🔄 En cours |
| Sécurité Cloud | 20% | /20 | 🔄 En cours |
| Performance Black Friday | 25% | /25 | ⏳ À venir |
| Observabilité | 15% | /15 | 🔄 En cours |
| FinOps | 10% | /10 | 🔄 En cours |
| Documentation | 10% | /10 | 🔄 En cours |
| **TOTAL** | **100%** | **/100** | |

### Objectif Performance
- ✅ Tenir **90 000 utilisateurs simultanés**
- ✅ Latence moyenne < 2 secondes
- ✅ Taux d'erreur < 1%
- ✅ Disponibilité > 99.9%

## 🔄 CI/CD Pipeline

### GitHub Actions
```yaml
# .github/workflows/deploy.yml
- Lint Terraform
- Terraform plan
- Security scan (Trivy, tfsec)
- Build Docker images
- Push to ECR
- Deploy to EKS (ArgoCD sync)
- Run smoke tests
```

### ArgoCD
- GitOps workflow
- Auto-sync activé
- Self-healing
- Rollback automatique en cas d'erreur

## 🧹 Nettoyage (IMPORTANT pour les coûts !)

### Supprimer toute l'infrastructure
```bash
# Via Terraform (recommandé)
cd terraform/environments/dev
terraform destroy

# Vérifier manuellement sur AWS Console :
# - EKS Cluster supprimé
# - Load Balancers supprimés
# - NAT Gateways supprimés
# - Elastic IPs libérés
```

### Arrêter temporairement (économiser sans tout détruire)
```bash
# Scale down les nodes à 0
kubectl scale deployment --all --replicas=0 -n online-boutique

# Ou via AWS Console:
# EKS → Node Groups → Desired size = 0
```

## 📞 Support et Contact

### Équipe
- **Nom:** [Bassirou CISSE]
- **Promotion:** MT5 HETIC
- **Année:** 2025-2026

### Ressources
- **Repository:** https://github.com/<username>/black-friday-survival
- **Documentation Online Boutique:** https://github.com/GoogleCloudPlatform/microservices-demo
- **AWS Documentation:** https://docs.aws.amazon.com/
- **Terraform Registry:** https://registry.terraform.io/

## 📝 Changelog

### v1.0.0 - Setup Initial (Semaine 1)
- ✅ Infrastructure Terraform (VPC, EKS)
- ✅ Déploiement Online Boutique
- ✅ Monitoring basique (CloudWatch)
- ✅ Premier test: 1 000 users

### v2.0.0 - Hardening (Semaine 2)
- 🔄 Multi-AZ deployment
- 🔄 Security hardening (WAF, SG)
- 🔄 Observabilité complète (Prometheus/Grafana)
- 🔄 Auto-scaling (HPA, CA)
- 🔄 Tests: 5K → 50K users

### v3.0.0 - Pre-Production (Semaine 3)
- ⏳ Chaos engineering
- ⏳ Optimisation coûts (Spot)
- ⏳ Test répétition: 70K users
- ⏳ Runbooks complets

### v4.0.0 - Black Friday (Demo)
- ⏳ Test final: 90K users
- ⏳ War Room
- ⏳ Post-mortem

## 📄 License

Ce projet est réalisé dans le cadre d'un projet pédagogique HETIC.

---

**🎯 Objectif: Tenir 90K users le jour J !** 🚀