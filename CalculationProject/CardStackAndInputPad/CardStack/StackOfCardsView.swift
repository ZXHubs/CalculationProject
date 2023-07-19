//
//  StackOfCardsView.swift
//  CalculationProject
//
//  Created by ZhangX on 2023/7/13.
//

import SwiftUI

struct StackOfCardsView: View {
//    第一种： @ObservedObject var questionLib = QuestionLib()
//    第二种：
    @EnvironmentObject var questionLib: QuestionLib
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(questionLib.questions) { question in
                    let index = questionLib.questions.firstIndex(of: question)!
                    if index >= (questionLib.questions.count - numOfCardOnScreen(by: geo)){
                        QuestionCardView(question: question)
                            .offset(x: 0, y: getCardHeight(by: geo) / 6 * CGFloat((questionLib.questions.count-(index+1))))
                    }
                }
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
        }
    }
    
    func getCardHeight(by geo: GeometryProxy) -> CGFloat {
        (geo.size.width > geo.size.height ? geo.size.height : geo.size.width) / 2
    }
    func numOfCardOnScreen(by geo: GeometryProxy) -> Int {
        return Int(geo.size.height / 2 - getCardHeight(by: geo) / 2 / (getCardHeight(by: geo) / 6)) + 1
    }
}

struct StackOfCardView_Previews: PreviewProvider {
//    static var exampleQuestionLib = QuestionLib()
    static var previews: some View {
//        StackOfCardsView(questionLib: exampleQuestionLib).onAppear(perform: {
//            exampleQuestionLib.questions.append(Question(firstOperand: 1, operation: "+", secondOperand: 2))
//            exampleQuestionLib.questions.append(Question(firstOperand: 1, operation: "+", secondOperand: 2))
//        })
//        StackOfCardsView(questionLib: QuestionLib.example)
        StackOfCardsView().environmentObject(QuestionLib.example)
            .environmentObject(InputRecord())
    }
}

