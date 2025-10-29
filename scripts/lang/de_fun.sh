#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# Service-Auswahl Nachrichten
# -----------------------------------------------------------------------------
export MSG_CHOOSE_SERVICE="✨ Hey, welcher Service soll es denn heute sein? "
export MSG_INVALID_SELECTION="❌ Ups! Das war wohl nix. Versuch's nochmal!"
export MSG_SELECT_NUMBER="🔢 Deine Wahl (Nummer)"
export MSG_SELECT=" Ausgewählt – sehr gute Wahl!"
export MSG_SERVICE_SELECTED="✅ Dienst erfolgreich ausgewählt:"

# -----------------------------------------------------------------------------
# Umgebungs-/Variablen-Fehler
# -----------------------------------------------------------------------------
export MSG_ERROR_ENV_NOT_SET="⚠️ Hoppla! Diese Umgebungsvariable fehlt noch."
export MSG_ERROR_AWS_NOT_SET="⚠️ AWS-Variable vermisst! Ohne geht's nicht."
export MSG_TARGET_FILE_NOT_FOUND="📂 Ziel-Datei '%s'? Die hat sich wohl versteckt."
export MSG_MISSING_REQ_VAR="⚠️ Oh nein! Die Variable '%s' fehlt noch."
export MSG_MISSING_VAR="⚠️ Fehlende Variable '%s' – wir brauchen sie!"

# -----------------------------------------------------------------------------
# Authentifizierung / AWS
# -----------------------------------------------------------------------------
export MSG_AUTHENTICATION_FAILED="❌ Authentifizierung für '%s' fehlgeschlagen. Nervt, ich weiß."
export MSG_CREDENTIAL_ALREADY_SET="🔑 AWS-Zugangsdaten für '%s' sind schon da. Top!"
export MSG_AUTHENTICATION_SUCCESSFULLY="✅ Erfolgreich eingeloggt für '%s'. Super!"
export MSG_AUTH_SUCCESS="🎉 Authentifizierung geklappt. Party!"

# -----------------------------------------------------------------------------
# Session / Verbindung
# -----------------------------------------------------------------------------
export MSG_SESSION_STARTED="🚀 SSM-Sitzung gestartet. Alles klar zum Abheben!"
export MSG_CONFIRM_CONNECT="🔗 Willst du wirklich verbinden? [J/n] (Trau dich!) "
export MSG_TOKEN_VALIDITY="⏱ Token ist 15 Minuten gültig – also beeilen!"
export MSG_ABORTED="🛑 Abgebrochen. Kein Stress."
export MSG_DISCONNECTED="⚡ Verbindung zu %s getrennt. Tschüssikowski!"

# -----------------------------------------------------------------------------
# Service / DB Info
# -----------------------------------------------------------------------------
export MSG_SERVICE="🛠  Service"
export MSG_DB="🗄  DB-Name"
export MSG_USER="👤 Benutzer"
export MSG_CONNECT="🔌 Verbinden? [J/n] Los geht's!"
export MSG_COMMAND="💻 Befehl"
