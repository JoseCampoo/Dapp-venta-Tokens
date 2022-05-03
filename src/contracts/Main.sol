// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./Token_jose.sol";

contract main {

    //Instancia del contrato token
    ERC20Basic private token;

    //Owner del contrato
    address public owner;

    //Direccion del Smart Contract
    address public contrato;

    //Constructor
    constructor () {
        token = new ERC20Basic(10000);
        owner = msg.sender;
        contrato = address(this);
    }
     
     //Obtenemos la dirección del owner
    function getOwner() public view returns (address) {
        return owner;

    }

    //Establecer el precio de un token
    function PrecioTokens(uint _numTokens) internal pure returns (uint) {
     return _numTokens*(1 ether);
    }

     // Obtenemos la direccion del Smart Contract
    function getContract() public view returns (address) {
        return contrato;

    }
     
     //Compramos tokens mediante : direccion de destino y cantidad
     function send_tokens (address _destinatario, uint _numTokens) public payable {
         //Filtrar el numero de tokens a comprar por address
         require (_numTokens <= 10, "La cantidad de tokens excede el limite de compra");
         //Establecer el precio de los tokens
         uint coste = PrecioTokens(_numTokens);
         //Evaluamos la cantidad de tokens que quiere  comprar el cliente
         require(msg.value >= coste, "compra mas ethers o compra menos tokens");
         //Diferencia de lo que el cliente paga
         uint returnValue = msg.value - coste;
         //Devuelve la cantidad de compra determinada payable(msg.sender) en versión ^0.8.0
         payable(msg.sender).transfer(returnValue);
         //Balance de tokens disponibles para comprar
         uint Balance = balance_total();
         require(_numTokens <= Balance, "Compra un numero menor de Tokens");
         //Transferencia de los tokens al destinatario
         token.transfer(_destinatario, _numTokens);
      
     }

     //Generar más tokens al contrato
     function GeneraTokens(uint _numTokens) public onlybyOwner(){
         token.increaseTotalSupply(_numTokens);
     } 

     //Modificador que permita la ejecucion solo del owner
     modifier onlybyOwner() {
         require(msg.sender == owner, "No tienes permisos para ejecutar esta funcion");
       _;
     }


     //Obtenemos el balance de tokens de una direccioón
     function balance_direccion(address _direccion) public view returns (uint){
         return token.balanceOf(_direccion);
     
     }

     //Obtenemos el balance de tokens del Smart Contract
     function balance_total() public view returns (uint) {
         return token.balanceOf(contrato);
         
     }
}

