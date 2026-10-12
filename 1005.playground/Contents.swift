protocol PowerControllable: AnyObject {
    var name: String { get }
    var isOn: Bool { get }
    
    func setPower(to: Bool) -> Bool
}

extension PowerControllable {
    var statusText: String {
        guard isOn else { return "OFF" }
        return "ON"
    }
}

class Lamp: PowerControllable {
    let name: String
    private(set) var isOn: Bool = false
    var onChanged: (Bool) -> Void
    
    func setPower(to: Bool) -> Bool {
        guard isOn != to else { return false }
        isOn = to
        onChanged(isOn)
        return true
    }
    
    init(name: String, onChanged: @escaping (Bool) -> Void) {
        self.name = name
        self.onChanged = onChanged
    }
}

class LightingPanel {
    var items: [any PowerControllable]
    var onCount: Int {
        return items.filter{ $0.isOn }.count
    }
    
    func setPower(at: String, to: Bool) -> Bool {
        guard let setItem = items.first(where: { item in  //itemsのitemとatが一致しているものを探して、
            item.name == at
        }) else { return false }
        
        return setItem.setPower(to: to) //setPower(to)をする。
    }
    
    func turnOffAll() -> Int {
        var count = 0
        for item in items {
            if item.setPower(to: false) {
                count += 1
            }
        }
        return count
    }
    
    init(items: [any PowerControllable]) {
        self.items = items
    }
}

var LightA = Lamp(name: "A", onChanged: { isOn in
    print("LightAが\(isOn)に変更されました！")
})
var LightB = Lamp(name: "B", onChanged: { isOn in
    print("LightBが\(isOn)に変更されました！")
})
var LightningPanel = LightingPanel(items: [LightA, LightB])

LightA.setPower(to: true)
LightA.setPower(to: true)
print("現在のON数: \(LightningPanel.onCount)")

LightningPanel.setPower(at: "A", to: false)
LightningPanel.setPower(at: "A", to: false)
LightningPanel.setPower(at: "B", to: false)
LightningPanel.setPower(at: "B", to: true)
LightningPanel.turnOffAll()
print("現在のON数: \(LightningPanel.onCount)")

