struct BankAccount {
    let owner: String
    var balance: Int
    
    mutating func deposit(amount: Int) {
        guard amount > 0 else { return }
        balance += amount
    }
    
    mutating func withdraw(amount: Int) -> Bool {
        guard amount <= 0 else { return false }
        guard amount > balance else { return false }
        
        balance -= amount
        return true
    }
    
    mutating func transfer(amount: Int, to: inout BankAccount) -> Bool {
        guard amount > 0 else { return false }
        guard amount <= balance else { return false }
        
        self.balance -= amount
        to.balance += amount
        return true
    }
}

var Alice = BankAccount(owner: "Alice", balance: 15000)
var Bob = BankAccount(owner: "Bob", balance: 5000)

Alice.deposit(amount: 4000)
print("Aliceの残高:\(Alice.balance)")
Alice.withdraw(amount: 8000)
print("Aliceの残高:\(Alice.balance)")
Alice.transfer(amount: 1000, to: &Bob)

print("Aliceの残高:\(Alice.balance)")
print("Bobの残高:\(Bob.balance)")
