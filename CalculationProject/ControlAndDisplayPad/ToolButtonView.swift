//
//  ToolButtonView.swift
//  CalculationProject
//
//  Created by ZhangX on 2023/7/19.
//

import SwiftUI

struct ToolButtonView: View {
    let btnName: String
    let actionBlock: ()->Void
    var beingSelected = false
    
    var body: some View {
        GeometryReader { geo in
            Button (action: actionBlock
            , label: {
                Image(systemName: btnName)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(beingSelected ? .white : .black)
                    .padding(min(geo.size.width, geo.size.height)/20)
                    .background(beingSelected ? .blue : .gray)
                    .clipShape(Circle())
                    .padding(min(geo.size.width, geo.size.height)/20)
            })
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
        }
    }
}

struct ToolButtonView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            ToolButtonView(btnName: "plus.circle", actionBlock: {})
            ToolButtonView(btnName: "gear", actionBlock: {})
            ToolButtonView(btnName: "folder.circle", actionBlock: {})
        }
    }
}
