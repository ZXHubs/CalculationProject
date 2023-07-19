//
//  InputRecord.swift
//  CalculationProject
//
//  Created by ZhangX on 2023/7/18.
//

import Foundation

class InputRecord: ObservableObject {
    @Published private(set) var value: String = "?"
    var unchangedFromInit: Bool { value == "?" }
    var isZeroBegan: Bool { Int(value) == 0 }
    var isEmpty: Bool{ value.isEmpty }
    var isNegative: Bool { value.first == "-" }
    
    func append(inputBtn: String) {
        value.append(inputBtn)
    }
    func removeFirst() {
        value.removeFirst()
    }
    func removeLast() {
        value.removeLast()
    }
    func insertNegative() {
        value.insert("-", at: value.startIndex)
    }
    func reset() {
        value = "?"
    }
}
