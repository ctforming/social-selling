#!/bin/bash

# Script de gestion Docker pour CT Forming
# Ce script fournit un menu interactif pour gérer facilement les containers Docker

# Couleurs pour l'affichage
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Fonction pour afficher le header
show_header() {
    clear
    echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║${NC}            🚀 CT FORMING DOCKER MANAGER ${BLUE}║${NC}"
    echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

# Fonction pour vérifier si Docker est installé
check_docker() {
    if ! command -v docker &> /dev/null; then
        echo -e "${RED}❌ Erreur: Docker n'est pas installé ou n'est pas dans le PATH${NC}"
        echo "Veuillez installer Docker avant d'utiliser ce script."
        echo "https://docs.docker.com/get-docker/"
        exit 1
    fi
    
    if ! docker info &> /dev/null; then
        echo -e "${RED}❌ Erreur: Le démon Docker ne semble pas démarré${NC}"
        echo "Veuillez démarrer Docker avant d'utiliser ce script."
        exit 1
    fi
}

# Fonction pour vérifier si docker-compose est disponible
check_docker_compose() {
    if ! command -v docker-compose &> /dev/null; then
        echo -e "${YELLOW}⚠️  Attention: docker-compose n'est pas trouvé${NC}"
        echo "Le script va essayer d'utiliser 'docker compose' à la place..."
        sleep 2
    fi
}

# Fonction pour exécuter docker-compose (avec fallback)
run_docker_compose() {
    if command -v docker-compose &> /dev/null; then
        docker-compose -f docker/docker-compose.yml "$@"
    else
        docker compose -f docker/docker-compose.yml "$@"
    fi
}

# Menu principal
main_menu() {
    show_header
    
    echo -e "${GREEN}📋 MENU PRINCIPAL${NC}"
    echo ""
    echo "1. 🚀 Démarrer tout (génération + serveur web)"
    echo "2. 🔄 Redémarrer tout (avec rebuild)"
    echo "3. 🛠️  Générer uniquement le site"
    echo "4. 🌐 Lancer uniquement le serveur web"
    echo "5. 🔄 Redémarrer le serveur web"
    echo "6. 📦 Construire les images Docker"
    echo "7. 🔴 Arrêter tous les containers"
    echo "8. 🧹 Nettoyer (arrêter + supprimer containers)"
    echo "9. 🗑️  Nettoyage complet (images + volumes)"
    echo "10. 📜 Voir les logs"
    echo "11. 📊 Voir l'état des containers"
    echo "12. 🔧 Configuration avancée"
    echo "0. 🚪 Quitter"
    echo ""
    
    read -p "Votre choix (0-12): " choice
    
    case $choice in
        1) start_all ;;
        2) restart_all ;;
        3) generate_only ;;
        4) web_only ;;
        5) restart_web ;;
        6) build_images ;;
        7) stop_containers ;;
        8) clean_containers ;;
        9) full_cleanup ;;
        10) view_logs ;;
        11) view_status ;;
        12) advanced_menu ;;
        0) exit 0 ;;
        *) 
            echo -e "${RED}❌ Choix invalide${NC}"
            sleep 2
            main_menu
            ;;
    esac
}

# Menu avancé
advanced_menu() {
    show_header
    
    echo -e "${GREEN}🔧 MENU AVANCÉ${NC}"
    echo ""
    echo "1. 🐳 Exécuter une commande personnalisée"
    echo "2. 📦 Exécuter une commande dans le container web"
    echo "3. 🔄 Mettre à jour les dépendances"
    echo "4. 📋 Voir les images Docker"
    echo "5. 📋 Voir les volumes Docker"
    echo "6. 📋 Voir les réseaux Docker"
    echo "7. 🔄 Revenir au menu principal"
    echo "0. 🚪 Quitter"
    echo ""
    
    read -p "Votre choix (0-7): " choice
    
    case $choice in
        1) custom_command ;;
        2) exec_in_web ;;
        3) update_dependencies ;;
        4) list_images ;;
        5) list_volumes ;;
        6) list_networks ;;
        7) main_menu ;;
        0) exit 0 ;;
        *) 
            echo -e "${RED}❌ Choix invalide${NC}"
            sleep 2
            advanced_menu
            ;;
    esac
}

# 1. Démarrer tout
start_all() {
    show_header
    echo -e "${GREEN}🚀 Démarrage complet du site...${NC}"
    echo ""
    
    run_docker_compose up --build -d
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Site démarré avec succès !${NC}"
        echo "Le site est disponible sur: http://localhost:8080"
    else
        echo -e "${RED}❌ Échec du démarrage${NC}"
    fi
    
    read -p "Appuyez sur Entrée pour continuer..." 
    main_menu
}

