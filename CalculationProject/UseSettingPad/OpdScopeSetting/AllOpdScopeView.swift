//
//  AllOpdScopeView.swift
//  CalculationProject
//
//  Created by ZhangX on 2023/7/15.
//

import SwiftUI

struct AllOpdScopeView: View {
    @EnvironmentObject var questionLib: QuestionLib
//    横向还是纵向布局
    var isHstack: Bool {
        sizeClass == .regular
    }
//    属性包装器，将读取的属性值keypath
//    可以option查看sizeClass是UserInterfaceSizeClass类型，枚举，get类型，有compact和regular，紧凑和充足的空间
    @Environment(\EnvironmentValues.horizontalSizeClass) var sizeClass
    
    var body: some View {
        VStack {
            if questionLib.setting.optPlus {
                    TwoOpdScopeView(firstOpdName: "加数1：", secondOpdName: "加数2：", firstOpdMinOfQuestionLib: $questionLib.setting.firstOpdMinPlus, firstOpdMaxOfQuestionLib: $questionLib.setting.firstOpdMaxPlus, secondOpdMinOfQuestionLib: $questionLib.setting.secondOpdMinPlus, secondOpdMaxOfQuestionLib: $questionLib.setting.secondOpdMaxPlus)
                    .showTheGroupInHstack(isHstack)
            }
            if questionLib.setting.optMinus {
                TwoOpdScopeView(firstOpdName: "被减数：", secondOpdName: "减数：", firstOpdMinOfQuestionLib: $questionLib.setting.firstOpdMinMinus, firstOpdMaxOfQuestionLib: $questionLib.setting.firstOpdMaxMinus, secondOpdMinOfQuestionLib: $questionLib.setting.secondOpdMinMinus, secondOpdMaxOfQuestionLib: $questionLib.setting.secondOpdMaxMinus)
                    .showTheGroupInHstack(isHstack)
            }
            if questionLib.setting.optMultiply {
                TwoOpdScopeView(firstOpdName: "乘数1：", secondOpdName: "乘数2：", firstOpdMinOfQuestionLib: $questionLib.setting.firstOpdMinMultiply, firstOpdMaxOfQuestionLib: $questionLib.setting.firstOpdMaxMultiply, secondOpdMinOfQuestionLib: $questionLib.setting.secondOpdMinMultiply, secondOpdMaxOfQuestionLib: $questionLib.setting.secondOpdMaxMultiply)
                    .showTheGroupInHstack(isHstack)
            }
            if questionLib.setting.optDivide {
                UnitOperandScopeView(opdName: "被除数：", opdMinOfQuestionLib: $questionLib.setting.firstOpdMinDivide, opdMaxOfQuestionLib: $questionLib.setting.firstOpdMaxDivide)
                    .needPlaceholder(accordingTo: isHstack)
            }
        }
        .displayInSingleLine()
//        .lineLimit(1)
//        .minimumScaleFactor(0.1)
//        文本缩小但是适用给定空间，范围 0-1
    }
}

struct TextLimitToSingleLine: ViewModifier {
    func body(content: Content) -> some View {
        content
            .lineLimit(1)
            .minimumScaleFactor(0.1)
    }
}

extension View {
    func displayInSingleLine() -> some View {
        modifier(TextLimitToSingleLine())
    }
}

struct AllOpdScopeView_Previews: PreviewProvider {
    static var previews: some View {
        AllOpdScopeView().environmentObject(QuestionLib())
    }
}
