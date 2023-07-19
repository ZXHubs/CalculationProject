//
//  ToggleStackSettingView.swift
//  CalculationProject
//
//  Created by ZhangX on 2023/7/13.
//

import SwiftUI

struct ToggleStackSettingView: View {
    @EnvironmentObject var questionLib: QuestionLib
    
    var body: some View {
        HStack {
            Toggle("+", isOn: $questionLib.setting.optPlus)
            Spacer()
            Toggle("-", isOn: $questionLib.setting.optMinus)
            Spacer()
            Toggle("*", isOn: $questionLib.setting.optMultiply)
            Spacer()
            Toggle("/", isOn: $questionLib.setting.optDivide)
        }
        .toggleStyle(CheckBoxStyle())
    }
}

struct CheckBoxStyle:ToggleStyle {
    @EnvironmentObject var questionLib: QuestionLib
    @State private var showAlert = false
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn ? "checkmark.shield" : "shield")
                .foregroundColor(configuration.isOn ? .green : .gray)
                .onTapGesture {
//                    如果questionLib的setting返回false，取反后条件为真
                    if !questionLib.setting.operationSettingLocked(needToCheck: configuration.isOn) {
                        configuration.isOn.toggle()
                    } else {
                        showAlert = true
                    }
                }
            configuration.label
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("警告⚠️"), message: Text("取消勾选该运算符后，将导致题库运算符为空，请确保题库具有至少一种运算符类型！"), dismissButton: .default(Text("确定")))
        }
    }
}

struct ToggleStackSettingView_Previews: PreviewProvider {
    static var previews: some View {
        ToggleStackSettingView().environmentObject(QuestionLib())
    }
}
