require('babel-register');
require('babel-polyfill');


var HDWalletProvider = require("truffle-hdwallet-provider")
var mnemonic = "(Frase semilla aqui...)"


module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*" // Match any network id
    },
   
    rinkeby : {
      provider: function() {
        return new HDWalletProvider(mnemonic, "https://mainnet.infura.io/v3/0f022e46925944f89b3dcb597d935e15")
      },
    network_id: 4,
    gas: 4500000,
    gasPrice: 10000000000,
  
    },
   
  },
  contracts_directory: './src/contracts/',
  contracts_build_directory: './src/abis/',
  compilers: {
    solc: {
      version: "0.8.0" ,
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  }
}
