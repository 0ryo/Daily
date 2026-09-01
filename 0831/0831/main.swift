var playerCard = [getNum(), getNum()]
var dealerCard = [getNum(), getNum()]

var isPlayerPlaying = true
var isDealerPlaying = true

func getNum() -> Int{
    let random = Int.random(in: 1...10)
    return random
}

func sumCards(_ cards: [Int]) -> Int {
    let sum = cards.reduce(0, +)
    return sum
}

func playerTurn(playerCard: [Int], command: String) -> [Int]{
    var playerCard: [Int] = playerCard
    let command = command
    
    if command == "hit" {
        playerCard.append(getNum())
        if sumCards(playerCard) > 21 {
            isPlayerPlaying = false
        } else {
            print("Hit! Player Hands: \(playerCard)")
        }
    } else if command == "stand" {
        print("Player stands. Player Hands: \(playerCard)")
        isPlayerPlaying = false
    }
    return playerCard
}

func dealerTurn(dealerCard: [Int]) -> [Int] {
    var dealerCard: [Int] = dealerCard
    
    if sumCards(dealerCard) <= 16 {
        dealerCard.append(getNum())
        if sumCards(dealerCard) > 21 {
            isDealerPlaying = false
        } else {
            print("Hit! Dealer Hands: \(dealerCard)")
        }
    } else if sumCards(dealerCard) >= 17 {
        print("dealer stands. dealer Hands: \(dealerCard)")
        isDealerPlaying = false
    }
    
    return dealerCard
}

print("YOUR CARDS ARE: \(playerCard)")

func game() {
    while isPlayerPlaying {
        guard let command = readLine() else {
            print("hit/standのいずれかのコマンドを入力してください。")
            continue
        }
        if command != "hit" && command != "stand" {
            print("hit/standのいずれかのコマンドを入力してください。")
            continue
        }
        
        playerCard = playerTurn(playerCard: playerCard, command: command)
        if sumCards(playerCard) > 21 { return }
    }
    
    while isDealerPlaying {
        dealerCard = dealerTurn(dealerCard: dealerCard)
        if sumCards(dealerCard) > 21 { return }
    }
}

game()

let playerSum = sumCards(playerCard)
let dealerSum = sumCards(dealerCard)

// 勝敗
if playerSum > 21 {
    print("Player Bust! Dealer wins!")
} else if dealerSum > 21 {
    print("Dealer Bust! Player wins!")
} else if playerSum > dealerSum {
    print("Player wins!")
} else if playerSum < dealerSum {
    print("Dealer wins!")
} else if playerSum == dealerSum {
    print("It's a tie!")
}
