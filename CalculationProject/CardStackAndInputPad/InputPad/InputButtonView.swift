//
//  InputButtonView.swift
//  CalculationProject
//
//  Created by ZhangX on 2023/7/17.
//

import SwiftUI

struct InputButtonView: View {
    let btn: InputButton
    @EnvironmentObject var input: InputRecord
    @EnvironmentObject var questionLib: QuestionLib
    
    var body: some View {
        Button (action: btnHandle, label: {
            Image(systemName: btn.btnName)
                .resizable()
                .scaledToFit()
        })
        .buttonStyle(BtnPressStyle())
        .clipShape(Circle())
    }
    
    func btnHandle() {
        if input.unchangedFromInit {
            questionLib.resetCheck()
        }
        switch btn {
        case .delete:
            if !input.isEmpty {
                input.removeLast()
            }
        case .minus:
            if input.unchangedFromInit || input.isZeroBegan {
                input.removeFirst()
                input.insertNegative()
            } else {
                input.isNegative ? input.removeFirst() : input.insertNegative()
            }
        default:
            if input.unchangedFromInit || input.isZeroBegan {
                input.removeFirst()
            }
            input.append(inputBtn: btn.rawValue)
        }
    }
}
// ButtonStyle修改视图层级的按钮样式，如果是修改交互方式就要遵循PrimitiveButtonStyle
struct BtnPressStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        if configuration.isPressed {
            return configuration.label.background(.gray)
        } else {
            return configuration.label.background(.white)
        }
    }
}

struct InputButtonView_Previews: PreviewProvider {
    static var previews: some View {
        InputButtonView(btn: .one)
//            .environmentObject(QuestionLib())
    }
}
