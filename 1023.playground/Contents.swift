import Foundation

enum OrderState {
    case ordered
    case prepareing
    case waiting(Int)
    case delivered
    case cancelled(String)
}

struct Order {
    let menuName: String
    private(set) var state: OrderState
    
    var currentState: String {
        switch state {
        case .ordered:
            return "受付済み"
        case .prepareing:
            return "準備中"
        case .waiting(let int):
            return "受け取り待ち(\(int))"
        case .delivered:
            return "受け渡し済み"
        case .cancelled(let string):
            return "キャンセル(\(string))"
        }
    }
    
    mutating func startPrepare() -> Bool {
        if case .ordered = state {
            state = .prepareing
            return true
        }
        return false
    }
    
    mutating func endPrepare(_ num: Int) -> Bool {
        guard num > 0 && num < 1000 else { return false }
        if case .prepareing = state {
            state = .waiting(num)
            return true
        }
        return false
    }
    
    mutating func deliver(_ receivedNum: Int) -> Bool {
        if case .waiting(let stateNum) = state {
            guard receivedNum == stateNum else { return false }
            state = .delivered
            return true
        }
        return false
    }
    
    mutating func cancel(_ reason: String) -> Bool {
        let styledReason = (reason as NSString).trimmingCharacters(in: .whitespacesAndNewlines)
        guard styledReason.count > 0 else { return false }
        
        if case .ordered = state {
            state = .cancelled(styledReason)
            return true
        } else if case .prepareing = state {
            state = .cancelled(styledReason)
            return true
        }
        return false
    }
    
}

var orderA = Order(menuName: "カフェラテ", state: .ordered)
print(orderA.currentState)
orderA.endPrepare(5)
print(orderA.currentState)
orderA.startPrepare()
print(orderA.currentState)
orderA.startPrepare()
print(orderA.currentState)
orderA.endPrepare(0)
print(orderA.currentState)
orderA.endPrepare(1000)
print(orderA.currentState)
orderA.endPrepare(12)
print(orderA.currentState)
orderA.cancel("気が変わった")
print(orderA.currentState)
orderA.deliver(7)
print(orderA.currentState)
orderA.deliver(12)
print(orderA.currentState)
orderA.startPrepare()
print(orderA.currentState)
print("-------------------------")
var orderB = Order(menuName: "抹茶ラテ", state: .ordered)
print(orderB.currentState)
orderB.cancel("  ")
print(orderB.currentState)
orderB.cancel("  在庫切れ\n")
print(orderB.currentState)
orderB.startPrepare()
print(orderB.currentState)
print("-------------------------")
var orderC = Order(menuName: "ほうじ茶", state: .ordered)
print(orderC.currentState)
orderC.startPrepare()
print(orderC.currentState)
orderC.cancel("お客様の都合")
print(orderC.currentState)
orderC.deliver(1)
print(orderC.currentState)
