from db import db
from api.ethereum import ethereum_client


def add_preloaded_bets_to_blockchain():
    bets = db.get_all_bets() 
    for bet in bets:
        
        # Place bet
        user1 = db.get_user(bet['user1'])
        amount = bet['ammount']
        user1_public_key = user1['public_key']
        bet_id = bet['bet_id']
        ethereum_client.create_bet(bet_id, amount, user1_public_key)

        # Accept bet
        if bet['accepted']:
            user2_public_key = db.get_user(bet['user2'])['public_key']
            ethereum_client.accept_bet(bet_id, amount, user2_public_key)

    return

if __name__ == "__main__":
    add_preloaded_bets_to_blockchain()
