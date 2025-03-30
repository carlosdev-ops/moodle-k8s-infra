# Déploiement de Moodle avec Helm sur K3s (Bitnami)

## 📌 Objectif
Déployer Moodle sur un cluster Kubernetes K3s local en utilisant le chart Helm officiel Bitnami.

---

## 🚀 Étapes de déploiement

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm install moodle bitnami/moodle \
  --namespace moodle \
  --create-namespace \
  --set mariadb.auth.rootPassword=admin123 \
  --set moodleUsername=admin \
  --set moodlePassword=admin123 \
  --set moodleEmail=admin@example.com
```

---

## 📡 Accès à l'application

Même si le `LoadBalancer` est en `<pending>`, K3s utilise un composant appelé `klipper-lb` qui redirige automatiquement vers un `NodePort`.

```bash
kubectl get svc moodle -n moodle
```

Exemple :
```
NAME     TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)                      AGE
moodle   LoadBalancer   10.43.56.151   <pending>     80:30397/TCP,443:32311/TCP   13m
```

👉 Accéder à Moodle via :
```
http://<IP-du-node>:30397
ex: http://10.0.0.143:30397
```

---

## 🔐 Identifiants de connexion

```bash
echo Username: admin
echo Password: admin123
```

---

## ✅ Vérification

```bash
kubectl get pods -n moodle -o wide
kubectl logs -n moodle -l app.kubernetes.io/name=moodle --tail=50
```

Le log doit afficher des requêtes HTTP sur `/login/index.php` avec le code 200 :
```
"GET /login/index.php HTTP/1.1" 200 21935
```

---

## 🧠 Notes importantes

- Ce déploiement n'est pas prêt pour la production (mot de passe en clair, `ALLOW_EMPTY_PASSWORD=yes`, pas de persistance configurée).
- Pour de la haute disponibilité, prévoir une solution de stockage type NFS ou Longhorn.
- Ajouter Ingress ou ExternalIP si besoin d'accès via un nom de domaine local.

---

📁 Fichier généré automatiquement pour Obsidian (Carlos, 2025-03-30)
