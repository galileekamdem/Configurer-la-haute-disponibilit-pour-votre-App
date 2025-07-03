# Configurer-la-haute-disponibilit-pour-votre-App
création d'une application d'annuaire des employés

**📂 README - Haute Disponibilité & Auto Scaling pour une Application AWS**  

## **📌 Description du Projet**  
Ce projet démontre la configuration d'une architecture **haute disponibilité (HA)** et **scalable** sur AWS pour une application web critique ("Employee Directory"). L'objectif était d'anticiper les pics de charge en combinant **ALB (Application Load Balancer)**, **Auto Scaling**, et des bases de données multi-AZ, tout en assurant la sécurité via IAM et des groupes de sécurité.  

---

## **🛠 Services AWS Utilisés**  
| Catégorie          | Services                                                                 |  
|--------------------|--------------------------------------------------------------------------|  
| **Calcul**         | EC2, Auto Scaling Groups, Launch Templates                               |  
| **Réseau**         | VPC, ALB, Groupes de Sécurité, Sous-réseaux Multi-AZ                    |  
| **Stockage**       | S3 (Stockage des assets), DynamoDB (Base de données NoSQL)              |  
| **Sécurité**       | IAM (Rôles et politiques), Secrets Manager                               |  
| **Monitoring**     | CloudWatch (Metrics), SNS (Notifications)                                |  


## **🎯 Objectifs Réalisés**  
✅ **Haute Disponibilité** : Déploiement sur 2 zones de disponibilité (AZ) avec basculement automatique.  
✅ **Scalabilité Horizontale** : Auto Scaling basé sur la charge CPU (testée via stress-tool).  
✅ **Sécurité** :  
   - Restriction des accès via IAM Roles et Security Groups.  
   - Chiffrement des données en transit (ALB + HTTPS).  
✅ **Automatisation** :  
   - Script de bootstrap (`User Data`) pour le déploiement automatique des instances.  
   - Infrastructure as Code (CloudFormation partiel).  


 **📂 Structure du Projet**  
```bash
📁 aws-ha-scaling/  
├── 📄 cloudformation/                  # Templates CloudFormation  
│   ├── alb-setup.yml                  # Configuration ALB + Target Groups  
│   └── autoscaling.yml                # Auto Scaling Group + Launch Template  
├── 📄 user-data/                       # Scripts de configuration  
│   ├── bootstrap.sh                   # Installation app + dépendances  
│   └── stress-test.sh                 # Script de test de charge  
├── 📄 docs/                            # Documentation supplémentaire  
│   ├── architecture-diagram.png       # Schéma de l'architecture  
│   └── best-practices.md              # Bonnes pratiques AWS  
└── 📄 README.md                        # Ce fichier  
```

---

 **🚀 Déploiement**  
 **Prérequis**  
- Compte AWS avec permissions `AdministratorAccess` (ou équivalent).  
- AWS CLI configuré (`aws configure`).  

 **Étapes**  
1. **Déployer l'ALB** :  
   ```bash
   aws cloudformation deploy --template-file cloudformation/alb-setup.yml --stack-name EmployeeDir-ALB
   ```  
2. **Créer le groupe Auto Scaling** :  
   ```bash
   aws cloudformation deploy --template-file cloudformation/autoscaling.yml --stack-name EmployeeDir-ASG
   ```  
3. **Tester la charge** :  
   - Accéder à l'URL de l'ALB et lancer le stress-test via l'interface admin.  
   - Surveiller la création automatique d'instances dans CloudWatch.  

---

**🔍 Résultats & Validation**  
- **Test de basculement** : L'application reste accessible même après la suppression manuelle d'une instance.  
- **Auto Scaling** : 2 → 4 instances lors du stress-test (CPU > 30%).  
- **Monitoring** : Notifications SNS envoyées pour les événements de scaling.  

---

 **📜 Bonnes Pratiques**  
✔ **Multi-AZ** : Tolérance aux pannes grâce aux sous-réseaux redondants.  
✔ **Seuils de Scaling** : Paramètres optimisés pour éviter les déclenchements intempestifs.  
✔ **Cleanup** : Suppression de l'instance initiale après la mise en place de l'ASG.
  
**✨ Star ⭐ ce repo si vous trouvez ce projet utile !** ✨  


 **📌 Points Clés pour les Recruteurs**  
- **Maîtrise des architectures HA/Scaling** sur AWS.  
- **Expérience pratique** avec ALB, Auto Scaling, et scripts d'automatisation.  
- **Sensibilité sécurité** (IAM, Security Groups).  
- **Approche DevOps** : IaC (CloudFormation), monitoring proactif.  

Projet inspiré d'un cas réel pour répondre à des besoins de montée en charge imprévisibles.
