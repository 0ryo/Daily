let studyMinutes = [
    35, 42, 10, 0, 25, 31, 45,
    50, 12, 30, 40, 38, 0, 55
]

func countStreak(studyMinutes: [Int]) -> (successCount: Int, maxStreakCount: Int, studyTimeSum: Int, studyTimeAvgerage: Double) {
    var successCount = 0 // 達成日数
    var streakCount = 0 // 連続達成日数
    var maxStreakCount = 0 // 最長連続達成日数
    var studyTimeSum = 0 // 合計勉強時間
    
    for dailyMinutes in studyMinutes {
        studyTimeSum += dailyMinutes
        // 成功判定
        if dailyMinutes >= 30 {
            successCount += 1
            streakCount += 1
            if streakCount > maxStreakCount {
                maxStreakCount = streakCount
            }
        } else {
            streakCount = 0
        }
    }
    
    let studyTimeAvgerage = Double(studyTimeSum) / Double(studyMinutes.count) // 平均勉強時間
    
    return (successCount, maxStreakCount, studyTimeSum, studyTimeAvgerage)
}

let result = countStreak(studyMinutes: studyMinutes)
print("合計時間：\(result.studyTimeSum)")
print("達成日数：\(result.successCount)")
print("最長連続達成日数：\(result.maxStreakCount)")
print("平均時間：\(result.studyTimeAvgerage)")
