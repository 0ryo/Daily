struct Character {
    let name: String
    var hp: Int
    let maxHP: Int
    var potionCount: Int
    
    mutating func takeDamage(amount: Int) {
        guard amount > 0 else { return }
        var newHP = hp - amount
        if newHP < 0 {
            newHP = 0
        }
        hp = newHP
    }
    
    mutating func usePotion() {
        guard potionCount > 0 else { return }
        guard hp < maxHP else { return }
        potionCount -= 1
        
        var newHP = hp + 10
        if newHP > maxHP {
            newHP = maxHP
        }
        hp = newHP
    }
    
    var isAlive: Bool {
        if hp <= 0 {
            return false
        }
        return true
    }
}

var character1 = Character(name: "Alex", hp: 100, maxHP: 100, potionCount: 2)
let action1 = character1.takeDamage(amount: 40)
print(character1.hp)
let action2 = character1.usePotion()
print(character1.hp, character1.potionCount)
print(character1.isAlive)
let action3 = character1.takeDamage(amount: 100)
print(character1.hp, character1.potionCount)
print(character1.isAlive)
