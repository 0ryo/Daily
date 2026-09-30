struct Wallet {
    let owner: String
    var balance: Int
    
    mutating func pay(amount: Int) -> Bool {
        guard amount > 0 && amount <= balance else { return false }
        balance -= amount
        return true
    }
}

var myWallet = Wallet(owner: "Taro", balance: 1000)
let pay1 = myWallet.pay(amount: 300)
print(pay1, myWallet.balance)
let pay2 = myWallet.pay(amount: 0)
print(pay2, myWallet.balance)
let pay3 = myWallet.pay(amount: -100)
print(pay3, myWallet.balance)
let pay4 = myWallet.pay(amount: 701)
print(pay4, myWallet.balance)
let pay5 = myWallet.pay(amount: 700)
print(pay5, myWallet.balance)
let pay6 = myWallet.pay(amount: 1)
print(pay6, myWallet.balance)
