import ethereum_client
from web3 import Web3
import sys
import web3

def get_contract_balance():
    w3 = Web3(Web3.HTTPProvider("http://127.0.0.1:8545"))
    balance = w3.eth.getBalance(ethereum_client.contract_address)
    return balance

def print_balance_change(before_balance, after_balance, eth=False):
    if not eth:
        return after_balance - before_balance
    eth_abs = Web3.fromWei(abs(after_balance - before_balance), 'ether')
    if before_balance > after_balance:
        return eth_abs * -1
    return eth_abs
   

amount = 10

def create_bet_test(bet_id=1, test_account=0):
    print()
    print('CREATE BET TEST')
    print('##############################')

    w3 = Web3(Web3.HTTPProvider("http://127.0.0.1:8545"))
    test_account = w3.eth.accounts[test_account]
    before_balance = w3.eth.getBalance(test_account)
    print('contract_balance: ' + str(get_contract_balance()))
    ethereum_client.create_bet(bet_id, amount, test_account)
    after_balance = w3.eth.getBalance(test_account)
    print('delta balance: ' + str(print_balance_change(before_balance, after_balance)))
    print('contract_balance: ' + str(get_contract_balance()))
def accept_bet_test(bet_id=1, test_account=0):
    print()
    print('ACCEPT BET TEST')
    print('##############################')
    w3 = Web3(Web3.HTTPProvider("http://127.0.0.1:8545"))
    test_account = w3.eth.accounts[test_account]
    before_balance = w3.eth.getBalance(test_account)
    print('contract_balance: ' + str(get_contract_balance()))
    ethereum_client.accept_bet(bet_id, amount, test_account)
    after_balance = w3.eth.getBalance(test_account)
    print('delta balance: ' + str(print_balance_change(before_balance, after_balance)))
    print('contract_balance: ' + str(get_contract_balance()))


def distribute_winnings_test(bet_id=1, winner=1, test_account=0):
    print()
    print('DISTRIBUTE WINNIGNS TEST')
    print('##############################')
    w3 = Web3(Web3.HTTPProvider("http://127.0.0.1:8545"))
    test_account = w3.eth.accounts[test_account]
    print(test_account)
    before_balance = w3.eth.getBalance(test_account)
    print('contract_balance: ' + str(get_contract_balance()))
    ethereum_client.distribute_winnings(bet_id, winner, test_account)
    after_balance = w3.eth.getBalance(test_account)
    print('delta balance: ' + str(print_balance_change(before_balance, after_balance)))
    print('contract_balance: ' + str(get_contract_balance()))

def full_test():
    bet_id = 7
    user1_account = 1
    user2_account = 2
    winner = 2
    create_bet_test(bet_id=bet_id, test_account=user1_account)
    accept_bet_test(bet_id=bet_id, test_account=user2_account)
    distribute_winnings_test(bet_id=bet_id, winner=winner, test_account=user2_account)


if __name__ == "__main__":
    if sys.argv[1] == 'create_bet':
        create_bet_test()
    elif sys.argv[1] == 'accept_bet':
        accept_bet_test(bet_id=99999999)
    elif sys.argv[1] == 'distribute_winnings':
        distribute_winnings_test(bet_id=9999999)
    elif sys.argv[1] == 'full_test': 
        full_test()
