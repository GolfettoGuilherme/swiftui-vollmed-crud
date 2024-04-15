//
//  AuthenticationManager.swift
//  Vollmed
//
//  Created by Guilherme Golfetto on 15/04/24.
//

import Foundation
//esse protocolo só pode funcionar em uma classe
class AuthenticationManager: ObservableObject {
    
    static let shared = AuthenticationManager()
    
    @Published var token: String?
    @Published var patientID: String?
    
    //ninguem pode instaciar essa classe
    private init() {
        self.token = KeychainHelper.get(for: "app-vollmed-token")
        self.patientID = KeychainHelper.get(for: "app-vollmed-patient-id")
    }
    
    func saveToken(token: String) {
        KeychainHelper.save(value: token, key: "app-vollmed-token")
        DispatchQueue.main.async {
            self.token = token
        }
    }
    
    func removeToken() {
        KeychainHelper.remove(for: "app-vollmed-token")
        DispatchQueue.main.async {
            self.token = nil
        }
    }
    
    func savePatientID(id: String) {
        KeychainHelper.save(value: id, key: "app-vollmed-patient-id")
        DispatchQueue.main.async {
            self.patientID = id
        }
    }
    
    func removePatientID() {
        KeychainHelper.remove(for: "app-vollmed-patient-id")
        DispatchQueue.main.async {
            self.patientID = nil
            
        }
    }
}
