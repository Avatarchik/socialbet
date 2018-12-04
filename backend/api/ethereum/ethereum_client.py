import web3
from web3 import Web3
from solc import compile_files
from web3.contract import ConciseContract

contract_address = ''
def send_eth_to_contract(amount, users_private_key):
    web3.eth.sendTransaction(
        {'to': contract_address, 'from': users_private_key, 'value': web3.toWei(amount, "ether")})

def deploy_smart_contract():
    # compile all contract files
    contracts = compile_files(['SocialBetSmartContract.sol'])
    # separate main file and link file
    compiled_sol = contracts.pop("SocialBetSmartContract.sol:SocialBetContract")
    contract_interface = compiled_sol['<stdin>:Greeter']

    ###########

    # web3.py instance
    w3 = Web3(Web3.EthereumTesterProvider())

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

