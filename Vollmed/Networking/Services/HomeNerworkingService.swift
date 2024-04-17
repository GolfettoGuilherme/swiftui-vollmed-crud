//
//  HomeNerworkingService.swift
//  Vollmed
//
//  Created by Guilherme Golfetto on 16/04/24.
//

import Foundation

//o protocolo que serve para injeção de dependencia.
protocol HomeServiceable {
    func getAllSpecialists() async throws -> Result<[Specialist]?, RequestError>
}

//struct que de fato faz o request //ppraticamente um webservice
struct HomeNerworkingService: HomeServiceable, HttpClient {
    
    func getAllSpecialists() async throws -> Result<[Specialist]?, RequestError> {
        
        return await sendRequest(
            endpoint: HomeEndpoint.getAllSpecialists,
            responseModel: [Specialist].self
        )
        
    }
    
}

