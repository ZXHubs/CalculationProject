//
//  CustomGrid.swift
//  CalculationProject
//
//  Created by ZhangX on 2023/7/19.
//

import SwiftUI

struct CustomGrid: View {
    var body: some View {
        let column = 3
        let row = 4
        VStack(spacing: 4) {
            ForEach(0 ..< row) { rowNum in
                HStack(spacing: 4) {
                    ForEach(0 ..< column) { columnNum in
                        InputButtonView(btn: InputButton.allCases[rowNum * column + columnNum])
                    }
                }
            }
        }
    }
}

struct CustomGrid_Previews: PreviewProvider {
    static var previews: some View {
        CustomGrid()
            .environmentObject(InputRecord())
    }
}
