print("=== Battle Start ===")

var playersHP: Int = 30
var monstersHP: Int = 30

var playersAttack: Int
var monstersAttack: Int

// Playerが生きている かつ Monsterが生きている
while playersHP > 0 && monstersHP > 0 {
    playersAttack = Int.random(in: 5...10)
    print("Player Attack! \(playersAttack) damage!")
    monstersHP -= playersAttack
    print("Monster HP: \(monstersHP)")
    if monstersHP <= 0 {
        print("Player Win")
        break
    }
    print("--------------------")
    
    monstersAttack = Int.random(in: 3...8)
    print("Monster Attack! \(monstersAttack) damage!")
    playersHP -= monstersAttack
    print("Player HP: \(playersHP)")
    print("--------------------")
    if playersHP <= 0 {
        print("Monster Win")
        break
    }
}

