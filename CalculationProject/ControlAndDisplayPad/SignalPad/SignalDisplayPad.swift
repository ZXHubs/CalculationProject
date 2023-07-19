//
//  SignalDisplayPad.swift
//  CalculationProject
//
//  Created by ZhangX on 2023/7/19.
//

import SwiftUI

struct SignalDisplayPad: View {
    let width: CGFloat
    
    var body: some View {
        HStack {
            SignalView(isGreenLight: true)
            SignalView(isGreenLight: false)
        }
        .padding(width/20)
        .background(.white)
        .frame(width: width, height: width * 0.5, alignment: .center)
        .clipShape(RoundedRectangle(cornerRadius: width/10))
        .shadow(radius: 10)
    }
}

struct SignalDisplayPad_Previews: PreviewProvider {
    static var previews: some View {
        SignalDisplayPad(width: 200)
            .environmentObject(QuestionLib())
    }
}
