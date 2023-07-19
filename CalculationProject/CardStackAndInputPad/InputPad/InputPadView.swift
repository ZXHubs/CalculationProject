//
//  InputPadView.swift
//  CalculationProject
//
//  Created by ZhangX on 2023/7/17.
//

import SwiftUI

struct InputPadView: View {
    var body: some View {
        let columns = Array(repeating: GridItem(), count: 3)
        GeometryReader { geo in
            AnotherCustomGrid(columns: columns, geo: geo) {
                ForEach((InputButton.allCases ), id: \.self) {
                    inputBtn in InputButtonView(btn: inputBtn)
                }
            }
            //        CustomGrid()
            .padding(geo.size.width/10/4)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: geo.size.width/10))
            //        .clipShape(RoundedRectangle(cornerRadius: 25))
            .cornerRadius(25)
            .shadow(radius: 10)
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
        }
    }
}

enum InputButton: String, CaseIterable {
case one = "1", two = "2", three = "3", four = "4", five = "5", six = "6", seven = "7", eight = "8", nine = "9", delete = "-2", zero = "0", minus = "-1"
    var btnName: String {
        switch self {
        case .delete:
            return "arrow.left.circle"
        case .minus:
            return "plusminus.circle"
        default:
            return self.rawValue + ".circle"
        }
    }
}

struct InputPadView_Previews: PreviewProvider {
    static var previews: some View {
        InputPadView()
    }
}
