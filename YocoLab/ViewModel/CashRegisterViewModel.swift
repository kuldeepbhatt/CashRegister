import Foundation

public let cashValueLimit: Float = 1000000.00
enum CashRegisterSections: Int {
    case entries = 0
    case total
}
class CashRegisterViewModel {
    private var charges:[Float]? = []
    static let shared = CashRegisterViewModel()

    var visibleKeys: Int {
        return keys.count
    }

    var keys: [String] {
        var counter = 1
        var keys:[String] = []
        while counter <= 9 {
            keys.append(String(counter))
            counter += 1
        }
        keys.append("DEL")
        keys.append(String(0))
        keys.append(String("ADD"))
        return keys
    }
}

extension CashRegisterViewModel {
    func appendCharges(charge: Float) {
        self.charges?.append(charge)
    }

    var visibleRows: [Float]? {
        return self.charges
    }

    var visibleSections: [CashRegisterSections] {
        var sections: [CashRegisterSections] = []
        sections.append(.entries)
        sections.append(.total)
        return sections
    }

    var totalOfEntries: Float? {
        return self.charges?.reduce(0, +)
    }
}
