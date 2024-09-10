module.exports = {
  migrations_directory: "./migrations",
  networks: {
    development: {
      host: "localhost",
      port: 8545,
      network_id: "*" // Match any network id
    }
  },
  compilers: {
    solc: {
      version: "0.5.0", // Specify the version of the Solidity compiler
      settings: {
        optimizer: {
          enabled: false,
          runs: 200
        },
        evmVersion: "constantinople" // Use a valid EVM version for Solidity 0.5.0
      }
    }
  }
};

