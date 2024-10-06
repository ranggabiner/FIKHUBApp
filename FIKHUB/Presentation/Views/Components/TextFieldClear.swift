//
//  TextFieldClear.swift
//  FIKHUB
//
//  Created by Rangga Biner on 06/10/24.
//

import SwiftUI

struct TextFieldClear: View {
    let placeholder: String
    @Binding var text: String
    let keyboardType: UIKeyboardType
    let onClear: (() -> Void)?
    
    var body: some View {
        VStack {
            HStack {
                TextField(placeholder, text: $text)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocapitalization(.none)
                    .keyboardType(keyboardType)
                
                if !text.isEmpty && onClear != nil {
                    Button(action: {
                        onClear?()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .font(.body)
        }

        
    }
}