# 2. Redémarrer tout
restart_all() {
    show_header
    echo -e "${YELLOW}🔄 Redémarrage complet...${NC}"
    echo ""
    
    run_docker_compose down
    run_docker_compose up --build -d
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Site redémarré avec succès !${NC}"
        echo "Le site est disponible sur: http://localhost:8080"
    else
        echo -e "${RED}❌ Échec du redémarrage${NC}"
    fi
    
    read -p "Appuyez sur Entrée pour continuer..." 
    main_menu
}

# 3. Générer uniquement le site
generate_only() {
    show_header
    echo -e "${YELLOW}🛠️  Génération du site...${NC}"
    echo ""
    
    run_docker_compose build generator
    run_docker_compose run generator
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Site généré avec succès !${NC}"
        echo "Les pages ont été générées dans le dossier 'pages/'"
    else
        echo -e "${RED}❌ Échec de la génération${NC}"
    fi
    
    read -p "Appuyez sur Entrée pour continuer..." 
    main_menu
}

# 4. Lancer uniquement le serveur web
web_only() {
    show_header
    echo -e "${YELLOW}🌐 Lancement du serveur web...${NC}"
    echo ""
    
    run_docker_compose up -d web
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Serveur web démarré avec succès !${NC}"
        echo "Le site est disponible sur: http://localhost:8080"
    else
        echo -e "${RED}❌ Échec du lancement du serveur web${NC}"
    fi
    
    read -p "Appuyez sur Entrée pour continuer..." 
    main_menu
}

# 5. Redémarrer le serveur web
restart_web() {
    show_header
    echo -e "${YELLOW}🔄 Redémarrage du serveur web...${NC}"
    echo ""
    
    run_docker_compose restart web
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Serveur web redémarré avec succès !${NC}"
    else
        echo -e "${RED}❌ Échec du redémarrage${NC}"
    fi
    
    read -p "Appuyez sur Entrée pour continuer..." 
    main_menu
}

# 6. Construire les images
build_images() {
    show_header
    echo -e "${YELLOW}📦 Construction des images Docker...${NC}"
    echo ""
    
    run_docker_compose build
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Images construites avec succès !${NC}"
    else
        echo -e "${RED}❌ Échec de la construction${NC}"
    fi
    
    read -p "Appuyez sur Entrée pour continuer..." 
    main_menu
}

# 7. Arrêter les containers
stop_containers() {
    show_header
    echo -e "${YELLOW}🔴 Arrêt des containers...${NC}"
    echo ""
    
    run_docker_compose stop
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Containers arrêtés avec succès !${NC}"
    else
        echo -e "${RED}❌ Échec de l'arrêt${NC}"
    fi
    
    read -p "Appuyez sur Entrée pour continuer..." 
    main_menu
}

# 8. Nettoyer les containers
clean_containers() {
    show_header
    echo -e "${YELLOW}🧹 Nettoyage des containers...${NC}"
    echo ""
    
    run_docker_compose down
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Containers nettoyés avec succès !${NC}"
    else
        echo -e "${RED}❌ Échec du nettoyage${NC}"
    fi
    
    read -p "Appuyez sur Entrée pour continuer..." 
    main_menu
}

# 9. Nettoyage complet
full_cleanup() {
    show_header
    echo -e "${RED}🗑️  Nettoyage complet (images + volumes + containers)...${NC}"
    echo ""
    echo "⚠️  Cette opération va supprimer:"
    echo "   - Tous les containers arrêtés"
    echo "   - Toutes les images non utilisées"
    echo "   - Tous les volumes non utilisés"
    echo "   - Tous les réseaux non utilisés"
    echo ""
    
    read -p "Êtes-vous sûr ? (y/N): " confirm
    
    if [[ $confirm == "y" || $confirm == "Y" ]]; then
        echo ""
        echo -e "${YELLOW}🧹 Nettoyage en cours...${NC}"
        
        # Arrêter et supprimer les containers
        run_docker_compose down --volumes --rmi all --remove-orphans
        
        # Nettoyage système Docker
        docker system prune -a -f
        
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✅ Nettoyage complet terminé !${NC}"
        else
            echo -e "${RED}❌ Échec du nettoyage${NC}"
        fi
    else
        echo -e "${GREEN}✅ Opération annulée${NC}"
    fi
    
    read -p "Appuyez sur Entrée pour continuer..." 
    main_menu
}

