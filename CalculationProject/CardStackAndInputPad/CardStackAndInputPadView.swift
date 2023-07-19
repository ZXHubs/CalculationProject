//
//  CardStackAndInputPadView.swift
//  CalculationProject
//
//  Created by ZhangX on 2023/7/18.
//

import SwiftUI

struct CardStackAndInputPadView: View {
    @EnvironmentObject var questionLib: QuestionLib
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                StackOfCardsView()
                    .frame(maxWidth: geo.size.width / 2)
                if questionLib.questions.count != 0 {
                    InputPadView()
                        .frame(maxWidth: min(geo.size.width / 2, geo.size.height*3/4))
                        .onAppear {
                            questionLib.resetCheck()
                        }
                }
            }
            .padding()
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
        }
    }
}

struct CardStackAndInputPadView_Previews: PreviewProvider {
    static var previews: some View {
        CardStackAndInputPadView()
            .environmentObject(QuestionLib.example)
            .environmentObject(InputRecord())
    }
}
