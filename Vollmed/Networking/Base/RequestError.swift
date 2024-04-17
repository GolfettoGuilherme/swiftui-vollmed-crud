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
    case custom(error: [String: Any]?)
    
    var customMessage: String {
        switch self {
        case .decode:
            return "erro de decodificação"
        case .unauthorized:
            return "Sessão expirada"
        case .custom(let errorData):
            if let jsonError = errorData?["error"] as? [String: Any] {
                let message = jsonError["message"] as? String ?? ""
                
                return message
            }
            
            return "Ops! ocorreu um erro ao carregar as informações"
        default:
            return "erro desconhecido"
        }
    }
}
