//
//  HomeViewModel.swift
//  Vollmed
//
//  Created by Guilherme Golfetto on 15/04/24.
//

import Foundation

struct HomeViewModel {
    
    //-----------------------------------------------------------------------
    // MARK: - attributes
    //-----------------------------------------------------------------------
    
    var authManager = AuthenticationManager.shared
    
    //-----------------------------------------------------------------------
    // MARK: - injected properties
    //-----------------------------------------------------------------------

    let service: HomeServiceable
    let authenticationService: AuthenticationServiceable
    
    //-----------------------------------------------------------------------
    // MARK: - init
    //-----------------------------------------------------------------------
    
    init(service: HomeServiceable, authenticationService: AuthenticationServiceable) {
        self.service = service
        self.authenticationService = authenticationService
    }
    
    //-----------------------------------------------------------------------
    // MARK: - Class methods
    //-----------------------------------------------------------------------

    func getSpecialists() async throws -> [Specialist]? {
        let result = try await service.getAllSpecialists()
        
        switch result {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        }
    }
    
    func logout() async {
        let result = await authenticationService.logout()
        
        switch result {
        case .success(_):
            authManager.removeToken()
            authManager.removePatientID()
        case .failure(let error):
            print("Erro ao realizar logout: \(error.localizedDescription)")
        }
    }

}
