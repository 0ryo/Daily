//
//  TellyCounter.swift
//  1119
//
//  Created by 伊藤瞭汰 on 2026/11/19.
//

final class TallyCounter {
    var count: Int = 0
    var onChange: ((Int) -> Void)?
    
    func increment() {
        count += 1
        onChange?(count)
    }
}
