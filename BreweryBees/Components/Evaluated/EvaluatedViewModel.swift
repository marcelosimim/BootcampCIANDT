//
//  EvaluatedViewModel.swift
//  BreweryBees
//
//  Created by Marcelo Simim Santos on 28/02/22.
//

import UIKit

class EvaluatedViewModel {
    
    let repository: BreweryRepositoryProtocol =  BreweryContainer.shared.resolve(BreweryRepository.self)!
    var breweriesRated:[BreweryDefaultModel]?
    var onShowResults: ((Bool) -> ()) = { hasData in }
    
    func getRatedBreweries(email: String){
        repository.fetchRated(email: email) { results in
            print("results: ",results)
            if results.count > 0 {
                self.breweriesRated = results.sorted(by: { return $0.average! > $1.average! })
                self.onShowResults(true)
            }else{
                self.onShowResults(false)
            }
        }
    }
}
