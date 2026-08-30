var playerHP = 30
var monsterHP = 30

func playerTurn(command: String, playerHP: Int, monsterHP: Int) -> (playerHP: Int, monsterHP: Int) {
    let command = command
    let action = Int.random(in: 5...10)
    
    var playerHP = playerHP
    var monsterHP = monsterHP
    
    if command == "attack" {
        monsterHP -= action
        print("Player Attacked  \(action)damage! MonsterHP: \(monsterHP)")
    } else if command == "heal" {
        playerHP += action
        if playerHP > 30 {
            playerHP = 30
        }
        print("Player Healed \(action)HP! PlayerHP: \(playerHP)")
    }
    
    return (playerHP, monsterHP)
}

func monsterTurn(playerHP: Int, monsterHP: Int) -> (playerHP: Int, monsterHP: Int) {
    let command = Int.random(in: 1...2)
    let action = Int.random(in: 3...8)
    
    var playerHP = playerHP
    var monsterHP = monsterHP
    
    if command == 1 {
        playerHP -= action
        print("Monster Attacked \(action)damage! PlayerHP: \(playerHP)")
    } else if command == 2 {
        monsterHP += action
        if monsterHP > 30 {
            monsterHP = 30
        }
        print("Monster Healed \(action)HP! MonsterHP: \(monsterHP)")
    }
    
    return (playerHP, monsterHP)
}

while playerHP >= 0 && monsterHP >= 0 {
    guard let playerAction = readLine() else { continue }
    if playerAction != "attack" && playerAction != "heal" {
        print("attack/healを入力してください。")
        continue
    }
    
    let playerTurnResult = playerTurn(command: playerAction, playerHP: playerHP, monsterHP: monsterHP)
    if playerTurnResult.monsterHP <= 0 {
        print("Player Win")
        break
    }
    
    playerHP = playerTurnResult.playerHP
    monsterHP = playerTurnResult.monsterHP
    
    let monsterTurnResult = monsterTurn(playerHP: playerHP, monsterHP: monsterHP)
    if monsterTurnResult.playerHP <= 0 {
        print("Monster Win")
        break
    }
    
    playerHP = monsterTurnResult.playerHP
    monsterHP = monsterTurnResult.monsterHP
}
