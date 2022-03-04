//
//  Repository.swift
//  BreweryBees
//
//  Created by FELIPE AUGUSTO SILVA on 17/02/22.
//

import Foundation
import UIKit

protocol BreweryRepositoryProtocol {
    func fetchDetails(id: String, completion: @escaping (BreweryDefaultModel) -> ())
    func fetchTopTen(completion: @escaping (Array<BreweryDefaultModel>) -> ())
    func reviewBrew(email: String, breweryId: String, evaluationGrade: String, completion: @escaping () -> ())
    func searchBrewery(searchField: String, completion: @escaping (Result<Array<BreweryDefaultModel>, NetworkError>) -> ())
    func fetchRated(email:String, completion: @escaping (Array<BreweryDefaultModel>) -> ())
}

class BreweryRepository: BreweryRepositoryProtocol {
    private let api: BreweryProtocolAPI
    
    init(api: BreweryProtocolAPI) {
        self.api = api
    }
    
    func fetchDetails(id: String, completion: @escaping (BreweryDefaultModel) -> ()) {
        api.fetchDetails(id: id, completion: completion)
    }
    
    func fetchTopTen(completion: @escaping (Array<BreweryDefaultModel>) -> ()){
        api.fetchTopTen(completion: completion)
    }
    func reviewBrew(email: String, breweryId: String, evaluationGrade: String, completion: @escaping () -> ()) {
        api.reviewBrew(email: email, breweryId: breweryId, evaluationGrade: evaluationGrade, completion: completion)
    }
    
    func searchBrewery(searchField: String, completion: @escaping(Result<Array<BreweryDefaultModel>, NetworkError>) -> ()){
        api.searchBrewery(searchField: searchField, completion: completion)
    }
    
    func fetchRated(email:String, completion: @escaping (Array<BreweryDefaultModel>) -> ()){
        api.fetchRated(email: email, completion: completion)
    }
}
