enum TimerState {
    case idle
    case running(remaining: Int)
    case paused(remaining: Int)
    case finished
}

struct CountDownTimer {
    let title: String
    let totalSeconds: Int
    var state: TimerState
    
    mutating func start() {
        if case .idle = state {
            state = .running(remaining: totalSeconds)
        } else if case .paused(let remaining) = state {
            state = .running(remaining: remaining)
        }
    }
    
    mutating func pause() {
        if case .running(let remaining) = state {
            state = .paused(remaining: remaining)
        }
    }
    
    mutating func tick(seconds: Int) {
        guard seconds > 0 else { return }
        if case .running(let remaining) = state {
            let newRemaining = remaining - seconds
            if newRemaining <= 0 {
                state = .finished
                return
            }
            state = .running(remaining: newRemaining)
        }
    }
    
    mutating func reset() {
        state = .idle
    }
    
    var remainingSeconds: Int {
        switch state {
        case .idle: totalSeconds
        case .running(remaining: let remaining): remaining
        case .paused(remaining: let remaining): remaining
        case .finished: 0
        }
    }
}

var timer1 = CountDownTimer(title: "title1", totalSeconds: 60, state: .idle)
timer1.start()
timer1.tick(seconds: 20)
print(timer1.remainingSeconds)

timer1.pause()
print(timer1.remainingSeconds)

timer1.tick(seconds: 10)

timer1.start()

timer1.tick(seconds: 40)
print(timer1.state)

timer1.reset()
print(timer1.state, timer1.remainingSeconds)
