/**
 * Script de gestion du consentement RGPD pour les cookies
 * Bloque les cookies non essentiels avant consentement
 */

document.addEventListener('DOMContentLoaded', function() {
    // Vérifier si le consentement a déjà été donné
    const consent = localStorage.getItem('cookieConsent');
    
    // Si aucun consentement, afficher la bannière
    if (!consent) {
        showCookieBanner();
    } else {
        // Appliquer le consentement existant
        applyConsent(consent);
    }
});

/**
 * Afficher la bannière de cookies
 */
function showCookieBanner() {
    const banner = document.createElement('div');
    banner.className = 'cookie-consent-banner alert alert-light fixed-bottom m-0';
    banner.role = 'alert';
    banner.style.zIndex = '1000';
    
    banner.innerHTML = `
        <div class="container">
            <div class="row align-items-center">
                <div class="col-12 col-md-8">
                    <h5 class="mb-2">🍪 Gestion des cookies</h5>
                    <p class="mb-0 small">
                        Nous utilisons des cookies pour améliorer votre expérience. 
                        Vous pouvez choisir quels cookies accepter ou les refuser.
                    </p>
                </div>
                <div class="col-12 col-md-4 text-md-right mt-2 mt-md-0">
                    <button class="btn btn-sm btn-outline-dark mr-2" onclick="rejectCookies()">
                        Tout refuser
                    </button>
                    <button class="btn btn-sm btn-outline-primary mr-2" onclick="acceptNecessaryCookies()">
                        Necessaires uniquement
                    </button>
                    <button class="btn btn-sm btn-primary" onclick="acceptAllCookies()">
                        Tout accepter
                    </button>
                </div>
            </div>
        </div>
    `;
    
    document.body.appendChild(banner);
}

/**
 * Accepter tous les cookies
 */
function acceptAllCookies() {
    localStorage.setItem('cookieConsent', 'all');
    applyConsent('all');
    hideCookieBanner();
}

/**
 * Accepter uniquement les cookies nécessaires
 */
function acceptNecessaryCookies() {
    localStorage.setItem('cookieConsent', 'necessary');
    applyConsent('necessary');
    hideCookieBanner();
}

/**
 * Refuser tous les cookies (sauf nécessaires)
 */
function rejectCookies() {
    localStorage.setItem('cookieConsent', 'none');
    applyConsent('none');
    hideCookieBanner();
}

/**
 * Appliquer le consentement
 */
function applyConsent(consentType) {
    console.log('Applying cookie consent:', consentType);
    
    // Toujours autoriser les cookies nécessaires
    if (consentType === 'all' || consentType === 'necessary') {
        // Les cookies nécessaires sont toujours activés
    }
    
    // Autoriser les cookies analytiques si consentement complet
    if (consentType === 'all') {
        loadGoogleAnalytics();
        loadOtherAnalytics();
    }
    
    // Envoyer l'événement de consentement à Google Analytics (si chargé)
    if (typeof gtag === 'function') {
        gtag('consent', 'update', {
            'ad_storage': consentType === 'all' ? 'granted' : 'denied',
            'analytics_storage': consentType === 'all' ? 'granted' : 'denied'
        });
    }
}

/**
 * Charger Google Analytics (uniquement après consentement)
 */
function loadGoogleAnalytics() {
    console.log('Loading Google Analytics...');
    
    // Créer le script Google Analytics
    const script = document.createElement('script');
    script.async = true;
    script.src = 'https://www.googletagmanager.com/gtag/js?id=G-E0X6Z15DG6';
    document.head.appendChild(script);
    
    // Configurer Google Analytics avec anonymisation IP
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('js', new Date());
    gtag('config', 'G-E0X6Z15DG6', {
        'anonymize_ip': true,
        'allow_ad_personalization_signals': false
    });
    
    console.log('Google Analytics loaded with privacy settings');
}

/**
 * Charger d'autres outils analytiques
 */
function loadOtherAnalytics() {
    // Ajouter ici d'autres outils si nécessaire
    console.log('Other analytics could be loaded here');
}

/**
 * Masquer la bannière de cookies
 */
function hideCookieBanner() {
    const banner = document.querySelector('.cookie-consent-banner');
    if (banner) {
        banner.style.display = 'none';
    }
}

/**
 * Fonction pour l'ancienne bannière (compatibilité)
 */
window.nk_hideCookieBanner = function() {
    acceptAllCookies();
};

// Exposer les fonctions globalement pour le HTML
window.acceptAllCookies = acceptAllCookies;
window.acceptNecessaryCookies = acceptNecessaryCookies;
window.rejectCookies = rejectCookies;