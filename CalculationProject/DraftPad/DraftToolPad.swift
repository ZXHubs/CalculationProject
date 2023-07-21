//
//  DraftToolPad.swift
//  CalculationProject
//
//  Created by ZhangX on 2023/7/21.
//

import SwiftUI

struct DraftToolPad: View {
    let actionWrite,actionClear,actionRemoveAll: ()->Void
    @Binding var paintColor: Color
    
    var body: some View {
        GeometryReader { geo in
            let width = min(geo.size.width, geo.size.height)/10
            VStack(spacing: width/10) {
                if paintColor == .black {
                    ToolButtonView(btnName: "pencil.circle", actionBlock: actionWrite, beingSelected: true)
                    ToolButtonView(btnName: "xmark.circle", actionBlock: actionClear)
                } else {
                    ToolButtonView(btnName: "pencil.circle", actionBlock: actionWrite)
                    ToolButtonView(btnName: "xmark.circle", actionBlock: actionClear, beingSelected: true)
                }
                ToolButtonView(btnName: "trash.circle", actionBlock: actionRemoveAll)
            }
            .frame(width: width, height: width*3, alignment: .center)
            .frame(width: geo.size.width, height: geo.size.height, alignment: .topTrailing)
        }
    }
}

struct DraftToolPad_Previews: PreviewProvider {
    static var previews: some View {
        DraftToolPad(actionWrite: {}, actionClear: {}, actionRemoveAll: {}, paintColor: .constant(.black))
    }
}
