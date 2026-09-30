class StudySession {
    let title: String
    let targetMinutes: Int
    var studiedMinutes: Int = 0
    var remainingMinutes: Int {
        return targetMinutes - studiedMinutes
    }
    var isCompleted: Bool {
        return remainingMinutes <= 0
    }
    
    init(title: String, targetMinutes: Int) {
        self.title = title
        self.targetMinutes = targetMinutes
    }
    
    func record(minutes: Int) -> Bool {
        guard minutes > 0 else { return false }
        let newStudiedMinutes = studiedMinutes + minutes
        guard newStudiedMinutes <= targetMinutes else { return false }
        studiedMinutes = newStudiedMinutes
        return true
    }
    
    func undo(minutes: Int) -> Bool {
        guard minutes > 0 else { return false }
        let newStudiedMinutes = studiedMinutes - minutes
        guard newStudiedMinutes >= 0 else { return false }
        studiedMinutes = newStudiedMinutes
        return true
    }
    
    func reset() {
        studiedMinutes = 0
    }
}

var sessionA = StudySession(title: "Swift", targetMinutes: 60)
var sessionB = sessionA
var sessionC = StudySession(title: "Swift", targetMinutes: 60)

print("セッションAの合計勉強時間:\(sessionA.studiedMinutes)", "セッションBの合計勉強時間:\(sessionB.studiedMinutes)", "セッションCの合計勉強時間:\(sessionC.studiedMinutes)")

let sessionA_result1 = sessionA.record(minutes: 20)
print("セッションAの戻り値:\(sessionA_result1)", "セッションAの合計勉強時間:\(sessionA.studiedMinutes)", "セッションBの合計勉強時間:\(sessionB.studiedMinutes)", "セッションCの合計勉強時間:\(sessionC.studiedMinutes)")
let sessionB_result1 = sessionB.record(minutes: 15)
print("セッションBの戻り値:\(sessionB_result1)", "セッションAの合計勉強時間:\(sessionA.studiedMinutes)", "セッションBの合計勉強時間:\(sessionB.studiedMinutes)", "セッションCの合計勉強時間:\(sessionC.studiedMinutes)")
let sessionC_result1 = sessionC.record(minutes: 10)
print("セッションCの戻り値:\(sessionC_result1)", "セッションAの合計勉強時間:\(sessionA.studiedMinutes)", "セッションBの合計勉強時間:\(sessionB.studiedMinutes)", "セッションCの合計勉強時間:\(sessionC.studiedMinutes)")

let sessionA_result2 = sessionA.record(minutes: 0)
print("セッションAの戻り値:\(sessionA_result2)", "セッションAの合計勉強時間:\(sessionA.studiedMinutes)", "セッションBの合計勉強時間:\(sessionB.studiedMinutes)", "セッションCの合計勉強時間:\(sessionC.studiedMinutes)")
let sessionA_result3 = sessionA.record(minutes: -5)
print("セッションAの戻り値:\(sessionA_result3)", "セッションAの合計勉強時間:\(sessionA.studiedMinutes)", "セッションBの合計勉強時間:\(sessionB.studiedMinutes)", "セッションCの合計勉強時間:\(sessionC.studiedMinutes)")
let sessionA_result4 = sessionA.record(minutes: 26)
print("セッションAの戻り値:\(sessionA_result4)", "セッションAの合計勉強時間:\(sessionA.studiedMinutes)", "セッションBの合計勉強時間:\(sessionB.studiedMinutes)", "セッションCの合計勉強時間:\(sessionC.studiedMinutes)")

let sessionB_result2 = sessionB.undo(minutes: 10)
print("セッションBの戻り値:\(sessionB_result2)", "セッションAの合計勉強時間:\(sessionA.studiedMinutes)", "セッションBの合計勉強時間:\(sessionB.studiedMinutes)", "セッションCの合計勉強時間:\(sessionC.studiedMinutes)")
let sessionA_result5 = sessionA.undo(minutes: 0)
print("セッションAの戻り値:\(sessionA_result5)", "セッションAの合計勉強時間:\(sessionA.studiedMinutes)", "セッションBの合計勉強時間:\(sessionB.studiedMinutes)", "セッションCの合計勉強時間:\(sessionC.studiedMinutes)")

let sessionA_result6 = sessionA.undo(minutes: -5)
print("セッションAの戻り値:\(sessionA_result6)", "セッションAの合計勉強時間:\(sessionA.studiedMinutes)", "セッションBの合計勉強時間:\(sessionB.studiedMinutes)", "セッションCの合計勉強時間:\(sessionC.studiedMinutes)")
let sessionA_result7 = sessionA.undo(minutes: 26)
print("セッションAの戻り値:\(sessionA_result7)", "セッションAの合計勉強時間:\(sessionA.studiedMinutes)", "セッションBの合計勉強時間:\(sessionB.studiedMinutes)", "セッションCの合計勉強時間:\(sessionC.studiedMinutes)")
let sessionA_result8 = sessionA.record(minutes: 35)
print("セッションAの戻り値:\(sessionA_result8)", "セッションAの合計勉強時間:\(sessionA.studiedMinutes)", "セッションBの合計勉強時間:\(sessionB.studiedMinutes)", "セッションCの合計勉強時間:\(sessionC.studiedMinutes)")
let sessionB_result3 = sessionA.record(minutes: 1)
print("セッションBの戻り値:\(sessionB_result3)", "セッションAの合計勉強時間:\(sessionA.studiedMinutes)", "セッションBの合計勉強時間:\(sessionB.studiedMinutes)", "セッションCの合計勉強時間:\(sessionC.studiedMinutes)")
sessionB.reset()
print("セッションAの合計勉強時間:\(sessionA.studiedMinutes)", "セッションBの合計勉強時間:\(sessionB.studiedMinutes)", "セッションCの合計勉強時間:\(sessionC.studiedMinutes)")
