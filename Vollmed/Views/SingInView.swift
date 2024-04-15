//
//  SingInView.swift
//  Vollmed
//
//  Created by Guilherme Golfetto on 13/04/24.
//

import SwiftUI

struct SingInView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    @State private var isLoading: Bool = false
    
    var authManager = AuthenticationManager.shared
    
    let service = WebService()
    
    func login() async {
        isLoading = true
        do {
            if let response = try await service.loginPatient(email: email, password: password) {
                isLoading = false
                authManager.saveToken(token: response.token)
                authManager.savePatientID(id: response.id)
            } else {
                isLoading = false
                showAlert = true
            }
        } catch {
            isLoading = false
            showAlert = true
            print("ocorreu um erro no login: \(error)")
        }
    }
    
    var body: some View {
        if isLoading {
            VStack(alignment: .center) {
                ProgressView()
                Text("Carregando...")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.accent)
            }
            .padding()
            .frame(maxWidth: 200, maxHeight: 200)
            .background(Color(.black).opacity(0.15))
            .cornerRadius(16.0)
            
        } else {
            VStack(alignment: .leading, spacing: 16.0, content: {
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 36.0, alignment: .center)
                
                Text("Ola!")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.accent)
                
                Text("Preencha para acessar sua conta.")
                    .font(.title3)
                    .foregroundStyle(.gray)
                    .padding(.bottom)
                
                TextAccentView(text: "Email")
                
                TextFieldView(
                    title: "Insira seu email",
                    textFieldType: .email,
                    bindingText: $email
                )
                
                TextAccentView(text: "Senha")
                
                TextFieldView(
                    title: "Insira sua senha",
                    textFieldType: .password,
                    bindingText: $password
                )
                
                Button(action: {
                    Task {
                        await login()
                    }
                }, label: {
                    ButtonView(text: "Entrar")
                })
                
                NavigationLink {
                    SingUpView()
                } label: {
                    Text("Ainda não possui uma conta? cadastre-se")
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center) //garantir que vai ficar centralizado
                }

            })
            .padding()
            .navigationBarBackButtonHidden()
            .alert("Ops, algo deu errado", isPresented: $showAlert) {
                Button {
                    //
                } label: {
                    Text("Ok")
                }

            } message: {
                Text("House um erro ao entrar na sua conta, por favor, tente novamente")
            }
        }
    }
}

#Preview {
    SingInView()
}
