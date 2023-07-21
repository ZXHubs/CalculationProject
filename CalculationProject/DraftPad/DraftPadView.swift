//
//  DraftPadView.swift
//  CalculationProject
//
//  Created by ZhangX on 2023/7/21.
//

import SwiftUI

struct DraftPadView: View {
    @State private var trackLine: [CGPoint] = []
    @State private var totalLines: [historyLineInfo] = []
    @State private var paintColor = Color.black
    var drawGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { gesture in
                trackLine.append(gesture.location)
            }
            .onEnded { gesture in
                totalLines.append(historyLineInfo(points: trackLine, time: Date(), color: paintColor))
                trackLine = []
            }
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.white
                Text("草\n稿\n纸")
                    .foregroundColor(.gray)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .opacity(0.3)
                    .zIndex(1)
                ForEach(totalLines, id: \.time) { line in
                    drawLine(line: line)
                }
                //            增加第二个path路径，显示路径
                drawLine(points: trackLine)
                DraftToolPad(actionWrite: switchToPencil, actionClear: switchToEraser, actionRemoveAll: removeAll, paintColor: $paintColor)
                    .padding([.top, .trailing],min(geo.size.width, geo.size.height)/10/4)
            }
            .gesture(drawGesture)
            .cornerRadius(min(geo.size.width, geo.size.height)/10)
            .shadow(radius: 10)
        }
    }
    
    func switchToPencil() {
        paintColor = .black
    }
    
    func switchToEraser() {
        paintColor = .white
    }
    func removeAll() {
        totalLines = []
        paintColor = .black
    }
    func drawLine(points: [CGPoint]) -> some View {
        Path { path in
            path.addLines(points)
        }
        .stroke(paintColor, lineWidth: 3)
    }
    func drawLine(line: historyLineInfo) -> some View {
        Path { path in
            path.addLines(line.points)
        }
        .stroke(line.color, lineWidth: 3)
    }
    
    struct historyLineInfo {
        let points: [CGPoint]
        let time: Date
        let color: Color
    }
}

struct DraftPadView_Previews: PreviewProvider {
    static var previews: some View {
        DraftPadView()
    }
}
