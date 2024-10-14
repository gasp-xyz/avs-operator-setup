## Installation of Finalizer Operator using docker

AVS Registry Contract: [0xfd6A45621DDfeBF94C082e60E0De92aA305a97a1](https://holesky.etherscan.io/address/0xfd6A45621DDfeBF94C082e60E0De92aA305a97a1)

### Prerequisites:
* Docker installed
* Eigenlayer CLI installed

> NOTE: For any Docker based commands, if you have installed as root then you might have to append `sudo` in front of the command.

### Core operations
* Allowing the Gasp node to sync - this is the node that the `SUBSTRATE_RPC_URL` points to
* Register your operator to eigenlayer using [Eigenlayer CLI](https://github.com/Layr-Labs/eigenlayer-cli)
* Deposit your stake at [Eigenlayer App](https://holesky.eigenlayer.xyz/), see [Eigenlayer stake guide](https://docs.eigenlayer.xyz/restaking-guides/restaking-user-guide) for more info\
AVS supports [ankrETH, mETH, stETH, ETHx, osETH, sfrxETH, rETH, WETH] tokens provided by EigenLayer, with minimum of `10 ETH` total stake for operator registration
Max operators count is currently limited to 50, first come first served.
Operators are required to run their nodes with provided docker image. If a registered operator does not provide responses, an automatic check will eventually eject them from the AVS operators active list.
Operator stakes are updated regularly, if the stake drops below minimum required stake, operator will be ejected. 

### Setup Operator
The easiest way to set up is to clone the repo and follow the instructions below.

#### Join Eigenlayer
Deposit stake into eigenlayer using the [Eigenlayer App](https://holesky.eigenlayer.xyz/) and register on eigenlayer using the [Eigenlayer Cli](https://github.com/Layr-Labs/eigenlayer-cli)

Please save the keys generated/used in this step - they will be required

#### Clone our setup repo
Clone this repo and execute the following commands:
```bash
git clone https://github.com/gasp-xyz/avs-operator-setup.git
cd avs-operator-setup
chmod +x run.sh
```

#### Update the .env
Update the `TODO` sections in the  `.env` file given in the root directory of the repository with your own details

#### Run operator to sync the Gasp node
We need the target Gasp node synced to the Gasp blockchain network before the operator can function. To do this simply run the operator and it will wait for the Gasp node to sync 
```bash
docker compose up -d
```
Once the sync has completed, the operator will check the regsitration of the operator with the avs. Avs registration (opt-in) is different from the Eigenlayer registration. Since we haven't performed the avs registration yet, the operator will request you to complete avs registration first before proceeding (you can check the operator logs with `docker logs -f <container_id>`).

Now stop the operator with
```bash
docker compose down
```

It is recomended that the sync completes before you register with the avs - since you may get kicked for inactivity while the node is syncing

#### Register with the AVS
To register with the avs run the opt-in command
```bash
./run.sh opt-in
```

#### Run Operator
Now you are set to run the operator
Execute the following command to start the docker containers:
```
docker compose up -d
```
you can view the logs using:
```
docker logs -f <container_id>
```

### Stop Operator
Tear down container
```bash
docker compose down
```
### Opt-out into AVS
```bash
./run.sh opt-out
```
### Upgrade your node

Upgrade the AVS software for your Finalizer service setup by following the steps below:

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

If there are any specific instructions that needs to be followed for any upgrade, those instructions will be given with the release notes of the specific release. Please check the latest [release notes](https://github.com/gasp-xyz/avs-operator-setup/releases) on Github and follow the instructions before starting the services again.

```
docker compose up -d
```
