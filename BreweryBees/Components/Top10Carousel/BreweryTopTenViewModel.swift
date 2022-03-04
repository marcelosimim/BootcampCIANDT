//
//  CarouselViewModel.swift
//  BreweryBees
//
//  Created by Marcelo Simim Santos on 18/02/22.
//

import Foundation

class BreweryTopTenViewModel {

    public let repository: BreweryRepositoryProtocol
    public var breweryTopTen: [BreweryDefaultModel] = []
    public var breweriesImages: [String] = []
    
    var onShowTopTen:(() -> Void)?
    
    init(repository: BreweryRepositoryProtocol){
        self.repository = repository
    }
    
    func fetchTopTen(){
        repository.fetchTopTen {results in
            results.forEach{
                self.breweryTopTen.append($0)
                if ($0.photos?.count ?? 0 > 0) {
                    self.breweriesImages.append($0.photos?[0] ?? "")
                }else{
                    self.breweriesImages.append("")
                }
                //results.photos[0]
            }
            self.onShowTopTen?()
        }
    }
}
