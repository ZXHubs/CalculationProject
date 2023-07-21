//
//  BackgroundView.swift
//  CalculationProject
//
//  Created by ZhangX on 2023/7/21.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(stops: [
            .init(color: Color(red: 0.7, green: 0.9, blue: 0.9), location: 0.2),
            .init(color: .white, location: 0.45),
            .init(color: Color(red: 1, green: 0.75, blue: 0.9), location: 0.8),
            .init(color: .white, location: 0.9),
            .init(color: Color(red: 0.6, green: 0.85, blue: 0.2), location: 1)
        ]), startPoint: .top, endPoint: .bottom)
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
