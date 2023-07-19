//
//  UnitOperandScopeView.swift
//  CalculationProject
//
//  Created by ZhangX on 2023/7/13.
//

import SwiftUI

struct UnitOperandScopeView: View {
    @State private var opdMin = ""
    @State private var opdMax = ""
    let opdName: LocalizedStringKey
    @Binding var opdMinOfQuestionLib: Int
    @Binding var opdMaxOfQuestionLib: Int
    @State private var showAlert = false
    @State private var alertMsg = ""
    
    var body: some View {
        HStack {
            Text(opdName)
                .layoutPriority(1)
//            设置View的优先级，默认是0
            Text("最小值")
            TextField(String(opdMinOfQuestionLib), text: $opdMin, onEditingChanged: opdMinSync)
            Text("最大值")
            TextField(String(opdMaxOfQuestionLib), text: $opdMax, onEditingChanged: opdMaxSync)
        }
        .textFieldStyle(.roundedBorder)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("无效"), message: Text(alertMsg), dismissButton: .default(Text("好的")))
        }
//        数字键盘
/* 如果是UIKit，键盘消失可以使用UITextfiled，input accessory view 添加自定义回车按钮
 在swiftUI中可以使用.numbersAndPunctuation，但是要是纯数字键盘，可以添加点击键盘以外的区域让键盘消失
*/
        .keyboardType(.numbersAndPunctuation)
    }
    
    func opdMinSync(editing: Bool) {
        opdValidation(editing: editing, inputStr: &opdMin, modelData: &opdMinOfQuestionLib)
    }
    
    func opdMaxSync(editing: Bool) {
        opdValidation(editing: editing, inputStr: &opdMax, modelData: &opdMaxOfQuestionLib, setMinLimit: false)
    }
    
    func opdValidation(editing: Bool, inputStr: inout String, modelData: inout Int, setMinLimit: Bool = true) {
        if !editing, inputStr != "" {
            if let input = Int(inputStr) {
                var validLimit: Bool {
                    if setMinLimit {
                        return input <= opdMaxOfQuestionLib
                    } else {
                        return input >= opdMinOfQuestionLib
                    }
                }
                if validLimit {
                    modelData = input
                } else {
                    showAlert = true
                    alertMsg = "最小值不能大于最大值"
                    inputStr = ""
                }
            } else {
                showAlert = true
                alertMsg = "只能输入整数！"
                inputStr = ""
            }
        }
    }
}

struct UnitOperandPlaceholderView: ViewModifier {
    let isHstack: Bool
    func body(content: Content) -> some View {
        if isHstack {
            return AnyView(
                HStack {
                    content
                    content.opacity(0)
                })
        } else {
            return AnyView(content)
        }
    }
}

extension View {
    func needPlaceholder(accordingTo isHstack: Bool) -> some View {
        modifier(UnitOperandPlaceholderView(isHstack: isHstack))
    }
}

struct UnitOperandScopeView_Previews: PreviewProvider {
    @StateObject static var questionLib = QuestionLib()
    static var previews: some View {
        UnitOperandScopeView(opdName: "加数1", opdMinOfQuestionLib: $questionLib.setting.firstOpdMinPlus, opdMaxOfQuestionLib: $questionLib.setting.firstOpdMaxPlus)
    }
}
