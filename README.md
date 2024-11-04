## Superfluid Foundry Boilerplate

**Superfluid is a Token Infrastructure Protocol which brings Money Streaming and infinitely scalable distributions, through an upgraded version of ERC-20s called Super Tokens**

This repository consists of:
- A development environment compatible with [Foundry](https://book.getfoundry.sh/).
- A boiletplate smart contract `SuperfluidBoilerplate.sol` which allows you to understand the common patterns of writing a smart contract using the SuperTokenV1Library, including creating/updating/deleting flows, as well as managing Distribution Pools
- A test file `SuperfluidBoilerplate.t.sol` which allows you to deploy the protocol and start running your tests.

## Documentation

- Superfluid Docs: https://docs.superfluid.finance/
- Foundry Docs: https://book.getfoundry.sh/

## Usage

### Install

```shell
$ forge install
```

This will install a new branch of the package which contains some experimental functions as well.

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```