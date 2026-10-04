class TaskQueue {
    var titles: [String] = []
    var count: Int {
        return titles.count
    }
    let onChanged: ([String]) -> Void
    
    init(onChanged: @escaping ([String]) -> Void) {
        self.onChanged = onChanged
    }
    
    func add(title: String) -> Bool {
        guard title.count > 0 else { return false }
        guard !titles.contains(title) else { return false }
        titles.append(title)
        onChanged(titles)
        return true
    }
    
    func remove(title: String) -> Bool {
        guard title.count > 0 else { return false }
        guard titles.contains(title) else { return false }
        titles.removeAll { $0 == title }
        onChanged(titles)
        return true
    }
    
    func next() -> String? {
        guard !titles.isEmpty else { return nil }
        let nextTitle = titles[0]
        titles.removeFirst()
        onChanged(titles)
        return nextTitle
    }
    
    func reset() {
        guard !titles.isEmpty else { return }
        titles.removeAll()
        onChanged(titles)
    }
}
