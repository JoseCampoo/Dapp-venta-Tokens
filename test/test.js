//Llamada al contrato 'Main'
const Main = artifacts.require('Main');

contract('Main', accounts => {
    it('Funcion: getOwner()', async () => {
        //Smart contract desplegado
        let instance = await Main.deployed()
        const direccionOwner = await instance.getOwner.call()
        console.log('Accounts[0]:', accounts[0])
        console.log('Direccion del Owner', direccionOwner)
        assert.equal(accounts[0], direccionOwner)
        
    });

      
    it ('Funcion: send_tokens(address _destinatario, uint _numTokens)', async() => {
        //Smart contract desplegado
        let instance = await Main.deployed()
        
        //Balance inicial de tokens
        inicial_balance_direccion = await instance.balance_direccion.call(accounts[0])
        inicial_balance_total = await instance.balance_total.call()
        
        console.log('Balance de accounts[0]', inicial_balance_direccion)
        console.log('Balance del Smart Contract', inicial_balance_total)
        //Envio de tokens
        await instance.send_tokens(accounts[0], 10, {from: accounts[0]})
        
        //Balance una vez hecha la transaccion
        balance_direccion = await instance.balance_direccion.call(accounts[0])
        balance_total = await instance.balance_total.call()
        
        console.log('Balance de accounts[0]', balance_direccion)
        console.log('Balance del Smart Contract', balance_total)
        
        //Verificaciones
        assert.equal(balance_direccion, parseInt(inicial_balance_direccion) + 10)
        assert.equal(balance_total, parseInt(inicial_balance_total) - 10)
  
    });


})