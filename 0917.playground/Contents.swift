struct Intake {
    var id: String
    var amountML: Int
}

struct WaterLog {
    var intakes: [Intake] = []
    var totalML: Int {
        intakes.map{ $0.amountML }.reduce(0, +)
    }
    
    mutating func record(_ intake: Intake) -> Bool {
        if intake.amountML > 0 {
            intakes.append(intake)
            return true
        }
        return false
    }
}


let intakes: [Intake] = [
    Intake(id: "test1", amountML: 400),
    Intake(id: "test2", amountML: 0),
    Intake(id: "test3", amountML: 230),
    Intake(id: "test4", amountML: 40),
    Intake(id: "test5", amountML: 4009),
]

let result = WaterLog(intakes: intakes)
print(result.intakes)
print(result.totalML)
