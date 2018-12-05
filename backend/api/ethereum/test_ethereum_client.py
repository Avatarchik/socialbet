import ethereum_client
from web3 import Web3
import sys

def create_bet_test():
    w3 = Web3(Web3.HTTPProvider("http://127.0.0.1:8545"))
    test_account = w3.eth.accounts[0]
    bet_id = 1
    amount = 0.2
    ethereum_client.create_bet(bet_id, amount, test_account)

def accept_bet_test():
    w3 = Web3(Web3.HTTPProvider("http://127.0.0.1:8545"))
    test_account = w3.eth.accounts[0]
    bet_id = 1
    amount = 0.2
    ethereum_client.accept_bet(bet_id, amount, test_account)


if __name__ == "__main__":
    if sys.argv[1] == 'create_bet':
        create_bet_test()
    elif sys.argv[1] == 'accept_bet':
        accept_bet_test()
