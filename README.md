# GLPI Docker Stack

## 📦 Description

Ce projet permet de déployer **GLPI 10** avec Docker en utilisant une architecture à 3 services :

* GLPI (Apache + PHP)
* MySQL 8.0
* Redis 7

L’ensemble est orchestré avec **Docker Compose**.

---

## Architecture

* 1 conteneur GLPI (application web)
* 1 conteneur MySQL (base de données)
* 1 conteneur Redis (cache)
* Volumes Docker pour la persistance
* Réseau Docker interne

---

## 📁 Structure du projet

```id="9q8l6q"
.
├── docker-compose.yml
├── .env
├── .env.example
├── .gitignore
├── Dockerfile
├── entrypoint.sh
└── glpi-apache.conf
```

---

## Prérequis

* Docker
* Docker Compose

---

## Configuration

Créer un fichier `.env` :

```bash id="x6r4p1"
cp .env.example .env
```

Exemple :

```id="3z7cwb"
MYSQL_ROOT_PASSWORD=rootpass
MYSQL_DATABASE=glpi
MYSQL_USER=glpi
MYSQL_PASSWORD=glpi123

MYSQL_DEFAULT_AUTHENTICATION_PLUGIN=mysql_native_password

GLPI_DB_HOST=db
GLPI_DB_NAME=glpi
GLPI_PORT=8080
```

---

## Lancement

```bash id="n4h6kp"
docker compose up -d
```

---

## Accès

```id="m7d2qa"
http://localhost:8080
```

---

## Installation

Lors du premier lancement :

* Serveur SQL : `db`
* Utilisateur : `MYSQL_USER`
* Mot de passe : `MYSQL_PASSWORD`
* Base : `MYSQL_DATABASE`

---

##  Volumes

* db_data → données MySQL
* glpi_files → fichiers GLPI
* glpi_config → configuration

---

## 🔁 Mise à jour

```bash id="u8z1tr"
docker build -t glpi-docker .
docker tag glpi-docker hukago7/glpi-docker:latest
docker push hukago7/glpi-docker:latest
docker compose up -d --force-recreate
```

---

##  Arrêt

```bash id="s2y5vj"
docker compose down
```

Suppression des volumes :

```bash id="k9p3nb"
docker compose down -v
```

---

## ⚠️ Sécurité

Après installation il faut supprimer le répertoire :

```bash id="d7r8xf"
docker exec -it glpi rm -rf /var/www/html/install
```

---

## 🐳 Image Docker

```id="y6c4qm"
hukago7/glpi-docker:latest
```

