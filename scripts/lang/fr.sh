#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# Messages de sélection de service
# -----------------------------------------------------------------------------
export MSG_CHOOSE_SERVICE="✨ Veuillez choisir un service :"
export MSG_INVALID_SELECTION="❌ Sélection invalide ! Veuillez réessayer."
export MSG_SELECT_NUMBER="🔢 Sélection (numéro)"
export MSG_SELECT=" sélection"
export MSG_SERVICE_SELECTED="✅ Service sélectionné avec succès :"

# -----------------------------------------------------------------------------
# Erreurs de variables / environnement
# -----------------------------------------------------------------------------
export MSG_ERROR_ENV_NOT_SET="⚠️ La variable d'environnement n'est pas définie !"
export MSG_ERROR_AWS_NOT_SET="⚠️ La variable AWS n'est pas définie !"
export MSG_TARGET_FILE_NOT_FOUND="📂 Fichier cible '%s' introuvable"
export MSG_MISSING_REQ_VAR="⚠️ Variable requise manquante : %s"
export MSG_MISSING_VAR="⚠️ Variable manquante : %s"

# -----------------------------------------------------------------------------
# Authentification / AWS
# -----------------------------------------------------------------------------
export MSG_AUTHENTICATION_FAILED="❌ Échec de l'authentification pour le service : %s"
export MSG_CREDENTIAL_ALREADY_SET="🔑 Identifiants AWS déjà définis pour le service : %s"
export MSG_AUTHENTICATION_SUCCESSFULLY="✅ Authentification réussie pour le service : %s"
export MSG_AUTH_SUCCESS="🎉 Authentification réussie."

# -----------------------------------------------------------------------------
# Session / connexion
# -----------------------------------------------------------------------------
export MSG_SESSION_STARTED="🚀 Session SSM démarrée."
export MSG_CONFIRM_CONNECT="🔗 Voulez-vous vous connecter maintenant ? [O/n] "
export MSG_TOKEN_VALIDITY="⏱ Token valide pendant 15 minutes."
export MSG_ABORTED="🛑 Annulé"
export MSG_DISCONNECTED="⚡ Déconnecté de %s"

# -----------------------------------------------------------------------------
# Informations sur le service / DB
# -----------------------------------------------------------------------------
export MSG_SERVICE="🛠 Service"
export MSG_DB="🗄 Nom de la DB"
export MSG_USER="👤 Utilisateur"
export MSG_CONNECT="🔌 Connecter ? [O/n] "
export MSG_COMMAND="💻 Commande"
