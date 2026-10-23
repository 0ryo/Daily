import Foundation

enum OrderState {
    case ordered
    case preparing
    case waiting(Int)
    case delivered
    case cancelled(String)
}

struct Order {
    let menuName: String
    private(set) var state: OrderState
    
    var currentStateString: String {
        switch state {
        case .ordered:
            return "受付済み"
        case .preparing:
            return "準備中"
        case .waiting(let orderNumber):
            return "受け取り待ち(\(orderNumber))"
        case .delivered:
            return "受け渡し済み"
        case .cancelled(let reason):
            return "キャンセル(\(reason))"
        }
    }
    
    mutating func startPrepare() -> Bool {
        if case .ordered = state {
            state = .preparing
            return true
        }
        return false
    }
    
    mutating func endPrepare(_ orderNumber: Int) -> Bool {
        guard orderNumber > 0 && orderNumber < 1000 else { return false }
        if case .preparing = state {
            state = .waiting(orderNumber)
            return true
        }
        return false
    }
    
    mutating func deliver(_ receivedNumber: Int) -> Bool {
        if case .waiting(let stateNumber) = state {
            guard receivedNumber == stateNumber else { return false }
            state = .delivered
            return true
        }
        return false
    }
    
    mutating func cancel(_ reason: String) -> Bool {
        let formattedReason = (reason as NSString).trimmingCharacters(in: .whitespacesAndNewlines)
        guard formattedReason.count > 0 else { return false }
        switch state {
        case .ordered, .preparing:
            state = .cancelled(formattedReason)
            return true
        case .waiting, .delivered, .cancelled:
            return false
        }
    }
    
}

var orderA = Order(menuName: "カフェラテ", state: .ordered)
print(orderA.currentStateString)
orderA.endPrepare(5)
print(orderA.currentStateString)
orderA.startPrepare()
print(orderA.currentStateString)
orderA.startPrepare()
print(orderA.currentStateString)
orderA.endPrepare(0)
print(orderA.currentStateString)
orderA.endPrepare(1000)
print(orderA.currentStateString)
orderA.endPrepare(12)
print(orderA.currentStateString)
orderA.cancel("気が変わった")
print(orderA.currentStateString)
orderA.deliver(7)
print(orderA.currentStateString)
orderA.deliver(12)
print(orderA.currentStateString)
orderA.startPrepare()
print(orderA.currentStateString)
print("-------------------------")
var orderB = Order(menuName: "抹茶ラテ", state: .ordered)
print(orderB.currentStateString)
orderB.cancel("  ")
print(orderB.currentStateString)
orderB.cancel("  在庫切れ\n")
print(orderB.currentStateString)
orderB.startPrepare()
print(orderB.currentStateString)
print("-------------------------")
var orderC = Order(menuName: "ほうじ茶", state: .ordered)
print(orderC.currentStateString)
orderC.startPrepare()
print(orderC.currentStateString)
orderC.cancel("お客様の都合")
print(orderC.currentStateString)
orderC.deliver(1)
print(orderC.currentStateString)
