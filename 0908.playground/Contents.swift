let statusCodes = [
    200, 404, 200, 500, 200,
    404, 403, 200, 500, 404,
    200, 201, 404, 500, 200
]

func analyzeStatusCodes(_ statusCodes: [Int]) -> (countByCode: [Int: Int], mostCommonCode: Int?, errorCount: Int) {
    var countByCode: [Int: Int] = [:] // 各ステータスコードが何回登場したか
    var errorCount: Int = 0 // 400以上のステータスコードが全部で何件あったか
    
    for code in statusCodes {
        countByCode[code, default: 0] += 1
        if code >= 400 {
            errorCount += 1
        }
    }
    
    let mostCommonCode = countByCode.max{ $0.value < $1.value }?.key // 一番多く登場したステータスコード
    
    return (countByCode, mostCommonCode, errorCount)
}

let results = analyzeStatusCodes(statusCodes)
print(results.countByCode)
print(results.mostCommonCode)
print(results.errorCount)
