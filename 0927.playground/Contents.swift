struct Question {
    let text: String
    let answer: Bool
}

enum QuizState {
    case idle
    case answering(questionNumber: Int)
    case finished(Int)
}

struct QuizSession {
    let questions: [Question]
    var state: QuizState
    var score: Int = 0
    
    mutating func start() {
        guard case .idle = state else { return }
        guard !questions.isEmpty else {
            state = .finished(0)
            return
        }
        state = .answering(questionNumber: 0)
    }
    
    mutating func answer(_ answer: Bool) {
        guard case .answering(var questionNumber) = state else { return }
        
        if answer == questions[questionNumber].answer {
            score += 1
        }
        
        guard questionNumber < questions.count else {
            state = .finished(score)
            return
        }

        state = .answering(questionNumber: questionNumber + 1) // ここで更新しないと、ローカル変数のquestionNumberが変わっただけで元のstateの保存されているansweringのassociated valueが変わらない。
    }
    
    var currentQuestion: Question? {
        guard case .answering(let questionNumber) = state else { return nil }
        return questions[questionNumber]
    }
}

var question1 = Question(text: "トマトは赤ですか？", answer: true)
var question2 = Question(text: "青信号の隣の色は赤ですか？", answer: false)
var question3 = Question(text: "あなたの血の色は赤ですか？", answer: true)

var Quiz1 = QuizSession(questions: [question1, question2, question3], state: .idle)
Quiz1.start()
Quiz1.answer(true)
print(Quiz1.currentQuestion)
Quiz1.answer(true)
print(Quiz1.currentQuestion)
Quiz1.answer(true)
print(Quiz1.score)
print(Quiz1.currentQuestion)
