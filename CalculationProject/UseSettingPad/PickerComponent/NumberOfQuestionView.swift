//
//  numberOfQuestionView.swift
//  CalculationProject
//
//  Created by ZhangX on 2023/7/16.
//

import SwiftUI

struct NumberOfQuestionView: View {
    @EnvironmentObject var questionLib: QuestionLib
    @State private var userSelected = NumberOfQuestion.predefinedFive
    @State private var inputNumStr = ""
    @State private var showAlert = false
    @State private var alertMsg = ""
    
    var body: some View {
//        获取屏幕的宽度
        GeometryReader {geo in
            //        selection，绑定类型记录用户当前选择值。label，描述picker用途。content，构建数据选择器的选择列表。
//            VStack {
                HStack {
                    Picker("单次出题数量", selection: $userSelected, content: {
                        ForEach(NumberOfQuestion.allCases) {
                            Text($0.rawValue).tag($0)
                        }
                    })
                    .pickerStyle(.segmented)
                    if userSelected.needCustom {
//                        TextField("请输入...", text: $inputNumStr, onEditingChanged: customInputValidation)
//                            .textFieldStyle(.roundedBorder)
                        CustomTextFieldView(inputNumStr: $inputNumStr, inputValidation: customInputValidation, showingAlert: $showAlert)
                            .frame(maxWidth: geo.size.width/4)
                    }
                }
                .onAppear(perform: loadNumberOfQuestion)
//                Text(String(questionLib.setting.numberOfQuestion))
//            }
            .onChange(of: userSelected, perform: pickerSelectedHandler)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("无效"), message: Text(alertMsg),dismissButton: .default(Text("好的")))
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
        }
    }
    
    func pickerSelectedHandler(recentSelected: NumberOfQuestion) {
            if !recentSelected.needCustom {
                questionLib.setting.numberOfQuestion = Int(recentSelected.rawValue)!
                inputNumStr = ""
            }
    }
    
    func customInputValidation(isEditing: Bool) {
        if !isEditing {
            if let customNum = Int(inputNumStr), customNum >= 1, customNum <= 100 {
/* 此处可有if let语句灵活判断，而不写死，原有写法。
 if customNum == 5 || customNum == 10 || customNum == 15 {
 userSelected = NumberOfQuestion(rawValue: String(customNum))!
 }
 改善后代码：
*/
                if let autoSwitchNum = NumberOfQuestion(rawValue: String(customNum)) {
                    userSelected = autoSwitchNum
                    inputNumStr = ""
                } else {
                    questionLib.setting.numberOfQuestion = customNum
                }
            } else {
                showAlert = true
                alertMsg = "请输入大于0且不超过100的整数！"
                inputNumStr = ""
            }
        }
    }
    
    func loadNumberOfQuestion() {
        if let select = NumberOfQuestion(rawValue: String(questionLib.setting.numberOfQuestion)) {
            userSelected = select
        } else {
            userSelected = .custom
            inputNumStr = String(questionLib.setting.numberOfQuestion)
        }
    }
}

enum NumberOfQuestion: String, Identifiable, CaseIterable {
    case predefinedFive = "5"
    case predefinedTen = "10"
    case predefinedFifteen = "15"
    case custom = "自定义"
    
    var needCustom: Bool {
        self == .custom
    }
    var id: Self {
        self
    }
}

struct numberOfQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        NumberOfQuestionView().environmentObject(QuestionLib())
    }
}
