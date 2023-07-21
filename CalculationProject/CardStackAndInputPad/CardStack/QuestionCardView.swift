//
//  QuestionCardView.swift
//  CalculationProject
//
//  Created by ZhangX on 2023/7/13.
//

import SwiftUI

struct QuestionCardView: View {
    @EnvironmentObject var input: InputRecord
    var question: Question
    var body: some View {
        GeometryReader { geo in    ZStack {
                RoundedRectangle(cornerRadius: getCardWidth(by: geo)/10)
                    .fill(.white)
                Text("\(question.display) = \(input.value)")
//                    .font(.largeTitle)
                .font(Font.system(size: min(50, getCardWidth(by: geo)/5)))
                    .padding()
                    .displayInSingleLine()
            }
        .frame(maxWidth: getCardWidth(by: geo), maxHeight: getCardWidth(by: geo) / 2, alignment: .center)
        .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
            .shadow(radius: 10)
        }
    }
    
    func getCardWidth(by geo: GeometryProxy) -> CGFloat {
        geo.size.width > geo.size.height ? geo.size.height : geo.size.width
    }
}

struct QuestionCardView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionCardView(question: Question(firstOperand: 1, operation: "+", secondOperand: 2))
            .environmentObject(InputRecord())
    }
}
