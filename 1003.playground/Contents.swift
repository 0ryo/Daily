protocol StampTrackable {
    var currentCount: Int { get }
    var targetCount: Int { get }
    func record() -> Bool
    func reset()
}

extension StampTrackable {
    var remainingCount: Int {
        return targetCount - currentCount
    }
    var isCompleted: Bool {
        return currentCount >= targetCount
    }
}

class StampCard: StampTrackable {
    var currentCount: Int = 0
    let targetCount: Int
    var onChanged: (Int) -> Void
    
    init(targetCount: Int, onChanged: @escaping (Int) -> Void) {
        self.targetCount = targetCount
        self.onChanged = onChanged
    }
    
    func record() -> Bool {
        guard !isCompleted else { return false }
        currentCount += 1
        onChanged(currentCount)
        return true
    }
    
    func reset() {
        guard currentCount != 0 else { return }
        currentCount = 0
        onChanged(currentCount)
    }
}

var cardA = StampCard(targetCount: 2, onChanged: { newCount in
    print("変更後の回数: \(newCount)")
})
var shared = cardA

cardA.record()
shared.record()
cardA.record()
shared.reset()
cardA.reset()

var cardB = StampCard(targetCount: 3, onChanged: { newCount in
    print("変更後の回数: \(newCount)")
})
cardB.record()
