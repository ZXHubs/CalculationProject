//
//  CustomTextFieldView.swift
//  CalculationProject
//
//  Created by ZhangX on 2023/7/16.
//

import SwiftUI

struct CustomTextFieldView: UIViewRepresentable {
    @Binding var inputNumStr: String
    var inputValidation: (Bool)->Void
    @Binding var showingAlert: Bool
    
    func makeUIView(context: Context) -> UITextField  {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "请输入..."
        textField.text = inputNumStr
        popupKeyboard(textField: textField)
        textField.delegate = context.coordinator
        return textField
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.text = inputNumStr
        if uiView.text == "", !showingAlert {
            popupKeyboard(textField: uiView)
        }
    }
    func popupKeyboard(textField: UITextField) {
        //        异步模式
        DispatchQueue.main.async {
            if textField.window != nil {
                textField.becomeFirstResponder()
            }
        }
    }
//    创建一个自定义的实例，将UIView中产生的变化反馈给swiftUI
    func makeCoordinator() -> Coordinator {
        Coordinator(customTextField: self)
    }
    class Coordinator: NSObject, UITextFieldDelegate {
        var customTextField: CustomTextFieldView
        init(customTextField: CustomTextFieldView) {
            self.customTextField = customTextField
        }
        func textFieldDidEndEditing(_ textField: UITextField) {
            if let input = textField.text {
                customTextField.inputNumStr = input
            }
            customTextField.inputValidation(false)
        }
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
        }
    }
}

struct CustomTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextFieldView(inputNumStr: .constant(""), inputValidation: {_ in}, showingAlert: .constant(false))
    }
}
