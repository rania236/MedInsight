# 🔧 Ansible - MedInsight Infrastructure

## 📁 Structure

```
ansible/
├── ansible.cfg              # Configuration Ansible
├── requirements.yml         # Dépendances Galaxy
├── inventory/
│   └── hosts.yml           # Inventaire des serveurs
└── playbooks/
    ├── setup-k8s-node.yml      # Configuration des nœuds K8s
    ├── deploy-medinsight.yml   # Déploiement de l'application
    ├── backup-databases.yml    # Backup des BDD
    └── check-cluster-health.yml # Vérification santé cluster
```

## 🚀 Installation

```bash
# 1. Installer Ansible
pip install ansible

# 2. Installer les dépendances
cd ansible
ansible-galaxy install -r requirements.yml

# 3. Configurer votre clé SSH
chmod 400 ~/.ssh/labuser.pem
```

## 📋 Playbooks disponibles

### 1. Configuration des nœuds Kubernetes
```bash
ansible-playbook playbooks/setup-k8s-node.yml
```

### 2. Déploiement de MedInsight
```bash
# Staging
ansible-playbook playbooks/deploy-medinsight.yml -e "env=staging"

# Production
ansible-playbook playbooks/deploy-medinsight.yml -e "env=prod"

# Avec une image spécifique
ansible-playbook playbooks/deploy-medinsight.yml \
  -e "env=staging" \
  -e "image_tag_patient=ghcr.io/rania236/medinsight/patient-service:v1.2.3"
```

### 3. Backup des bases de données
```bash
ansible-playbook playbooks/backup-databases.yml -e "env=staging"
```

### 4. Vérification de la santé du cluster
```bash
ansible-playbook playbooks/check-cluster-health.yml
```

## 🔐 Variables sensibles

Créez un fichier `ansible/vault.yml` pour les secrets :

```bash
ansible-vault create vault.yml
```

Contenu :
```yaml
ghcr_auth: '{"auths":{"ghcr.io":{"auth":"base64_encoded_token"}}}'
db_password: your_secure_password
```

Utilisation :
```bash
ansible-playbook playbooks/deploy-medinsight.yml --ask-vault-pass
```

## 🔗 Intégration CI/CD

Ajoutez dans votre `.github/workflows/ci.yml` :

```yaml
- name: Deploy with Ansible
  run: |
    pip install ansible kubernetes
    ansible-galaxy install -r ansible/requirements.yml
    ansible-playbook ansible/playbooks/deploy-medinsight.yml \
      -e "env=staging" \
      -e "image_tag_patient=${{ env.IMAGE_TAG_PATIENT }}"
```

## 📝 Commandes utiles

```bash
# Tester la connectivité
ansible all -m ping

# Voir les facts d'un hôte
ansible master-node -m setup

# Dry-run (check mode)
ansible-playbook playbooks/deploy-medinsight.yml --check

# Verbose mode
ansible-playbook playbooks/deploy-medinsight.yml -vvv
```
