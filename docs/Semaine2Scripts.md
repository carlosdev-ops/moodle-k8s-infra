
## Script : deploy-moodle-bitnami.sh

Ce script automatise le déploiement de Moodle dans un cluster Kubernetes à l'aide du chart Helm officiel de Bitnami. Il effectue un nettoyage préalable, déploie Moodle avec MariaDB, puis affiche les informations de connexion.

---

### ✅ Objectifs

- Supprimer toute installation précédente de Moodle
    
- Installer Moodle et sa base de données MariaDB via Helm
    
- Attendre que les pods soient disponibles
    
- Afficher l'adresse d'accès ainsi que les identifiants
    

---

### ⚙️ Contenu du script

```bash
#!/bin/bash

set -e

NAMESPACE="moodle"
RELEASE_NAME="moodle"

echo "🧹 Nettoyage précédent..."
helm uninstall "$RELEASE_NAME" -n "$NAMESPACE" || true
kubectl delete pvc --all -n "$NAMESPACE" || true
kubectl delete namespace "$NAMESPACE" || true
sleep 5

echo "📦 Ajout du dépôt Bitnami (si nécessaire)..."
helm repo add bitnami https://charts.bitnami.com/bitnami || true
helm repo update

echo "🚀 Déploiement de Moodle..."
helm install "$RELEASE_NAME" bitnami/moodle \
  --namespace "$NAMESPACE" \
  --create-namespace \
  --set mariadb.auth.rootPassword=admin123 \
  --set moodleUsername=admin \
  --set moodlePassword=admin123 \
  --set moodleEmail=admin@example.com

echo -e "\n⏳ Attente du démarrage des pods..."
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=moodle -n "$NAMESPACE" --timeout=300s
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=mariadb -n "$NAMESPACE" --timeout=300s

echo -e "\n🌐 Récupération des informations d'accès :"

NODE_IP=$(kubectl get node -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}')
NODE_PORT=$(kubectl get svc -n "$NAMESPACE" "$RELEASE_NAME" -o jsonpath='{.spec.ports[?(@.port==80)].nodePort}')

echo -e "\n🔗 Moodle est accessible à l'adresse : http://$NODE_IP:$NODE_PORT"
echo "👤 Utilisateur : admin"
echo "🔑 Mot de passe : admin123"
```

---

Attention : Moodle est accessible à l'adresse : http://10.0.0.2 2607:fa49:9440:7200::eaf5:==32354== --> c'est le port et l'adresse : 10.0.0.143 du worker1


### 📄 Fichier : `deploy-moodle-bitnami.sh`

- Rendre exécutable : `chmod +x deploy-moodle-bitnami.sh`
    
- Lancer : `./deploy-moodle-bitnami.sh`
    

---

### 🔧 Prochaine étape ?

- Ajouter la persistance des volumes ?
    
- Ajouter un Ingress ?
    
- Créer une version avec valeurs Helm personnalisées via `values.yaml` ?
-
- Souhaites-tu aussi une version avec **persistance des volumes** sur le disque local (`hostPath`) pour la prod/test longue durée ?