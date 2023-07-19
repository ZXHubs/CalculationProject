//
//  ControlAndDisplayPadView.swift
//  CalculationProject
//
//  Created by ZhangX on 2023/7/19.
//

import SwiftUI

struct ControlAndDisplayPadView: View {
    @State private var showSettingPad = false
    @EnvironmentObject var questionLib: QuestionLib
    @EnvironmentObject var input: InputRecord
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                VStack(spacing: 0) {
                    ToolButtonView(btnName: "gear", actionBlock: {showSettingPad = true})
                    ToolButtonView(btnName: "plus.circle", actionBlock: {questionLib.addQuestion()})
                }
                .frame(maxWidth: geo.size.height)
                SignalDisplayPad(width: min(geo.size.width/3,geo.size.height*3/4*2))
                VStack(spacing: 0) {
                    ToolButtonView(btnName: "folder.circle", actionBlock: {questionLib.commitQuestion(input: input)})
                    ToolButtonView(btnName: "e.circle", actionBlock: {})
                }
                .frame(maxWidth: geo.size.height)
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
            .sheet(isPresented: $showSettingPad) {
                UserSettingPadView()
                    .environmentObject(questionLib)
            }
        }
    }
}

struct ControlAndDisplayPadView_Previews: PreviewProvider {
    static var previews: some View {
        ControlAndDisplayPadView()
            .environmentObject(QuestionLib())
    }
}
