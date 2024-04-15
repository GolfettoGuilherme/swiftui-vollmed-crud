//
//  SingUpView.swift
//  Vollmed
//
//  Created by Guilherme Golfetto on 13/04/24.
//

import SwiftUI

struct SingUpView: View {
    
    let service = WebService()
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var cpf: String = ""
    @State private var phoneNumber: String = ""
    @State private var healthPlan: String = ""
    @State private var password: String = ""
    
    @State private var showAlert: Bool = false
    @State private var isPatientRegistered: Bool = false
    
    @State private var navigateToSingInView: Bool = false
    
    let healthPlans: [String] = [
        "Amil",
        "Unimed",
        "Bradesco Saude",
        "SulAmérica",
        "Hapvida",
        "Notredame Intermédica",
        "Golden Cross",
        "Outro"
    ]
    
    init() {
        self.healthPlan = healthPlans[0]
    }
    
    func register() async {
        let patient = Patient(
            id: nil,
            cpf: cpf,
            name: name,
            email: email,
            password: password,
            phoneNumber: phoneNumber,
            healthPlan: healthPlan
        )
        
        do {
            if let _ = try await service.registerPatient(patient: patient) {
                isPatientRegistered = true
            } else {
                isPatientRegistered = false
            }
        } catch {
            isPatientRegistered = false
            print("Ocorreu um erro ao cadastrar paciente: \(error)")
        }
        showAlert = true
    }
    
    var body: some View {
        ScrollView(showsIndicators: false, content: {
            VStack(alignment: .leading, spacing: 16.0, content: {
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 36.0, alignment: .center)
                    .padding(.vertical)
                
                Text("Ola, boas vindas!")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.accent)
                
                Text("insira seus dados para criar uma conta")
                    .font(.title3)
                    .foregroundStyle(.gray)
                    .padding(.bottom)
                
                TextAccentView(text: "Nome")
                
                TextFieldView(
                    title: "Insira seu nome completo",
                    textFieldType: .text,
                    bindingText: $name
                )
                
                TextAccentView(text: "Email")
                
                TextFieldView(
                    title: "Insira seu email",
                    textFieldType: .email,
                    bindingText: $email)
                
                TextAccentView(text: "CPF")
                
                TextFieldView(
                    title: "Insira seu CPF",
                    textFieldType: .cpf,
                    bindingText: $cpf
                )
                
                TextAccentView(text: "Telefone")
                
                TextFieldView(
                    title: "Insira seu telefone",
                    textFieldType: .phoneNumber,
                    bindingText: $phoneNumber
                )
                
                TextAccentView(text: "Senha")
                
                TextFieldView(
                    title: "Insira sua senha",
                    textFieldType: .password,
                    bindingText: $password)
                
                TextAccentView(text: "Selecione o seu plano de saúde")
                
                Picker("Plano de saude", selection: $healthPlan) {
                    ForEach(healthPlans, id: \.self) { healthPlan in
                        Text(healthPlan)
                    }
                }
                
                Button {
                    Task {
                        await register()
                    }
                } label: {
                    ButtonView(text: "Cadastrar")
                }

                NavigationLink {
                    SingInView()
                } label: {
                    Text("Já possiu uma conta? Faça o login!")
                        .bold()
                        .foregroundStyle(.accent)
                        .frame(maxWidth: .infinity, alignment: .center)
                }

                
            })
        })
        .navigationBarBackButtonHidden()
        .padding()
        .alert(isPatientRegistered ? "Sucesso!" : "Ops, algo deu errado",
               isPresented: $showAlert,
               presenting: $isPatientRegistered) { _ in
            Button(action: {
                navigateToSingInView = true
            }, label: {
                Text("Ok")
            })
        } message: { _ in
            if isPatientRegistered {
                Text("O paciente foi criado com sucesso!")
            } else {
                Text("Houve um erro ao cadastrar o paciente, por favor, tente novamente.!")
            }
        }
        .navigationDestination(isPresented: $navigateToSingInView) {
            SingInView()
        }
    }
}

#Preview {
    SingUpView()
}
