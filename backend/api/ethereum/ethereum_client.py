import web3
from web3 import Web3
from solc import compile_files
from solc import compile_source
from web3.contract import ConciseContract

contract_address = ''
def send_eth_to_contract(amount, users_private_key):
    web3.eth.sendTransaction(
        {'to': contract_address, 'from': users_private_key, 'value': web3.toWei(amount, "ether")})

def deploy_smart_contract():
    contract_source_code ='''
    pragma solidity ^0.4.25;
    contract SocialBetContract {

       address public ownerAddress;

        struct Bet {
            address user1Address;
            address user2Address;
            bool accepted;
            uint256 amount;
            bool completed;
        }

        mapping(uint256 => Bet) public betInfo;
        uint256[] public betIds;


        function() public payable {}

        // Smart contract constructor
        constructor() public payable {
            ownerAddress = msg.sender;
        }

        // Kill contract function
        function kill() public {
          if(msg.sender == ownerAddress) selfdestruct(ownerAddress);
        }

        // Check that bets exist function
        function checkBetExists(uint256 _betId) public constant
        returns(bool) {
            for(uint256 i = 0; i < betIds.length; i++ ) {
                if(betIds[i] == _betId) return true;
            }
          return false;

        }


        // Create bet function
        function createBet(uint256 _betId) public payable {

            // Make sure bet does not exist already
            require(!checkBetExists(_betId));

            // Create new bet
            betInfo[_betId].user1Address = msg.sender;
            betInfo[_betId].accepted = false;
            betInfo[_betId].amount = msg.value;
            betInfo[_betId].completed = false;

            betIds.push(_betId);
        }

        // Accept bet function
        function acceptBet(uint256 _betId) public payable {

            // Make sure bet exists
            require(checkBetExists(_betId));

            // Make sure bet is not yet accepted
            require(!betInfo[_betId].accepted);

            // Make sure bet not yet completed
            require(!betInfo[_betId].completed);

            // Make sure amount sent is right
            require(msg.value == betInfo[_betId].amount);

            // Update bet
            betInfo[_betId].user2Address = msg.sender;
            betInfo[_betId].accepted = true;

            betIds.push(_betId);
        }

        // Cancel bet function
        function cancelBet(uint256 _betId) public {

            // Make sure bet exists
            require(checkBetExists(_betId));

            // Make sure bet not yet completed
            require(!betInfo[_betId].completed);

            // Send money back to user1
            betInfo[_betId].user1Address.transfer(betInfo[_betId].amount * 97 / 100);

            // Send money back to user2
            if(betInfo[_betId].accepted) {
                betInfo[_betId].user2Address.transfer(betInfo[_betId].amount * 97 / 100);
            }

            // Set completed
            betInfo[_betId].completed = true;

        }

        // Distribute winnings function
        function distributeWinnings(uint256 _betId, uint8 _winner) public {

            // Make sure bet exists
            require(checkBetExists(_betId));

            // Make sure bet is accepted
            require(betInfo[_betId].accepted);

            // Make sure bet not yet completed
            require(!betInfo[_betId].completed);

            // Get winner address
            address winnerAddress;
            if(_winner == 1) {
                winnerAddress = betInfo[_betId].user1Address;
            } else {
                winnerAddress = betInfo[_betId].user2Address;
            }

            // Send winner money
            winnerAddress.transfer(betInfo[_betId].amount * 197 / 100);

            // Set completed
            betInfo[_betId].completed = true;

        }

    }
    '''

    # compile all contract files
    #contracts = compile_files(['SocialBetSmartContract.sol'])
    # separate main file and link file
    #compiled_sol = contracts.pop("SocialBetSmartContract.sol:SocialBetContract")
    compiled_sol = compile_source(contract_source_code)  # Compiled source code
    contract_interface = compiled_sol['<stdin>:Greeter']

    ###########

    # web3.py instance
    w3 = Web3(Web3.HTTPProvider("http://127.0.0.1:8545"))

    # set pre-funded account as sender
    w3.eth.defaultAccount = w3.eth.accounts[0]

    # Instantiate and deploy contract
    Greeter = w3.eth.contract(abi=contract_interface['abi'], bytecode=contract_interface['bin'])

    # Submit the transaction that deploys the contract
    tx_hash = Greeter.constructor().transact()

    # Wait for the transaction to be mined, and get the transaction receipt
    tx_receipt = w3.eth.waitForTransactionReceipt(tx_hash)

    print(tx_receipt)

    # Create the contract instance with the newly-deployed address
    contract_obj = w3.eth.contract(
        address=tx_receipt.contractAddress,
        abi=contract_interface['abi'],
    )




if __name__ == "__main__":
    deploy_smart_contract()

