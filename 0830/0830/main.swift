// PlayerTurnの入力：PlayerのHP、ポーションの数、選択、MonsterのHP
// PlayerTurnの返り値：playerHP, monsterHP, potion
// MonsterTurnの入力：PlayerのHP、MonsterのHP
// MonsterTurnの返り値: playerHP, monsterHP

var playerHP = 30
var monsterHP = 40
var potion = 2

func playerTurn(playerHP: Int, monsterHP: Int, potion: Int, command: String) -> (playerHP: Int, monsterHP: Int, potion: Int) {
    var playerHP = playerHP
    var monsterHP = monsterHP
    var potion = potion
    
    if command == "attack" {
        let action = Int.random(in: 5...10)
        monsterHP -= action
        print("モンスターに\(action)ダメージ与えた！ モンスターのHP：\(monsterHP)")
    } else if command == "heal" {
        let action = Int.random(in: 3...6)
        playerHP += action
        if playerHP > 30 {
            playerHP = 30
        }
        print("プレイヤーは\(action)HP回復！ プレイヤーのHP：\(playerHP)")
    } else if command == "potion" {
        potion -= 1
        playerHP += 10
        if playerHP > 30 {
            playerHP = 30
        }
        print("プレイヤーはポーションにより10HP回復！ プレイヤーのHP：\(playerHP)、残りポーション：\(potion)")
    }
    
    return (playerHP, monsterHP, potion)
}

func monsterTurn(playerHP: Int, monsterHP: Int) -> (playerHP: Int, monsterHP: Int) {
    let command = Int.random(in: 1...2)
    
    
    var playerHP = playerHP
    var monsterHP = monsterHP
    
    if command == 1 {
        let action = Int.random(in: 3...8)
        playerHP -= action
        print("プレイヤーは\(action)ダメージ受けた！ プレイヤーのHP：\(playerHP)")
    } else if command == 2 {
        let action = Int.random(in: 3...6)
        monsterHP += action
        if monsterHP > 40 {
            monsterHP = 40
        }
        print("モンスターは\(action)HP回復！ モンスターのHP：\(monsterHP)")
    }
    
    return (playerHP, monsterHP)
}

while playerHP > 0 && monsterHP > 0 {
    guard let command = readLine() else { continue }
    if command != "attack" && command != "heal" && command != "potion" {
        print("コマンドはattack/heal/potionのうちいずれかを入力してください")
        continue
    } else if command == "potion" && potion == 0 {
        print("potionがありません。他のコマンドを入力してください")
        continue
    }
    
    let playerTurnResults = playerTurn(playerHP: playerHP, monsterHP: monsterHP, potion: potion, command: command)
    
    playerHP = playerTurnResults.playerHP
    monsterHP = playerTurnResults.monsterHP
    potion = playerTurnResults.potion
    
    if monsterHP <= 0 {
        print("You Win")
        break
    }
    
    
    
    let monsterTurnResults = monsterTurn(playerHP: playerHP, monsterHP: monsterHP)
    
    playerHP = monsterTurnResults.playerHP
    monsterHP = monsterTurnResults.monsterHP
    
    if playerHP <= 0 {
        print("You Lose")
        break
    }
}
