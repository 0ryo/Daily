struct Log {
    let type: String
    let message: String
    let isResolved: Bool
}

let logs = [
    Log(type: "network", message: "通信に失敗しました", isResolved: false),
    Log(type: "database", message: "保存に失敗しました", isResolved: true),
    Log(type: "network", message: "タイムアウトしました", isResolved: false),
    Log(type: "auth", message: "認証に失敗しました", isResolved: false),
    Log(type: "database", message: "データが見つかりません", isResolved: false),
    Log(type: "network", message: "サーバーに接続できません", isResolved: true),
]

func analyzeLog(_ logs: [Log]) -> (unresolvedCount: Int, messageByType: [String: [String]]){
    var unresolvedCount: Int = 0
    var messageByType: [String: [String]] = [:]
    
    for log in logs {
        guard !log.isResolved else { continue }
        
        unresolvedCount += 1
        messageByType[log.type, default:[]].append(log.message)
    }
    
    return (unresolvedCount, messageByType)
}

let result = analyzeLog(logs)
print(result.unresolvedCount)
print(result.messageByType)
