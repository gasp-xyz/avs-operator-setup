## Installation of Mangata Finalizer Operator using docker

AVS Service Contract: [0xD2333E11ea617E30fb97900f6ac9782A85f233e7](https://goerli.etherscan.io/address/0xD2333E11ea617E30fb97900f6ac9782A85f233e7)

### Prerequisites:
* Docker installed
* Eigenlayer CLI installed

> NOTE: For any Docker based commands, if you have installed as root then you might have to append `sudo` in front of the command.

### Core operations
* Register your operator to eigenlayer using [Eigenlayer CLI](https://github.com/Layr-Labs/eigenlayer-cli)

### Setup Operator
The easiest way to set up is to clone the repo and follow the instructions below.

#### Clone repo
Clone this repo and execute the following commands:
```bash
git clone https://github.com/mangata-finanace/avs-operator-setup.git
cd avs-operator-setup
chmod +x run.sh
```
Update the `TODO` sections in the  `.env` file given in the root directory of the repository with your own details:

### Opt-in into Mangata AVS
```bash
./run.sh opt-in
```

### Run MangataFinalizer Operator
Execute the following command to start the docker containers:
```
docker compose up -d
```
you can view the logs using:
```
docker logs -f <container_id>
```
Tear down container
```bash
docker compose down
```
### Opt-out into Mangata AVS
```bash
./run.sh opt-out
```
### Upgrade your node

Upgrade the AVS software for your Mangata Finalizer service setup by following the steps below:

**Step 1:** Pull the latest repo

```
cd avs-operator-setup
git pull
```

**Step 2:** Pull the latest docker images

```
docker compose pull
```

**Step 3:** Stop the existing services

```
docker compose down
```

**Step 4:** Start your services again

If there are any specific instructions that needs to be followed for any upgrade, those instructions will be given with the release notes of the specific release. Please check the latest [release notes](https://github.com/mangata-finance/avs-operator-setup/releases) on Github and follow the instructions before starting the services again.

```
docker compose up -d
```
