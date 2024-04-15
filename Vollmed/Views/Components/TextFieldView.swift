//
//  TextFieldView.swift
//  Vollmed
//
//  Created by Guilherme Golfetto on 13/04/24.
//

import SwiftUI

enum TextFieldType {
    case email
    case password
    case text
    case cpf
    case phoneNumber
}

struct TextFieldView: View {
    
    var title: String
    var textFieldType :TextFieldType
    @Binding var bindingText: String
    
    var body: some View {
        switch textFieldType {
        case .email:
            TextField(title, text: $bindingText)
                .padding(14)
                .background(Color.gray.opacity(0.25))
                .cornerRadius(14.0)
                .autocorrectionDisabled()
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
        case .password:
            SecureField(title, text: $bindingText)
                .padding(14)
                .background(Color.gray.opacity(0.25))
                .cornerRadius(14.0)
        case .text:
            TextField(title, text: $bindingText)
                .padding(14)
                .background(Color.gray.opacity(0.25))
                .cornerRadius(14.0)
                .autocorrectionDisabled()
        case .cpf:
            TextField(title, text: $bindingText)
                .padding(14)
                .background(Color.gray.opacity(0.25))
                .cornerRadius(14.0)
                .keyboardType(.numberPad)
        case .phoneNumber:
            TextField(title, text: $bindingText)
                .padding(14)
                .background(Color.gray.opacity(0.25))
                .cornerRadius(14.0)
                .keyboardType(.numberPad)
        }
        
    }
}
