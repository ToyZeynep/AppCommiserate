//
//  RegisterView.swift
//  Commiserate
//
//  Created by Zeynep Toy on 23.03.2024.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var registerViewModel: RegisterViewModel = RegisterViewModel()
    @State var email: String = ""
    @State var password: String = ""
    @State var name: String = ""
    var body: some View {
        VStack(spacing: 16) {
            BorderedTextField(hint: "Name", text: $name )
            BorderedTextField(hint: "Email", text: $email)
            BorderedTextField(hint: "Password", text: $password)
            Button {
                registerViewModel.handleRegister(email: email, password: password, name: name)
            } label: {
                
            Text("Sign Up")
                
            }
            .buttonStyle(CABorderedButtonStyle())
            .padding(.top, 16)
        }
        .padding()
    }
}

#Preview {
    RegisterView()
}
