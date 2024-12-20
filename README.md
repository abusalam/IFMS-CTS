# IFMS-CTS Pension Module

[![DotNet & Angular CI](https://github.com/abusalam/IFMS-CTS/actions/workflows/docker-compose-workflow.yml/badge.svg)](https://github.com/abusalam/IFMS-CTS/actions/workflows/docker-compose-workflow.yml)

## Setup the code repository

#### Prerequisites:
- Install [Docker Engine](https://docs.docker.com/engine/install/ubuntu/) and [Docker Compose (standalone)](https://docs.docker.com/compose/install/standalone/)  on Ubuntu
- On Windows OS using [WSL2](https://learn.microsoft.com/en-us/windows/wsl/install) is preferred.

Run the following commands to clone the whole repository

```sh
git clone https://github.com/abusalam/IFMS-CTS.git ifms-cts
cd ifms-cts
git submodule update --init --recursive
cp .env.docker .env
```

### Build Docker Images

Run the following command to build custom docker images to run this project

```sh
docker-compose build --build-arg HOST_UID=$UID
```
### Setup Oracle database (Optional)

Run the following commands

```sh
mkdir oracle-home/data
sudo chown 54321:54321 oracle-home/data
```

### Backup and Restore Oracle Database

Run the following commands to prepare the directory and put backup(*.dmp) files there and change the ownership of backup files also

```sh
mkdir oracle-home/backup
sudo chown 54321:54321 oracle-home/backup
```

Backup CTSPENSION Schema

```sh
docker-compose exec oracle expdp IPENSION/password@XEPDB1 schemas=CTSPENSION directory=EXP_DIR dumpfile=CTSPENSION.dmp logfile=CTSPENSION.log
```
Compress the Backup file

```sh
xz -zv9k oracle-home/backup/CTSPENSION.dmp
```

Restore CTSPENSION Schema as ICTS Schema

```sh
docker-compose exec oracle impdp IPENSION/password@XEPDB1 schemas=CTSPENSION directory=EXP_DIR dumpfile=CTSPENSION.dmp logfile=CTSPENSION.log remap_schema=CTSPENSION:ICTS
```

### You can start only required containers

To start dotnet container use the following command this will start only required stack for dotnet development

```sh
docker-compose up -d dotnet
```
or start angular using

```sh
docker-compose up -d angular
```

#### Or Start all containers

```sh
docker-compose up -d
```

![Docker Output](image.png)

Initially when you are setting up for the first time it may take a little longer time as oracle initializes it's database

You can check the progress of oracle database initialization by running the following command

```sh
docker-compose logs oracle
```
Output will look some thing like this when initialization is completed

![Docker Oracle Output](image-1.png)
After the first run it will just take a couple of seconds to start everything

### Login to Orcale using SqlPlus as dba

```sh
docker-compose exec oracle sqlplus sys/pgsql@localhost:1521/XE as sysdba
```
![Docker SqlPlus Output](image-2.png)

If you want to modify the database run the following query to switch from CDB(Container Database) to PDB(Pluggable Database)

```sql
alter session set container = XEPDB1;
```
Then you can run your CREATE, INSERT, UPDATE, DELETE queries after switching

During development you may need to restart the angular or dotnet servers if you make changes to the code that can't be hot reloaded.

Run the following command to restart the respective docker container
```sh
docker-compose restart angular
docker-compose restart dotnet
```
![alt text](image-3.png)

Also you can check the status by running the following command

```sh
docker-compose logs angular
docker-compose logs dotnet
```
![Docker Angular Server Output](image-4.png)
![Docker Dotnet Server Output](image-5.png)

Apply patch for environment settings to your codebase

```sh
cd angular
git apply ../ng-env.patch
cd ../dotnet/CTS-BE
git apply ../../dotnet-env.patch
```

Make host entry: add the following line to your `%WINDIR%\System32\drivers\etc\hosts` file

```
127.0.0.1	docker.test api.docker.test uat.docker.test rabbitmq.docker.test mailhog.docker.test
```
Open Angular UI http://docker.test/static-login

![Angular UI](image-6.png)

Open Dotnet Swagger UI http://api.docker.test/swagger/index.html

![Dotnet Swagger UI](image-7.png)

RabbitMQ Management UI http://rabbitmq.docker.test

- Default Login: `guest/guest`

![RabbitMQ Management UI](image-8.png)

### Don't forget to restore postgresql database backup using pgAdmin
```env
DB_HOST=localhost
DB_USER=docker
DB_PASSWORD=docker@1234
DB_NAME=docker
DB_PORT=5432
```
Enjoy!