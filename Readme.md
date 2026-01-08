# Dev-CLI for AWS Services

## 📖 Purpose
This project is a **Developer CLI Tool** that makes it easier for developers to access various AWS services, establish database connections, and start SSM sessions—all through a **unified Docker container**.
It offers a **convenient service selection**, automatic loading of environment variables, authentication via AWS and Okta, and direct MySQL/MariaDB connections through local port forwarding.

## ⚙️ Installation
1. Clone the repository:

```bash
git clone https://github.com/TimelessTron/aws-tunnel.git
cd aws-tunnel
cp .env.template .env
```

2. Ensure Docker & Docker Compose are installed:

```bash
docker --version
docker compose version
```

3. Build the container:
```bash
make build
```

## 📝 Configuration
1. **Define services:**
   Service configurations are stored as `.env` files in the `services/` directory.
   Example structure:
```text
services
├─ Frontend
│  ├─ Stage
│  │  ├─ DB-A.env
│  │  └─ DB-B.env
│  └─ Prod
│     ├─ DB-A.env
│     └─ DB-B.env
└─ Backend
  ├─ Stage
  │  ├─ DB-A.env
  │  └─ DB-B.env
  └─ Prod
     ├─ DB-A.env
     └─ DB-B.env
```
2. **Set service environment variables** in the `services/*.env` file:
```dotenv
NAME="My Service"
REGION="eu-central-1"
ROLE="arn:aws:iam::123456789:role/DeveloperAccess"
SSM_DOCUMENT_NAME="AWS-StartPortForwardingSession"
SSM_HOST="mydb.rds.amazonaws.com"
SSM_HOST_PORT=3306
SSM_CLIENT_PORT=33071
DB_USER="devuser"
DB_NAME="devdb"
```

## 🚀 Usage
All actions run **inside the Docker container**. The following commands are available: \

| Command                   | Description                              |
|---------------------------| ---------------------------------------- |
| `make run`     | Start tunnel and SSM session             |
| `make build`   | Build container                          |
| `make clean`   | Remove container, images, and network    |
| `make console` | Start interactive console                |
| `make print`   | Display the MySQL connect command        |
| `make connect` | Connect directly to the MySQL database   |
| `make help`    | Overview of all commands                 |

**Example:**
1. Select a service: \
   `make run`
* Choose the desired service from the list.
* Automatic authentication and SSM session will start.

2. MySQL connection: \
   Open a new terminal. (The old terminal must remain open.) \
   `make print` or \
   `make connect`
---

## 🌟 Features
* **Automatic service selection** from `.env` files in subdirectories (`Prod`, `Stage`, etc.).
* **Dynamic loading of environment variables** into `TARGET_FILE` and `AUTH_ENV_FILE`.
* **SSM session via jumphost** with automatic port forwarding.
* **AWS and Okta authentication** integrated.
* **Multilingual output** (German, English, Spanish, French).
* **Fun feedback** for actions, creating a relaxed developer experience.
* **MySQL/MariaDB auth tokens** are automatically generated and optionally copied to the clipboard.

## 👥 Target Audience
This project is aimed at:
* Developers who need to regularly access **different AWS environments**
* Teams who want to **quickly and securely reach MySQL databases**
* DevOps who want to **automate SSM sessions**
* Anyone who enjoys a **sleek CLI tool** with emojis, multilingual support, and fun feedback

---