# 10. Voir les logs
view_logs() {
    show_header
    echo -e "${GREEN}📜 Affichage des logs...${NC}"
    echo ""
    echo "1. Voir les logs du générateur"
    echo "2. Voir les logs du serveur web"
    echo "3. Voir tous les logs"
    echo "4. Suivre les logs en temps réel"
    echo "5. Retour au menu"
    echo ""
    
    read -p "Votre choix (1-5): " log_choice
    
    case $log_choice in
        1) run_docker_compose logs generator ;;
        2) run_docker_compose logs web ;;
        3) run_docker_compose logs ;;
        4) run_docker_compose logs -f ;;
        5) main_menu ;;
        *) 
            echo -e "${RED}❌ Choix invalide${NC}"
            sleep 2
            view_logs
            ;;
    esac
    
    read -p "Appuyez sur Entrée pour continuer..." 
    main_menu
}

# 11. Voir l'état
view_status() {
    show_header
    echo -e "${GREEN}📊 État des containers...${NC}"
    echo ""
    
    run_docker_compose ps
    
    read -p "Appuyez sur Entrée pour continuer..." 
    main_menu
}

# 12. Commande personnalisée
custom_command() {
    show_header
    echo -e "${GREEN}🐳 Exécution d'une commande Docker personnalisée${NC}"
    echo ""
    
    read -p "Entrez votre commande Docker: " custom_cmd
    
    if [ -n "$custom_cmd" ]; then
        echo ""
        echo -e "${YELLOW}Exécution: docker $custom_cmd${NC}"
        echo ""
        docker $custom_cmd
    else
        echo -e "${RED}❌ Aucune commande saisie${NC}"
    fi
    
    read -p "Appuyez sur Entrée pour continuer..." 
    advanced_menu
}

# 13. Exécuter dans le container web
exec_in_web() {
    show_header
    echo -e "${GREEN}📦 Exécution d'une commande dans le container web${NC}"
    echo ""
    
    read -p "Entrez votre commande (ex: ls -la): " web_cmd
    
    if [ -n "$web_cmd" ]; then
        echo ""
        echo -e "${YELLOW}Exécution: $web_cmd${NC}"
        echo ""
        run_docker_compose exec web $web_cmd
    else
        echo -e "${RED}❌ Aucune commande saisie${NC}"
    fi
    
    read -p "Appuyez sur Entrée pour continuer..." 
    advanced_menu
}

# 14. Mettre à jour les dépendances
update_dependencies() {
    show_header
    echo -e "${GREEN}🔄 Mise à jour des dépendances...${NC}"
    echo ""
    
    echo "Cette fonctionnalité mettra à jour:"
    echo "- Les images Docker"
    echo "- Les dépendances Node.js (si nécessaire)"
    echo ""
    
    read -p "Voulez-vous continuer ? (y/N): " update_confirm
    
    if [[ $update_confirm == "y" || $update_confirm == "Y" ]]; then
        echo ""
        echo -e "${YELLOW}🔄 Mise à jour en cours...${NC}"
        
        # Mettre à jour les images de base
        docker pull node:18-alpine
        docker pull nginx:alpine
        
        # Reconstruire les images
        run_docker_compose build --pull --no-cache
        
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✅ Mise à jour terminée !${NC}"
        else
            echo -e "${RED}❌ Échec de la mise à jour${NC}"
        fi
    else
        echo -e "${GREEN}✅ Opération annulée${NC}"
    fi
    
    read -p "Appuyez sur Entrée pour continuer..." 
    advanced_menu
}

# 15. Lister les images
list_images() {
    show_header
    echo -e "${GREEN}📋 Liste des images Docker${NC}"
    echo ""
    
    docker images
    
    read -p "Appuyez sur Entrée pour continuer..." 
    advanced_menu
}

# 16. Lister les volumes
list_volumes() {
    show_header
    echo -e "${GREEN}📋 Liste des volumes Docker${NC}"
    echo ""
    
    docker volume ls
    
    read -p "Appuyez sur Entrée pour continuer..." 
    advanced_menu
}

# 17. Lister les réseaux
list_networks() {
    show_header
    echo -e "${GREEN}📋 Liste des réseaux Docker${NC}"
    echo ""
    
    docker network ls
    
    read -p "Appuyez sur Entrée pour continuer..." 
    advanced_menu
}

# Point d'entrée principal
main() {
    check_docker
    check_docker_compose
    main_menu
}

# Démarrer le script
main