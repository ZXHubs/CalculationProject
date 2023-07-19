//
//  Question.swift
//  CalculationProject
//
//  Created by ZhangX on 2023/7/13.
//

import Foundation

class Question: Identifiable, Equatable {
    static func == (lhs: Question, rhs: Question) -> Bool {
        lhs.id == rhs.id && lhs.display == rhs.display
    }
    
    var id = UUID()
    
    let firstOperand: Int
    let operation: String
    let secondOperand: Int
    let operationLib: Dictionary<String, (Int, Int) -> Int> = ["+":{$0 + $1},"-":{$0 - $1},"*":{$0 * $1},"/":{$0 / $1}]
    var standrdAnswer: Int {
        operationLib[operation]!(firstOperand, secondOperand)
    }
    private var userAnswers: [(date: Date, answer: String)] = []
    func appendAnswer(latestAnswer: (date: Date, answer: String)) {
        userAnswers.append(latestAnswer)
    }
    func appendAnswer(latestAnswer: String) {
        userAnswers.append((date: Date(),answer: latestAnswer))
    }
    func judgement() -> Bool {
        if let userAnswer = userAnswers.last?.answer {
            return Int(userAnswer) == standrdAnswer
        }
        return false
    }
//    func display() -> String {
//        return String(firstOperand) + operation + String(secondOperand)
//    }
//    当返回值的参数为空可以选择计算属性
    var display: String {
        insertParenthesis(opd: firstOperand)+operation+insertParenthesis(opd: secondOperand)
    }
    
    func insertParenthesis(opd: Int) -> String {
        if opd<0 {
            return "\(opd)"
        } else {
            return String(opd)
        }
    }
    
    init(firstOperand: Int, operation: String, secondOperand: Int) {
        self.firstOperand = firstOperand
        self.operation = operation
        self.secondOperand = secondOperand
    }
}

class QuestionLib: ObservableObject {
    @Published private(set) var questions: [Question] = []
    @Published var setting = SettingPad()
    @Published private(set) var check: Bool?
    static var example: QuestionLib {
        let questionLib = QuestionLib()
        questionLib.addQuestion()
        return questionLib
    }
    lazy var operationLib: Dictionary<String,(first: ClosedRange<Int>,second: ClosedRange<Int>?)> = ["+":(setting.firstOpdMinPlus...setting.firstOpdMaxPlus,setting.secondOpdMinPlus...setting.secondOpdMaxPlus),"-":(setting.firstOpdMinMinus...setting.firstOpdMaxMinus,setting.secondOpdMinMinus...setting.secondOpdMaxMinus),"*":(setting.firstOpdMinMultiply...setting.firstOpdMaxMultiply,setting.secondOpdMinMultiply...setting.secondOpdMaxMultiply),"/":(setting.firstOpdMinDivide...setting.firstOpdMaxDivide,nil)]
    var currentOperations: [String] {
        var opts = [String]()
        if setting.optPlus {opts.append("+")}
        if setting.optMinus {opts.append("-")}
        if setting.optMultiply {opts.append("*")}
        if setting.optDivide {opts.append("/")}
        return opts
    }
    
    //    static var example: QuestionLib{
    //         let questionLib = QuestionLib()
    //         questionLib.addQuestion()
    //         return questionLib
    //    }
    
    func addQuestion() {
        for _ in 1...setting.numberOfQuestion {
            //        FIXME: - 等待补充currentOperations不为空验证过程 -
            let operation = currentOperations.randomElement()!
            let firstOpd = Int.random(in: operationLib[operation]!.first)
            var secondOpd :Int{
                if let secondScope = operationLib[operation]?.second {
                    return Int.random(in: secondScope)
                } else {
                    return factor(number: firstOpd).randomElement()!
                }
            }
            questions.append(Question(firstOperand: firstOpd, operation: operation, secondOperand: secondOpd))
        }
    }
    
    private func factor(number: Int) -> [Int] {
        var allFactors = [Int]()
        if number != 0 {
            for factor in 1...Int(sqrt(Double(abs(number)))) {
                if number%factor == 0 {
                    allFactors.append(factor)
                    let result = abs(number)/factor
                    if result != factor {
                        allFactors.append(result)
                    }
                }
            }
        } else {
            var randomNum: Int
            repeat {
                randomNum = Int.random(in: -10...10)
            } while(randomNum==0)
            allFactors.append(randomNum)
        }
        if allFactors.count > 2 {
            allFactors = allFactors.sorted()
            allFactors.removeFirst()
            allFactors.removeLast()
        }
        return allFactors
    }
    
    func commitQuestion(input: InputRecord) {
        if let question = questions.last {
            question.appendAnswer(latestAnswer: input.value)
            check = question.judgement()
            input.reset()
            questions.removeLast()
        }
    }
    
    func resetCheck() {
        check = nil
    }
    
//    存放与题库相关的自定义参数
    struct SettingPad {
        var numberOfQuestion = 5
        
        var firstOpdMinPlus = 0
        var firstOpdMaxPlus = 20
        var secondOpdMinPlus = 0
        var secondOpdMaxPlus = 20
        
        var firstOpdMinMinus = 0
        var firstOpdMaxMinus = 20
        var secondOpdMinMinus = 0
        var secondOpdMaxMinus = 20
        
        var firstOpdMinMultiply = 0
        var firstOpdMaxMultiply = 20
        var secondOpdMinMultiply = 0
        var secondOpdMaxMultiply = 20
        
        var firstOpdMinDivide = 0
        var firstOpdMaxDivide = 30
        
        var optPlus = true
        var optMinus = true
        var optMultiply = true
        var optDivide = true
        
//        用来统计已选中的运算符数量
        private var operationCounter: Int {
            var num = 0
            if optPlus{ num += 1}
            if optMinus{ num += 1}
            if optMultiply{ num += 1}
            if optDivide{ num += 1}
            return num
        }
        
//        用于确定是否允许用户对操作符的选中状态进行变更,ture不允许用户对操作符变更
        func operationSettingLocked(needToCheck uncheckOperation: Bool) -> Bool {
            if !uncheckOperation {
                return false
            } else {
                if operationCounter == 1 { return true } else { return false }
            }
        }
    }
}
