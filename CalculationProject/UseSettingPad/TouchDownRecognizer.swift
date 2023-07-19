//
//  TouchDownRecognizer.swift
//  CalculationProject
//
//  Created by ZhangX on 2023/7/16.
//

import UIKit

class TouchDownRecognizer: UIGestureRecognizer {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if let touchView = touches.first?.view, exclude(view: touchView, ofKind: UISegmentedControl.self, UITextField.self) {
            state = .cancelled
        } else {
            state = .recognized
        }
    }
//    ...传入一个或多个参数
    func exclude(view: UIView, ofKind: UIControl.Type...) -> Bool{
        for kind in ofKind {
            if view.isKind(of: kind) {
                return true
            }
        }
        return false
    }
}

extension UIApplication:UIGestureRecognizerDelegate {
    func addTouchDownRecognizer() {
        guard let window = windows.first else { return }
        let recognizer = TouchDownRecognizer(target: window, action: #selector(UIView.endEditing))
        recognizer.cancelsTouchesInView = false
        recognizer.delegate = self
        window.addGestureRecognizer(recognizer)
    }
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
//    即使去除手势识别，保证系统资源不被滥用
    func removeTouchDownRecognizer() {
        guard let window = windows.first else { return }
        if let recognizer = window.gestureRecognizers?.first(where: { $0.isKind(of: TouchDownRecognizer.self)}) {
            window.removeGestureRecognizer(recognizer)
        }
    }
}
