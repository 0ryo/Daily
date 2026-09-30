
struct Habit {
    let name: String
    let targetCount: Int
    var currentCount: Int
    
    mutating func record() -> Bool {
        guard currentCount < targetCount else { return false }
        currentCount += 1
        return true
    }
    
    var isCompleted: Bool {
        return currentCount >= targetCount
    }
}

struct HabitTracker {
    var habits: [Habit]
    
    mutating func record(name: String) -> Bool {
        guard let index = habits.firstIndex(where: {
            $0.name == name
        }) else {
            return false
        }
        
        return habits[index].record()
    }
    
    var completedCount: Int {
        return habits.filter{ $0.isCompleted }.count
    }
}

var habit1 = Habit(name: "habit1", targetCount: 20, currentCount: 1)
var habit2 = Habit(name: "habit2", targetCount: 40, currentCount: 2)
var habit3 = Habit(name: "habit3", targetCount: 10, currentCount: 3)

var habitTracker1 = HabitTracker(habits: [habit1, habit2, habit3])
habitTracker1.record(name: "habit1")
print(habitTracker1.habits)
print(habitTracker1.completedCount)
