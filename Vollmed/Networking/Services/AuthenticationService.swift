//
//  AuthenticationService.swift
//  Vollmed
//
//  Created by Guilherme Golfetto on 16/04/24.
//

import Foundation

protocol AuthenticationServiceable {
    func logout() async -> Result<Bool?, RequestError>
}


struct AuthenticationService: HttpClient, AuthenticationServiceable {
    
    func logout() async -> Result<Bool?, RequestError> {
        return await sendRequest(
            endpoint: AuthenticationEndpoint.logout,
            responseModel: nil)
    }
}
