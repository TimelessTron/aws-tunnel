# Dev-CLI für AWS-Services

## 📖 Sinn und Zweck

Dieses Projekt ist ein **Developer CLI Tool**, das es Entwicklern erleichtert, auf unterschiedliche AWS-Services zuzugreifen, Datenbankverbindungen herzustellen und SSM-Sessions zu starten – alles über einen **einheitlichen Docker-Container**.
Es bietet eine **komfortable Auswahl von Services**, automatisches Laden der Umgebungsvariablen, Authentifizierung via AWS und Okta, sowie direkte MySQL/MariaDB-Verbindungen über lokale Port-Weiterleitungen.

## ⚙️ Installation

1. Repository klonen:

```bash
git clone https://github.com/TimelessTron/aws-tunnel.git
cd aws-tunnel
cp .env.template .env
```

2. Installation von Docker & Docker Compose sicherstellen:

```bash
docker --version
docker compose version
```

3. Container bauen:

```bash
make build
```

## 📝 Konfiguration

1. **Services definieren:**
   Im Ordner `services/` werden die Services als `.env` Dateien abgelegt.
   Beispielstruktur:

```text
services/
├─ Frontend/
│  ├─ Stage
│  │  ├─ DB-A.env
│  │  └─ DB-B.env
│  └─ Prod
│     ├─ DB-A.env
│     └─ DB-B.env
└─ Backend/
  ├─ Stage
  │  ├─ DB-A.env
  │  └─ DB-B.env
  └─ Prod
     ├─ DB-A.env
     └─ DB-B.env
``` 
2. **Service-Umgebungsvariablen** in der `services/*.env` Datei definieren:

```dotenv
NAME="Mein Service"
REGION="eu-central-1"
ROLE="arn:aws:iam::123456789:role/DeveloperAccess"
SSM_DOCUMENT_NAME="AWS-StartPortForwardingSession"
SSM_HOST="mydb.rds.amazonaws.com"
SSM_HOST_PORT=3306
SSM_CLIENT_PORT=33071
DB_USER="devuser"
DB_NAME="devdb"
```

## 🚀 Benutzung

Alle Aktionen laufen **innerhalb des Docker-Containers**. Folgende Commands stehen zur Verfügung:

| Befehl         | Beschreibung                             |
| -------------- |------------------------------------------|
| `make run`     | Tunnel und SSM-Session starten           |
| `make build`   | Container bauen                          |
| `make clean`   | Container, Images und Netzwerk entfernen |
| `make console` | Interaktive Konsole starten              |
| `make print`   | Den MySQL-Connect-Befehl anzeigen        |
| `make connect` | Direkt zur MySQL-Datenbank verbinden     |
| `make help`    | Übersicht über alle Commands             |

**Beispiel:**

1. Service auswählen:

```bash
make run
```

* Wähle den gewünschten Service aus der Liste.
* Automatische Authentifizierung und SSM-Session werden gestartet.

2. MySQL-Verbindung:
Öffne ein neues Terminal. (Alte Terminal muss offen bleiben)
```bash
make print
# oder direkt verbinden:
make connect
```

## 🌟 Besonderheiten

* **Automatische Service-Auswahl** aus `.env` Dateien in Unterordnern (`Prod`, `Stage`, …).
* **Dynamisches Laden von Umgebungsvariablen** in `TARGET_FILE` und `AUTH_ENV_FILE`.
* **SSM-Session über Jumphost** mit automatischer Portweiterleitung.
* **AWS- und Okta-Authentifizierung** integriert.
* **Mehrsprachige Ausgabe** (Deutsch, Englisch, Spanisch, Französisch).
* **Fun-Feedback** bei Aktionen für ein lockeres Entwicklererlebnis.
* **MySQL/MariaDB Auth-Token** werden automatisch generiert und optional in die Zwischenablage kopiert.

## 👥 Zielgruppe

Dieses Projekt richtet sich an:

* Entwickler, die regelmäßig auf **verschiedene AWS-Umgebungen** zugreifen müssen
* Teams, die **schnell und sicher MySQL-Datenbanken** erreichen wollen
* DevOps, die **SSM-Sessions** automatisiert starten möchten
* Alle, die ein **schickes CLI-Tool** mit Emojis, Mehrsprachigkeit und Fun-Feedback mögen
