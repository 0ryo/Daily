protocol ProgressTrackable: AnyObject {
    var title: String { get }
    var currentCount: Int { get }
    var targetCount: Int { get }
    func record(amount: Int) -> Bool
    func reset()
}

extension ProgressTrackable {
    var remainingCount: Int {
        return targetCount - currentCount
    }
    
    var isCompleted: Bool {
        return currentCount >= targetCount
    }
}

class BookProgress: ProgressTrackable {
    let title: String
    let targetCount: Int
    var currentCount: Int = 0
    var onChanged: (Int) -> Void
    func record(amount: Int) -> Bool {
        guard amount > 0 else { return false }
        guard amount <= remainingCount else { return false }
        currentCount += amount
        onChanged(currentCount)
        return true
    }
    
    func reset() {
        guard currentCount != 0 else { return }
        currentCount = 0
        onChanged(currentCount)
    }
    
    init(title: String, targetCount: Int, onChanged: @escaping (Int) -> Void) {
        self.title = title
        self.targetCount = targetCount
        self.onChanged = onChanged
    }
    
}

class ReadingShelf {
    var items: [any ProgressTrackable]
    var completedCount: Int {
        items.filter{ $0.isCompleted }.count
    }
    var totalRemainingCount: Int {
        var total: Int = 0
        for item in items {
            total += item.remainingCount
        }
        return total
    }
    func resetAll() {
        for item in items {
            item.reset()
        }
    }
    
    init(item: [any ProgressTrackable]) {
        self.items = item
    }
}

var A = BookProgress(title: "A", targetCount: 2, onChanged: { newValue in
    print("Aが\(newValue)に更新されました")
})

var B = BookProgress(title: "B", targetCount: 3, onChanged: {
    print("Bが\($0)に更新されました")
})

var shelf = ReadingShelf(item: [A, B])

A.record(amount: 1)
A.record(amount: 2)
A.record(amount: 1)
B.record(amount: 0)
B.record(amount: -1)
B.record(amount: 3)
shelf.resetAll()
shelf.resetAll()
