//
//  AnotherCustomGrid.swift
//  CalculationProject
//
//  Created by ZhangX on 2023/7/19.
//

import SwiftUI

struct AnotherCustomGrid<Data: RandomAccessCollection, ID: Hashable, Content: View>: View {
    let forEachView: ForEach<Data, ID, Content>
    let columns: [GridItem]
    let geo: GeometryProxy
    
    init(columns: [GridItem], geo: GeometryProxy, content: () -> ForEach<Data,ID,Content>) {
        self.columns = columns
        self.geo = geo
        forEachView = content()
    }
    
    var body: some View {
        let rows = forEachView.data.count % columns.count == 0 ? forEachView.data.count/columns.count : forEachView.data.count/columns.count + 1
        VStack(spacing: geo.size.width/10/4) {
            ForEach(0 ..< rows) { rowNum in
                HStack(spacing: geo.size.width/10/4) {
                    ForEach(0 ..< columns.count) { colNum in
//                        index用于建立构建第几个子视图，为了防止数组越界需要对 index 判断
                        let index = rowNum * columns.count + colNum
                        if index < forEachView.data.count {
                            forEachView.content(forEachView.data[forEachView.data.index(forEachView.data.startIndex, offsetBy: index)])
                        } else {
                            EmptyView()
                        }
                    }
                }
            }
        }
    }
}

struct AnotherCustomGrid_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            AnotherCustomGrid(columns: Array(repeating: GridItem(), count: 3), geo: geo) {
                ForEach((InputButton.allCases ), id: \.self) {
                    inputBtn in InputButtonView(btn: inputBtn)
                }
            }
        }
    }
}
