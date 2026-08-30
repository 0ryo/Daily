func sample<T: Numeric>(num1: T, num2: T) -> T {
    return num1 + num2
}

var answer = sample(num1: 4.3, num2: 4)
print(answer)

class sampleClass<T> {
    var item: T
    
    init(item: T){
        self.item = item
    }
}

let cl1 = sampleClass(item: 10)
print(cl1.item)

let cl2 = sampleClass(item: "Text")
print(cl2.item)
