//
//  HttpClient.swift
//  Vollmed
//
//  Created by Guilherme Golfetto on 15/04/24.
//

import Foundation

protocol HttpClient {
    //T tipo generico que implemente o Decodable
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type?) async -> Result<T?, RequestError>
}

extension HttpClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type?) async -> Result<T?, RequestError> {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.port = 3000
        
//        let urlApiary = "https://private-c004a-vollmedapierros.apiary-mock.com/specialists"
//        
//        guard let url = URL(string: urlApiary) else {
//            return .failure(.invalidURL)
//        }
        
        guard let url = urlComponents.url else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            
            switch response.statusCode {
                
            case 200...299:
                
                guard let responseModel = responseModel else {
                    return .success(nil)
                }
                
                guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                    return .failure(.decode)
                }
                
                return .success(decodedResponse)
                
            case 400:
                let errorResponse = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
                //olha como tudo se encaixa
                return .failure(.custom(error: errorResponse))
            case 401:
                return .failure(.unauthorized)
                
            default:
                return .failure(.unknow)
            }
            
        } catch {
            return .failure(.unknow)
        }
    }
}
