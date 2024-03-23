//
//  LoginView.swift
//  Commiserate
//
//  Created by Zeynep Toy on 23.03.2024.
//

import SwiftUI

struct LoginView: View {
    @StateObject var loginViewModel: LoginViewModel = LoginViewModel()
    @State var email: String = ""
    @State var password: String = ""
    @State var name: String = ""
    var body: some View {
        VStack(spacing: 16) {
            BorderedTextField(hint: "Email", text: $email)
            BorderedTextField(hint: "Password", text: $password)
            Button {
                loginViewModel.handleLogin(email: email, password: password)
            } label: {
                
            Text("Sign In")
                
            }
            .buttonStyle(CABorderedButtonStyle())
            .padding(.top, 16)
        }
        .padding()
    }
}

#Preview {
    LoginView()
}
