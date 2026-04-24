# 🚀 Déploiement automatisé d'un serveur Web sur AWS

Projet de déploiement d'un serveur web **Nginx** sur **AWS EC2** en utilisant **Terraform** pour la création de l'infrastructure et **Ansible** pour la configuration automatique.

***

## 📋 Description

Ce projet permet de déployer automatiquement un serveur web sur le cloud AWS en une seule commande, sans aucune intervention manuelle. Il illustre le concept d'**Infrastructure as Code (IaC)**.

***

## 🛠️ Technologies utilisées

| Outil | Rôle |
|-------|------|
| **Terraform** | Création de l'infrastructure AWS (VPC, Subnet, Security Group, EC2) |
| **Ansible** | Configuration du serveur et déploiement de Nginx |
| **AWS EC2** | Machine virtuelle Ubuntu dans le cloud |
| **Nginx** | Serveur web qui affiche la page HTML |

***

## 📁 Structure du projet

```
projet-nginx-aws/
├── terraform/
│   ├── main.tf          # Définition de l'infrastructure AWS
│   └── variables.tf     # Variables Terraform
├── ansible/
│   ├── playbook.yml     # Tâches de configuration du serveur
│   └── inventory.ini    # Adresse IP de la VM
└── README.md
```

***

## ✅ Prérequis

- [Terraform](https://developer.hashicorp.com/terraform/install) installé
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/) installé
- Un compte AWS avec les credentials configurés
- Une paire de clés SSH (`~/.ssh/id_rsa`)

***

## 🚀 Déploiement en 4 étapes

### 1. Cloner le projet

```bash
git clone https://github.com/Thommas3153/projet-nginx-aws.git
cd projet-nginx-aws
```

### 2. Créer l'infrastructure AWS avec Terraform

```bash
cd terraform/
terraform init
terraform apply
```

> Terraform crée automatiquement : VPC, Subnet, Security Group, et une instance EC2 Ubuntu.

### 3. Récupérer l'IP publique

```bash
terraform output public_ip
```

Copie l'IP et mets-la dans `ansible/inventory.ini` :

```ini
[webservers]
nginxserver ansible_host=<TON_IP> ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa ansible_python_interpreter=/usr/bin/python3
```

### 4. Déployer Nginx avec Ansible

```bash
cd ../ansible/
ansible-playbook -i inventory.ini playbook.yml --private-key ~/.ssh/id_rsa
```

> Ansible installe Nginx, le démarre et déploie la page HTML automatiquement.

***

## 🌐 Accès à la page web

Une fois le déploiement terminé, ouvre ton navigateur sur :

```
http://<TON_IP>
```

***

## 🏗️ Architecture

```
Poste Local (Debian)
    │
    ├── terraform apply ──────────► AWS
    │                                ├── VPC (Réseau)
    │                                ├── Subnet
    │                                ├── Security Group (port 80 + 22)
    │                                └── EC2 Ubuntu (t2.micro)
    │
    └── ansible-playbook ─── SSH ──► EC2
                                      ├── Installation Nginx
                                      ├── Démarrage Nginx
                                      └── Déploiement index.html
                                            │
                                            └──► 🌐 Internet (HTTP :80)
```

***

## 🧹 Supprimer l'infrastructure

Pour éviter des frais AWS, détruis les ressources après utilisation :

```bash
cd terraform/
terraform destroy
```

***

## 💡 Cas d'usage

**En perso :**
- Héberger un portfolio en ligne
- Déployer une application web personnelle
- Recréer un environnement en 5 minutes après un crash

**En entreprise :**
- Déployer des dizaines de serveurs identiques en une commande
- Reproduire un environnement de production pour les tests
- Automatiser l'ouverture de nouveaux datacenters

***

## 👤 Auteur

**Tomas** — Master Systèmes, Réseaux & Cloud Computing  
GitHub : [@Thommas3153](https://github.com/Thommas3153)

***

## 📄 Licence

MIT License
