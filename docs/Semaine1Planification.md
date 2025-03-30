# 📘 Semaine 1 – Planification du projet Moodle sur Kubernetes

## 🎯 Objectifs du projet

- Déployer Moodle dans Kubernetes avec 3 environnements isolés :
  - `dev` pour le développement
  - `stage` pour les tests avant production
  - `prod` pour les utilisateurs finaux
- Assurer la haute disponibilité (HA)
- Permettre des mises à jour sans interruption (rolling update)
- Garantir la tolérance à la perte d’un worker

---

## 🧱 Architecture cible (à dessiner ou détailler)

- 🖥️ Proxmox avec :
	  - 1 master K8s
	  - 2 workers K8s
- 📦 Volumes persistants via hostPath ou local-path-provisioner
- 🌐 Ingress Controller (traefik ou nginx)
- 🌳 3 namespaces : `dev`, `stage`, `prod`
- 🛡️ Fichiers de configuration versionnés dans GitHub



---


# 🧠 Planification de la Semaine 1

Pour le résumé final, voir : [[Semaine1Recapitulatif]]

## 🗂️ Structure du dépôt GitHub

```bash
moodle-k8s-infra/
├── infra/          # Scripts pour déployer le cluster
├── k8s/
│   ├── dev/        # Déploiement Moodle DEV
│   ├── stage/      # Déploiement Moodle STAGE
│   └── prod/       # Déploiement Moodle PROD
├── scripts/        # Automatisation Bash / Python
├── tests/          # Tests de panne / résilience
├── docs/           # Ajout des notes Obsidian dans le dossier docs
├── README.md       # Présentation du projet
└── .gitignore      # Fichiers à ignorer

