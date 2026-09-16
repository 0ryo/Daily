struct Task {
    let title: String
    let priority: Int
    let isCompleted: Bool
}

var tasks: [Task] = [
    Task(title: "Swift勉強", priority: 2, isCompleted: true),
    Task(title: "卒研資料を作る", priority: 3, isCompleted: false),
    Task(title: "メールを返信する", priority: 1, isCompleted: true),
    Task(title: "課題を提出する", priority: 3, isCompleted: false),
    Task(title: "部屋を掃除する", priority: 1, isCompleted: false),
]

func analyzeTasks(_ tasks: [Task]) -> (numberOfCompletedTask: Int, numberOfNotCompletedTask: Int, sortedUncompletedTasks: String?) {
    let tasks = tasks
    var uncompletedTasks: [String: Int] = [:]
    var numberOfCompletedTask: Int = 0
    var numberOfNotCompletedTask: Int = 0
    
    for task in tasks {
        if task.isCompleted {
            numberOfCompletedTask += 1
            continue
        } else {
            numberOfNotCompletedTask += 1
            uncompletedTasks[task.title, default: 0] += task.priority
            continue
        }
    }
    
    let sortedUncompletedTasks = uncompletedTasks.max{ $0.value < $1.value }?.key
    
    return (numberOfCompletedTask, numberOfNotCompletedTask, sortedUncompletedTasks)
}

let result = analyzeTasks(tasks)
print(result)
