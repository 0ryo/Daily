enum DownloadStatus {
    case waiting
    case downloading
    case completed
    case failed
}

struct Download {
    let title: String
    var status: DownloadStatus
    
    mutating func start() -> Bool {
        guard status == .waiting else { return false }
        status = .downloading
        return true
    }
    
    mutating func finish(success: Bool) -> Bool {
        guard status == .downloading else { return false }
        if success {
            status = .completed
        } else {
            status = .failed
        }
        
        return true
    }
    
    mutating func retry() -> Bool {
        guard status == .failed else { return false }
        status = .waiting
        return true
    }
}
