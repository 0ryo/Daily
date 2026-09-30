enum DownloadStatus {
    case waiting
    case downloading
    case paused
    case completed
}

struct DownloadItem {
    let title: String
    var progress: Int
    var status: DownloadStatus
    
    mutating func start() -> Bool {
        switch status {
        case .waiting, .paused:
            status = .downloading
            return true
        case .completed, .downloading:
            return false
        }
    }
    
    mutating func pause() -> Bool {
        switch status {
        case .downloading:
            status = .paused
            return true
        case .waiting, .paused, .completed:
            return false
        }
    }
    
    mutating func updateProgress(by amount: Int) {
        guard amount > 0 else { return }
        guard status == .downloading else { return }
        
        progress += amount
        if progress >= 100 {
            progress = 100
            status = .completed
        }
    }
}
