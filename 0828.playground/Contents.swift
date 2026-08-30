var playerHP = 30
var monsterHP = 30

func playerTurn(input inputCommand : String, playerHP pHP: Int, monsterHP mHP: Int) -> (pHP: Int, mHP: Int) {
    var playerAction: Int
    var pHP = pHP
    var mHP = mHP
    
    if inputCommand == "attack" {
        // 1. 行動が攻撃の場合、攻撃力をInt.random(5...10)で出す → MonsterのHPからその数値を引く。
        playerAction = Int.random(in: 5...10)
        mHP -= playerAction
    } else if inputCommand == "heal" {
        // 2. 行動が回復の場合、回復力をInt.random(5...10)で出す → PlayerのHPにその数値を足す。もしプレイヤーのHP > 30なら、プレイヤーのHP = 30にする。
        playerAction = Int.random(in: 5...10)
        pHP += playerAction
        if pHP > 30 {
            pHP = 30
        }
    }
    
    return(pHP, mHP)
}

func monsterTurn(playerHP pHP: Int) -> Int{
    let monsterAttack = Int.random(in: 3...8)
    var pHP = pHP
    
    pHP -= monsterAttack
    return pHP
}

while playerHP > 0 && monsterHP > 0 {
    // 0. 入力を受けとる。入力がattackなら、攻撃用処理、入力がhealなら回復用処理に進む。それ以外なら"attackまたはhealを入力してください"と出力。
    guard let input = readLine() else { continue }
    if input != "attack" || input != "heal" {
        print("attackまたはhealを入力してください。" )
        continue
    }
    
    let playerTurnResult = playerTurn(input: input, playerHP: playerHP, monsterHP: monsterHP)
    if playerTurnResult.mHP <= 0 {
        print ("Player Win")
        break
    }
    
    let monsterTurnResult = monsterTurn(playerHP: playerTurnResult.pHP)
    if playerHP <= 0 {
        print ("Monster Win")
        break
    }
    
    playerHP = monsterTurnResult
    monsterHP = playerTurnResult.mHP
}
