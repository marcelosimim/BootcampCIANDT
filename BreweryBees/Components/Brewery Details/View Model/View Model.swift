//
//  View Model.swift
//  BreweryBees
//
//  Created by FELIPE AUGUSTO SILVA on 16/02/22.
//

import Foundation

class BreweryDetailViewModel {
    public let repository: BreweryRepositoryProtocol  // registering API protocol to a variable
    
    public var name: String = ""
    public var id: String = ""
    public var website_url: String = ""
    public var type: String = ""
    public var street: String = ""
    public var avarage: Double = 0.0
    public var photos: [String] = []
    public var size_evaluations: String = "0"
//   Initializer
    init(repository: BreweryRepositoryProtocol) {
        self.repository = repository
    }

    var onShowDetail:(() -> Void)?
    
//    MARK: FETCHING DATA AND HANDLING THE RESPONSE OUTSIDE THE VIEW CONTROLLER
    public func fetchDetails(id: String) {
        repository.fetchDetails(id: id) { [weak self] result in
            self?.name = result.name ?? ""
            self?.website_url = result.website_url ?? "Website indisponível"
            self?.street = result.street ?? "Endereço não disponível"
            self?.type = result.brewery_type ?? ""
            self?.avarage = result.average ?? 0.0
            self?.size_evaluations = String(result.size_evaluations ?? 0)
            result.photos.map { img in
                    self?.photos.append(contentsOf: img)
            }
            self?.onShowDetail?()
        }
    }
    
    
    public func rateBrew(id: String, email: String, rate: String, completion: @escaping () -> ()) {
        repository.reviewBrew(email: email, breweryId: id, evaluationGrade: rate, completion: completion)
        print("view model")
    }
}
