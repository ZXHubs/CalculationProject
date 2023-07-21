//
//  AnswerAndDraftPadView.swift
//  CalculationProject
//
//  Created by ZhangX on 2023/7/21.
//

import SwiftUI

struct AnswerAndDraftPadView: View {
    let isPortrait: Bool
    var body: some View {
        GeometryReader { geo in
            if isPortrait {
                VStack(spacing: 0) {
                    CardStackAndInputPadView()
                    DraftPadView()
                        .padding(min(geo.size.width, geo.size.height)/40)
                        .frame(width: geo.size.width, height: geo.size.height/2, alignment: .center)
                }
                .frame(width: geo.size.width, height: geo.size.height, alignment: .bottom)
            } else {
                HStack(spacing: 0) {
                    CardStackAndInputPadView()
                    DraftPadView()
                        .padding(min(geo.size.width, geo.size.height)/40)
                        .frame(width: geo.size.width*0.4, height: geo.size.height, alignment: .center)
                }
                .frame(width: geo.size.width, height: geo.size.height, alignment: .trailing)
            }
        }
    }
}

struct AnswerAndDraftPadView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerAndDraftPadView(isPortrait: true)
            .environmentObject(QuestionLib.example)
            .environmentObject(InputRecord())
    }
}
