## Installation of Finalizer Operator using docker

Mainnet Gasp AVS Registry Contract: [0x9A986296d45C327dAa5998519AE1B3757F1e6Ba1](https://etherscan.io/address/0x9A986296d45C327dAa5998519AE1B3757F1e6Ba1)
Testnet Gasp AVS Registry Contract: [0xb4dd45a08BFA6fBC19F7cD624cdfef87CE95e7AC](https://holesky.etherscan.io/address/0xb4dd45a08BFA6fBC19F7cD624cdfef87CE95e7AC)

### Prerequisites:
* Docker installed
* Eigenlayer CLI installed

> NOTE: For any Docker based commands, if you have installed as root then you might have to append `sudo` in front of the command.

### Core operations
* Allowing the embedded Gasp rollup-node to sync
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
```

#### Prepare the the `.env` file

Copy the `.env.mainnet` or `.env.testnet` file to `.env` file depending on the network where you plan to run `gasp-avs` operator.
Update the `TODO` section in the  `.env` file given in the root directory of the repository with your own details

#### Run operator to sync the Gasp node

We need the target Gasp node synced to the Gasp blockchain network before the operator can function. To do this simply run the operator and it will wait for the Gasp node to sync before proceeding.

```bash
docker compose up -d
```
Once the sync has completed, the operator will check the regsitration of the operator with the avs. Avs registration (opt-in) is different from the Eigenlayer registration. Since we haven't performed the avs registration yet, the operator will request you to complete avs registration first before proceeding (you can check the operator logs with `docker compose logs -f`).

Now stop the operator with:

```bash
docker compose down
```

It is recomended that the sync completes before you register with the avs - since you may get kicked for inactivity while the node is syncing

#### Register with the AVS

> NOTE: Operator registration may be temporarily paused by the Gasp team. If you receive an error message saying "Pausable: index is paused", please wait for an announcement when registration is reopened.

```bash
# To register with the avs run the opt-in command
docker compose run --rm gasp-avs /app/gasp-avs opt-in-avs
```

#### Run Operator

```bash
# Start the operator
docker compose up -d
# Check the logs
docker compose logs -f
# Check `gasp-avs` status
docker compose exec gasp-avs /app/gasp-avs print-status
```

### Stop Operator

```bash
docker compose down
# You may also need to remove the `rollup-node` stored data
# You can do this by removing the `data` directory:
# rm -rf ./data
```
### Opt-out into AVS

```bash
docker compose exec gasp-avs /app/gasp-avs opt-out
```

### Upgrade your node
Upgrade the AVS software for your `gasp-avs` operator service setup by following the steps below:

```bash
cd avs-operator-setup
git pull
docker compose up -d
```
