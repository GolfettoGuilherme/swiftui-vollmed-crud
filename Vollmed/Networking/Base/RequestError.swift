//
//  RequestError.swift
//  Vollmed
//
//  Created by Guilherme Golfetto on 15/04/24.
//

import Foundation

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unknow
    case custom(_ error: [String: Any])
    
    var customMessage: String {
        switch self {
        case .decode:
            return "erro de decodificação"
        case .unauthorized:
            return "Sessão expirada"
        default:
            return "erro desconhecido"
        }
    }
}
