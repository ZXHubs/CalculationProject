//
//  TwoOpdScopeView.swift
//  CalculationProject
//
//  Created by ZhangX on 2023/7/15.
//

import SwiftUI

struct TwoOpdScopeView: View {
    let firstOpdName: LocalizedStringKey
    let secondOpdName: LocalizedStringKey
    @Binding var firstOpdMinOfQuestionLib: Int
    @Binding var firstOpdMaxOfQuestionLib: Int
    @Binding var secondOpdMinOfQuestionLib: Int
    @Binding var secondOpdMaxOfQuestionLib: Int
    
    var body: some View {
        Group {
            UnitOperandScopeView(opdName: firstOpdName, opdMinOfQuestionLib: $firstOpdMinOfQuestionLib, opdMaxOfQuestionLib: $firstOpdMaxOfQuestionLib)
            UnitOperandScopeView(opdName: secondOpdName, opdMinOfQuestionLib: $secondOpdMinOfQuestionLib, opdMaxOfQuestionLib: $secondOpdMaxOfQuestionLib)
        }
    }
}

struct DirectionOfGroup: ViewModifier {
    let isHstack: Bool
    
    func body(content: Content) -> some View {
        if isHstack {
            return AnyView(HStack {content})
        } else {
            return AnyView(content)
        }
    }
}

extension View {
    func showTheGroupInHstack(_ isHstack: Bool) -> some View {
        modifier(DirectionOfGroup(isHstack: isHstack))
    }
}

struct TwoOpdScopeView_Previews: PreviewProvider {
    @StateObject static var questionLib = QuestionLib()
    static var previews: some View {
        VStack {
            TwoOpdScopeView(firstOpdName: "加数1", secondOpdName: "加数2", firstOpdMinOfQuestionLib: $questionLib.setting.firstOpdMinPlus, firstOpdMaxOfQuestionLib: $questionLib.setting.firstOpdMaxPlus, secondOpdMinOfQuestionLib: $questionLib.setting.secondOpdMinPlus, secondOpdMaxOfQuestionLib: $questionLib.setting.secondOpdMaxPlus)
        }
    }
}
