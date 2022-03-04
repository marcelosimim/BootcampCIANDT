//
//  MockBreweryApi.swift
//  BreweryBeesTests
//
//  Created by Marcelo Simim Santos on 23/02/22.
//

import Foundation

@testable import BreweryBees

class MockBreweryApi {
  
    var shouldReturnError = false

    func reset(){
        mockArrayResponse = []
    }
    
    convenience init(){
        self.init(false)
    }
    
    init(_ shouldReturnError: Bool){
        self.shouldReturnError = shouldReturnError
    }
    
    var mockArrayResponse: [BreweryDefaultModel] = []
    
    func addDataToMockArray(){
        for i in 1...10{
            mockArrayResponse.append(BreweryDefaultModel(id: "\(i)", name: "\(i)", website_url: "\(i)", street: "\(i)", photos: ["\(i)", "\(i+1)", "\(i+2)"], average: Double(i), size_evaluations: i, brewery_type: "\(i)", city: "\(i)", state: "\(i)", country: "\(i)", latitude: Double(i), longitude: Double(i), postal_code: "\(i)", phone: "\(i)"))
        }
    }
}

extension MockBreweryApi: BreweryProtocolAPI {
    func fetchDetails(id: String, completion: @escaping (BreweryDefaultModel) -> ()) {
        
    }
    
    func fetchTopTen(completion: @escaping (Array<BreweryDefaultModel>) -> ()) {
        if shouldReturnError {
            completion([])
        }else{
            completion(mockArrayResponse)
        }
    }
    
    func searchBrewery(searchField: String, completion: @escaping (Result<Array<BreweryDefaultModel>, NetworkError>) -> ()) {
        if shouldReturnError {
            completion(.failure(.badURL))
        }else{
            completion(.success(mockArrayResponse))
        }
    }
    
    func reviewBrew(email: String, breweryId: String, evaluationGrade: String, completion: @escaping () -> ()) {
        
    }
}
