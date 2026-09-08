let ratings = [
    5, 4, 5, 3, 2,
    5, 4, 1, 5, 3,
    4, 5, 2, 4, 5
]

func calcRatings(_ ratings: [Int]) -> (averageRatings: Double, countByRating: [Int: Int], mostCommonRating: Int?) {
    var sumRatings = 0
    var countByRating: [Int: Int] = [:]
    
    for rating in ratings {
        sumRatings += rating
        countByRating[rating, default: 0] += 1
    }
    
    let averageRatings = Double(sumRatings) / Double(ratings.count)
    let mostCommonRating = countByRating.max(by: { $0.value < $1.value })?.key
       
    return (averageRatings, countByRating, mostCommonRating)
}

let result = calcRatings(ratings)

print("平均値:\(result.averageRatings)")
print("評価ごとの件数:\(result.countByRating)")
print("最も多い評価:\(result.mostCommonRating)")
