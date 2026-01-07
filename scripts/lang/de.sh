#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# Service-Auswahl Nachrichten
# -----------------------------------------------------------------------------
export MSG_CHOOSE_SERVICE="✨ Bitte wählen Sie einen Service aus:"
export MSG_INVALID_SELECTION="❌ Ungültige Auswahl! Bitte erneut versuchen."
export MSG_SELECT_NUMBER="🔢 Auswahl (Nummer)"
export MSG_SELECT="🖱 Auswahl"
export MSG_SERVICE_SELECTED="✅ Dienst erfolgreich ausgewählt:"

# -----------------------------------------------------------------------------
# Umgebungs-/Variablen-Fehler
# -----------------------------------------------------------------------------
export MSG_ERROR_ENV_NOT_SET="⚠️ Die Umgebungsvariable ist nicht gesetzt!"
export MSG_ERROR_AWS_NOT_SET="⚠️ Die AWS-Variable ist nicht gesetzt!"
export MSG_TARGET_FILE_NOT_FOUND="📂 Ziel-Datei nicht gefunden "
export MSG_MISSING_REQ_VAR="⚠️ Fehlende erforderliche Variable: "
export MSG_MISSING_VAR="⚠️ Fehlende Variable: "

# -----------------------------------------------------------------------------
# Authentifizierung / AWS
# -----------------------------------------------------------------------------
export MSG_NEW_REGION_RECONNECT="Änderung in REGION oder ROLE erkannt – erneute Authentifizierung..."
export MSG_NO_SERVICE_JUMBHOST="In der Region wurde kein laufender EC2-Jumphost gefunden."
export MSG_AUTHENTICATION_FAILED="❌ Authentifizierung für Service fehlgeschlagen: "
export MSG_CREDENTIAL_ALREADY_SET="🔑 AWS-Zugangsdaten bereits gesetzt für Service: "
export MSG_AUTHENTICATION_SUCCESSFULLY="✅ Erfolgreich authentifiziert für Service: "
export MSG_AUTH_SUCCESS="🎉 Authentifizierung erfolgreich."
export MSG_REFRESH_AWS_CREDENTIALS="Aktualisierung der AWS-Anmeldedaten..."
export MSG_CONNECTION_FAILED_AFTER_REFRESH="Verbindung nach Aktualisierung der Authentifizierung fehlgeschlagen"

# -----------------------------------------------------------------------------
# Session / Verbindung
# -----------------------------------------------------------------------------
export MSG_STARTING_JUMBHOST="SSM-Sitzung über Jumphost starten"
export MSG_SESSION_STARTED="🚀 SSM-Sitzung gestartet."
export MSG_TOKEN_VALIDITY="⏱ Token 15 Minuten gültig."
export MSG_ABORTED="🛑 Abgebrochen"
export MSG_DISCONNECTED="⚡ Verbindung getrennt von "

# -----------------------------------------------------------------------------
# Service / DB Info
# -----------------------------------------------------------------------------
export MSG_SERVICE="🛠 Service"
export MSG_DB="🗄 DB-Name"
export MSG_USER="👤 Benutzer"
export MSG_COMMAND="💻 Befehl"
