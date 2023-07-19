//
//  SignalView.swift
//  CalculationProject
//
//  Created by ZhangX on 2023/7/19.
//

import SwiftUI

struct SignalView: View {
    let isGreenLight: Bool
    @EnvironmentObject var questionLib: QuestionLib
    var body: some View {
        Circle()
            .fill(isGreenLight ? .green : .red)
            .opacity(setOpacity())
    }
    
    func setOpacity() -> Double {
        if isGreenLight {
            return (questionLib.check ?? false) ? 1 : 0.2
        } else {
            return (questionLib.check ?? true) ? 0.2 : 1
        }
    }
}

struct SignalView_Previews: PreviewProvider {
    static var previews: some View {
        SignalView(isGreenLight: true)
            .environmentObject(QuestionLib())
    }
}
