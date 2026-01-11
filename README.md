# Site CT Forming - Système de Génération

## 📋 Structure du Projet

```

/
├── build.js               # Script Node.js pour générer les pages
├── package.json           # Configuration Node.js
├── README.md              # Ce fichier
├── index.html             # Page de redirection principale
├── 
├── partials/              # ⭐ Éléments COMMUNS (à ne pas modifier souvent)
│   ├── header.html        # En-tête de toutes les pages
│   ├── menu.html          # Menu de navigation
│   ├── footer.html        # Pied de page et scripts
│   └── modals.html        # Fenêtres modales (contact, cookies, etc.)
│
├── content/               # ⭐ Contenu SPÉCIFIQUE (votre femme gère ça !)
│   ├── accueil.html       # Contenu de la page d'accueil
│   ├── pedagogie.html     # Contenu de la page pédagogie
│   ├── contexte.html      # Contenu de la page contexte
│   ├── formations.html    # Contenu de la page formations
│   └── temoignages.html   # Contenu de la page témoignages
│
└── pages/                 # 📁 Pages finales GÉNÉRÉES (ne pas modifier manuellement)
    ├── accueil.html       # Page complète générée automatiquement
    ├── pedagogie.html     # Page complète générée automatiquement
    └── ...                # Autres pages générées
```

## 🚀 Comment Utiliser ce Système

### 1. Pour générer toutes les pages

```bash
node build.js
```

Ce script va :
1. Lire les fichiers dans `partials/` (éléments communs)
2. Lire les fichiers dans `content/` (contenu spécifique)
3. Assembler le tout pour créer les pages complètes
4. Écrire les pages finales dans `pages/`

### 2. Pour modifier le contenu d'une page

**Votre femme doit uniquement modifier les fichiers dans `content/`**

Exemple : Pour changer le texte de la page d'accueil :
1. Ouvrir `content/accueil.html`
2. Modifier le contenu HTML
3. Exécuter `node build.js` pour regénérer

### 3. Pour modifier le menu ou le footer

**Modifier les fichiers dans `partials/`**

Exemple : Pour changer un lien dans le menu :
1. Ouvrir `partials/menu.html`
2. Modifier le menu
3. Exécuter `node build.js` pour regénérer toutes les pages

## 📝 Procédure de Maintenance

### Ajouter une nouvelle page

1. **Créer le contenu spécifique** :
   - Créer un nouveau fichier dans `content/` (ex: `content/nouvelle-page.html`)
   - Ajouter le contenu HTML spécifique

2. **Mettre à jour le script** :
   - Ouvrir `build.js`
   - Ajouter la nouvelle page dans le tableau `pages`:
   ```javascript
   const pages = [
       // ... pages existantes
       { name: 'nouvelle-page', title: 'Nouvelle Page' }
   ];
   ```

3. **Ajouter au menu** :
   - Ouvrir `partials/menu.html`
   - Ajouter un lien vers la nouvelle page

4. **Générer** :
   ```bash
   node build.js
   ```

### Modifier une page existante

1. **Modifier le contenu** :
   - Ouvrir `content/nom-de-la-page.html`
   - Faire les modifications nécessaires

2. **Générer** :
   ```bash
   node build.js
   ```

## 🎯 Règles Importantes

✅ **À faire** :
- Modifier uniquement les fichiers dans `content/` pour le contenu
- Modifier les fichiers dans `partials/` pour les éléments communs
- Exécuter `node build.js` après toute modification
- Tester les pages générées dans `pages/`

❌ **À éviter** :
- Ne pas modifier directement les fichiers dans `pages/` (ils seront écrasés)
- Ne pas supprimer les répertoires `partials/`, `content/`, ou `pages/`
- Ne pas ajouter de technologies serveur (PHP, Node.js backend, etc.)

## 📚 Exemple Pratique

**Scenario** : Votre femme veut modifier le texte "Méthodes & outils pédagogiques"

1. **Ouvrir le fichier** :
   ```bash
   # Sous Windows: double-clic sur content/pedagogie.html
   # Sous Mac/Linux: 
   open content/pedagogie.html
   ```

2. **Modifier le texte** :
   ```html
   <!-- Trouver et modifier cette ligne -->
   <h2>Méthodes & outils pédagogiques</h2>
   <!-- Par exemple -->
   <h2>Nos méthodes pédagogiques innovantes</h2>
   ```

3. **Générer les pages** :
   ```bash
   node build.js
   ```

4. **Vérifier le résultat** :
   - Ouvrir `pages/pedagogie.html` dans un navigateur
   - Vérifier que le changement est visible

## 🛠 Installation (si Node.js n'est pas installé)

1. **Installer Node.js** :
   - Télécharger depuis https://nodejs.org/
   - Suivre les instructions d'installation

2. **Vérifier l'installation** :
   ```bash
   node --version
   npm --version
   ```

3. **Installer les dépendances** (si besoin) :
   ```bash
   npm install
   ```

## 💡 Astuces

- **Pour voir les changements rapidement** : Ouvrez deux fenêtres côte à côte (contenu + page générée)
- **Pour tester** : Utilisez le navigateur pour ouvrir directement les fichiers HTML
- **Sauvegarde** : Faites des copies des fichiers avant les modifications importantes

## 📊 Résumé

| Répertoire | Rôle | Qui modifie | Fréquence |
|------------|------|-------------|-----------|
| `partials/` | Éléments communs | Développeur | Rarement |
| `content/` | Contenu spécifique | Votre femme | Souvent |
| `pages/` | Pages finales | Script | Toujours |
| `build.js` | Script de build | Développeur | Rarement |

**Le site reste 100% statique HTML** comme requis ! 🎉