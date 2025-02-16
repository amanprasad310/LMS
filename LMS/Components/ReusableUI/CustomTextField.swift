//
//  CustomTextField.swift
//  LMS
//
//  Created by Vanshika Choudhary on 16/2/25.
//


import SwiftUI

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    var disabled: Bool = false
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .keyboardType(keyboardType)
            .disabled(disabled)
    }
}
