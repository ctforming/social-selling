# Règles de Développement - Site CT Forming

## 📋 Règle Fondamentale

**Le site doit rester 100% statique HTML** - Aucune exception.

## 🚫 Interdictions

- **Pas de backend** : Pas de PHP, Node.js, Python, Ruby, ou tout autre langage serveur
- **Pas de base de données** : Pas de MySQL, PostgreSQL, MongoDB, etc.
- **Pas de CMS** : Pas de WordPress, Joomla, Drupal, ou systèmes similaires
- **Pas de frameworks complexes** : Pas de React, Angular, Vue.js, ou SPA complexes
- **Pas de générateurs de sites statiques** : Pas de Jekyll, Hugo, Gatsby, etc.

## ✅ Autorisé

- **HTML5** pur et simple
- **CSS3** pour le style (y compris préprocesseurs comme SASS si compilé en CSS statique)
- **JavaScript vanilla** pour les interactions client-side
- **jQuery** et autres bibliothèques client-side simples
- **Fichiers statiques** : HTML, CSS, JS, images, PDFs, etc.
- **Inclusions manuelles** : Copier-coller de sections communes entre pages
- **Outils de build simples** : Pour minification, optimisation d'images, etc. (mais le résultat final doit être du HTML statique)

## 🔧 Processus de Modification

1. **Toutes les modifications** doivent aboutir à des fichiers HTML statiques
2. **Pour les sections communes** (header, footer, menu) :
   - Copier manuellement les modifications dans chaque page concernée
   - Ou utiliser un script simple de build (comme le `build_pages.py` fourni) qui génère du HTML statique
3. **Pour ajouter une nouvelle page** :
   - Créer un nouveau fichier HTML dans le dossier `pages/`
   - Copier la structure de base d'une page existante
   - Modifier uniquement le contenu spécifique
   - Mettre à jour le menu de navigation dans toutes les pages

## 📁 Structure à Respecter

```
/
├── index.html              # Page de redirection principale
├── pages/                 # Toutes les pages du site
│   ├── accueil.html       # Page d'accueil
│   ├── pedagogie.html     # Méthodes pédagogiques
│   ├── contexte.html       # Contexte
│   ├── formations.html     # Formations
│   └── temoignages.html   # Témoignages
├── images/                # Images et assets
├── css/                   # Feuilles de style
├── js/                    # Scripts JavaScript
├── vendors/               # Bibliothèques tierces
└── doc/                   # Documents PDF
```

## 🛠 Outils Recommandés

- **Éditeurs de code** : VS Code, Sublime Text, Atom
- **Optimisation** : 
  - `html-minifier` pour minifier le HTML
  - `cssnano` pour minifier le CSS
  - `uglify-js` pour minifier le JavaScript
  - `imagemin` pour optimiser les images
- **Validation** : W3C Validator pour vérifier la conformité HTML/CSS

## 📝 Bonnes Pratiques

1. **Maintenir la cohérence** : Toutes les pages doivent avoir la même structure de base
2. **Chemins relatifs** : Toujours utiliser des chemins relatifs (`../images/logo.png`) pour les assets
3. **Accessibilité** : Respecter les standards WCAG pour l'accessibilité
4. **SEO** : Garder les balises meta, titres et structure sémantique
5. **Performance** : Optimiser les images et minifier les assets
6. **Documentation** : Commenter le code lorsque nécessaire

## 🔄 Mise à Jour du Menu

Lorsque vous ajoutez ou modifiez une page :
1. Ajouter le lien dans le menu de **toutes** les pages existantes
2. Utiliser la même structure de menu partout
3. Tester la navigation entre toutes les pages

## 📊 Exceptions Autorisées

Aucune exception n'est autorisée à la règle du site 100% statique. Si une fonctionnalité nécessite un backend, elle doit être :
- Implémentée via un service tiers (ex: Formspree pour les formulaires)
- Ou abandonnée

## ✅ Validation

Avant de déployer :
- [ ] Toutes les pages sont des fichiers HTML statiques
- [ ] Aucun fichier serveur (.php, .js, .py, etc.) n'est présent
- [ ] Tous les liens fonctionnent correctement
- [ ] Le site s'affiche correctement hors ligne
- [ ] Aucune dépendance à un serveur ou une base de données

**Rappel** : Ce site est conçu pour être hébergé sur des services statiques comme GitHub Pages, Netlify, ou un simple hébergement web basique. Toute modification doit préserver cette compatibilité.