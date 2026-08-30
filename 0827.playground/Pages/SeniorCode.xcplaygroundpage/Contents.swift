struct Fighter {
    let name: String
    var hp: Int
    let attackRange: ClosedRange<Int>
    
    var isAlive: Bool {
        hp > 0
    }
    
    func makeDamage() -> Int {
        Int.random(in: attackRange)
    }
    
    mutating func takeDamage(_ damage: Int) {
        hp = max(0, hp - damage)
    }
}

func attack(from attacker: Fighter, to defender: inout Fighter) {
    let damage = attacker.makeDamage()
    
    print("\(attacker.name) Attack! \(damage) damage!")
    
    defender.takeDamage(damage)
    
    print("\(defender.name) HP: \(defender.hp)")
    print("------------------")
}

func battle(player: inout Fighter, monster: inout Fighter) {
    print("=== Round2 Fight! ===")
    
    while player.isAlive && monster.isAlive {
        attack(from: player, to: &monster)
        
        guard monster.isAlive else {
            print("Player Win")
            return
        }
        
        attack(from: monster, to: &player)
        
        guard player.isAlive else {
            print("Monster Win")
            return
        }
    }
}

var player = Fighter(
    name: "Player",
    hp: 30,
    attackRange: 5...10
)
var monster = Fighter(
    name: "Monster",
    hp: 30,
    attackRange: 3...8
)

battle(player: &player, monster: &monster)
