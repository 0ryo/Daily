var playerCard = 0
var dealerCard = 0

var isPlayerPlaying = true
var isDealerPlaying = true

func playerTurn(playerCard: Int, command: String) -> Int{
    var playerCard = playerCard
    let command = command
    
    while isPlayerPlaying {
        if command == "hit" {
            playerCard += Int.random(in: 1...10)
            if playerCard > 21 {
                print("Player Bust! You LOSE...")
                playerCard = -1
                isPlayerPlaying = false
            }
            print("Hit! Player Hands: \(playerCard)")
        } else if command == "stand" {
            print("Player stands. Player Hands: \(playerCard)")
            isPlayerPlaying = false
        }
    }
    
    return playerCard
}

func dealerTurn(dealerCard: Int) -> Int{
    var dealerCard = dealerCard
    
    if dealerCard <= 16 {
        dealerCard += Int.random(in: 1...10)
        if dealerCard > 21 {
            print("Dealer Bust! You WIN!")
            dealerCard = -1
            isDealerPlaying = false
        }
        print("Hit! Dealer Hands: \(dealerCard)")
    } else if dealerCard >= 17 {
        print("dealer stands. dealer Hands: \(dealerCard)")
        isPlayerPlaying = false
    }
    
    return dealerCard
}

while isPlayerPlaying && isDealerPlaying {
    guard let command = readLine() else {
        print("hit/standのいずれかのコマンドを入力してください。")
        continue
    }
    if command != "hit" && command != "stand" {
        print("hit/standのいずれかのコマンドを入力してください。")
        continue
    }
    
    let playerResult = playerTurn(playerCard: playerCard, command: command)
    let dealerResult = dealerTurn(dealerCard: dealerCard)
    
    // 勝敗
    if playerResult > dealerResult {
        print("Player wins!")
        break
    } else if playerResult < dealerResult {
        print("Dealer wins!")
        break
    } else if playerResult == dealerResult {
        print("It's a tie!")
        break
    }
}

