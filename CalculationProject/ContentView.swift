//
//  ContentView.swift
//  CalculationProject
//
//  Created by ZhangX on 2023/7/13.
//

import SwiftUI

struct ContentView: View {
    @State private var clickCounter = 0
    @StateObject var questionLib = QuestionLib()
    
    @StateObject var input = InputRecord()
    
    var body: some View {
        GeometryReader {geo in
            ZStack {
                BackgroundView()
                VStack {
                    ControlAndDisplayPadView()
                        .frame(width: geo.size.width, height: geo.size.width > geo.size.height ? geo.size.height / 4 : geo.size.width / 5, alignment: .center)
                    AnswerAndDraftPadView(isPortrait: geo.size.width < geo.size.height)
//                    CardStackAndInputPadView()
                    //            Spacer()
                    //            SignalDisplayPad(width: 200)
                    //            Text("点击按钮\(clickCounter)次")
                    //            Button("添加一张卡牌", action:btnAction)
                    //            Button("提交") {
                    //                questionLib.commitQuestion(input: input)
                    //            }
                    //            Button("设置") {
                    //                showSettingPad = true
                    //            }
                }
            }
        }
        .environmentObject(questionLib)
        .environmentObject(input)
//        此处的.environmentObject(questionLib)不能放到sheet后面，因为UserSettingPadView是以模态展示的，会建立新的视图层级，已注入环境的questionLib对象会的新视图下发生丢失，无法再次获取questionLib的问题
        
    }
    func btnAction() {
        clickCounter += 1
        questionLib.addQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
