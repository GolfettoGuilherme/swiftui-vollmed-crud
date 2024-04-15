//
//  Login.swift
//  Vollmed
//
//  Created by Guilherme Golfetto on 13/04/24.
//

import Foundation

struct LoginRequest: Codable {
    let email: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case email
        case password = "senha"
    }
}

struct LoginResponse: Identifiable, Codable {
    let id: String
    let auth: Bool
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case auth
        case token
    }
}
