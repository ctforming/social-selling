// Script Node.js simple pour générer les pages HTML
// Utilisation : node build.js

const fs = require('fs');
const path = require('path');

// Créer le répertoire pages s'il n'existe pas
if (!fs.existsSync('../pages')) {
    fs.mkdirSync('../pages');
}

// Liste des pages à générer
const pages = [
    { name: 'accueil', title: 'Accueil' },
    { name: 'pedagogie', title: 'Pédagogie' },
    { name: 'contexte', title: 'Contexte' },
    { name: 'formations', title: 'Formations' },
    { name: 'temoignages', title: 'Témoignages' },
    { name: 'politique-confidentialite', title: 'Confidentialité' }
];

// Fonction pour lire un fichier
function readFile(filePath) {
    try {
        return fs.readFileSync(filePath, 'utf8');
    } catch (error) {
        console.error(`❌ Erreur lecture fichier ${filePath}:`, error.message);
        return '';
    }
}

// Fonction pour écrire un fichier
function writeFile(filePath, content) {
    try {
        fs.writeFileSync(filePath, content, 'utf8');
        console.log(`✅ Page générée: ${filePath}`);
    } catch (error) {
        console.error(`❌ Erreur écriture fichier ${filePath}:`, error.message);
    }
}

// Fonction pour générer une page
function buildPage(pageName, pageTitle) {
    // Lire tous les composants
    const header = readFile('partials/header.html');
    const menu = readFile('partials/menu.html');
    const content = readFile(`content/${pageName}.html`);
    const modals = readFile('partials/modals.html');
    const footer = readFile('partials/footer.html');
    
    // Remplacer le titre dans l'header
    const headerWithTitle = header.replace(
        '<title>CT Forming, LinkedIn & Inbound Marketing</title>',
        `<title>${pageTitle} - CT Forming, LinkedIn & Inbound Marketing</title>`
    );
    
    // Assembler la page complète
    const pageContent = `${headerWithTitle}
${menu}

<div class="content-wrapper">
  <div class="container">
    ${content}
  </div>
</div>

${modals}
${footer}`;
    
    // Écrire la page finale
    writeFile(`../pages/${pageName}.html`, pageContent);
}

// Générer toutes les pages
console.log('🚀 Début de la génération du site...');
pages.forEach(page => {
    buildPage(page.name, page.title);
});

console.log('🎉 Génération terminée !');
console.log('✨ Le site reste 100% statique HTML');