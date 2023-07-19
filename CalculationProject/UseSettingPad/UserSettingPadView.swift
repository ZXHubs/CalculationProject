//
//  UserSettingPadView.swift
//  CalculationProject
//
//  Created by ZhangX on 2023/7/13.
//

import SwiftUI

struct UserSettingPadView: View {
    @Environment(\EnvironmentValues.presentationMode) var present
    
    var body: some View {
        Form {
            Section(header: Text("请选择机选题库运算符")
            ) {
                ToggleStackSettingView()
            }
            .font(.title)
            Section(header: Text("请设置运算数取值范围")
                    .font(.title)
            ) {
                AllOpdScopeView()
            }
            Section(header: Text("请设置题库其他参数")
                .font(.title)) {
                Text("单次出题数量")
                    NumberOfQuestionView()
            }
            HStack {
                Spacer()
                Button("关闭") {
                    present.wrappedValue.dismiss()
                }
                .buttonStyle(BorderlessButtonStyle())
                Spacer()
            }
        }
/*        在iOS 15的设备上可以使用focus，控制视图焦点     在之前的设备可以使用过UIKit的方法addEditing方法，用来移除焦点
*/
//        .onTapGesture {
//            UIApplication.shared.windows.first?.endEditing(true)
//        }
        .onAppear {
            UIApplication.shared.addTouchDownRecognizer()
        }
        .onDisappear {
            UIApplication.shared.removeTouchDownRecognizer()
        }
    }
}

struct UserSettingPadView_Previews: PreviewProvider {
    static var previews: some View {
        UserSettingPadView()
            .environmentObject(QuestionLib())
    }
}
