#!/bin/bash

# Chemin vers le Vault Obsidian
OBSIDIAN_PATH="$HOME/Obsidian/Moodle-K8s/Moodle Kubernetes"
# Dossier de destination dans le dépôt Git
DEST_PATH="$HOME/moodle-k8s-infra/docs"

# Créer le dossier docs s'il n'existe pas
mkdir -p "$DEST_PATH"

# Copier les fichiers .md
cp "$OBSIDIAN_PATH"/*.md "$DEST_PATH"

# Se placer dans le dépôt
cd "$HOME/moodle-k8s-infra"

# Ajouter, committer et pousser
git add docs/
git commit -m "📝 Synchronisation des notes Obsidian de la semaine"
git push
