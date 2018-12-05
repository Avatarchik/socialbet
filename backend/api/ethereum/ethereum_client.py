import web3
from web3 import Web3
from solc import compile_files
from solc import compile_source
from web3.contract import ConciseContract
import json
import sys

contract_address = '0x39E1E1e40119f97f44208faF9E8797b98466dF8a'
def send_eth_to_contract(amount, users_private_key):
    web3.eth.sendTransaction(
        {'to': contract_address, 'from': users_private_key, 'value': web3.toWei(amount, "ether")})

    def readCompiledFromJSON(cls, j):
        compiled = json.loads(j)

        contracts = list(compiled['contracts'].keys())
        if (len(contracts) > 1):
            print("Warning: more than one contract at once supplied. Reading the first one.")

        contract_name = contracts[0]
        print("Reading contract: ", contract_name.split(":")[1])

        compiled = compiled['contracts'][contract_name]
        compiled['abi'] = json.loads(compiled['abi'])  # abi is stored as a separate json object

        return compiled

def readCompiledFromJSON(j):
    compiled = json.loads(j)

    contracts = list(compiled['contracts'].keys())
    if (len(contracts) > 1):
        print("Warning: more than one contract at once supplied. Reading the first one.")

    contract_name = contracts[0]
    print("Reading contract: ", contract_name.split(":")[1])

    compiled = compiled['contracts'][contract_name]
    compiled['abi'] = json.loads(compiled['abi'])  # abi is stored as a separate json object

    return compiled
def deploy_smart_contract(contract_source):

    compiled_sol = readCompiledFromJSON(contract_source)
    #contract_interface = compiled_sol['<stdin>:SocialBetContract']
    contract_interface = compiled_sol

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
    deploy_smart_contract(sys.argv[1])

