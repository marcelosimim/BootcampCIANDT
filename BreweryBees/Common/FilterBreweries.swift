//
//  FilterBreweries.swift
//  BreweryBees
//
//  Created by Paulo Henrique Bendazzoli on 24/02/22.
//

import Foundation
import RealmSwift

class FilterBreweries {
    
    let realm = try! Realm()
    let realmConverterProtocol: BreweryBeesRealmConverterProtocol = BreweryContainer.shared.resolve(BreweryBeesRealmConverterProtocol.self)!
    
    func filter(results: [BreweryDefaultModel]) -> [BreweryDefaultModel] {
        let favoritiesBreweries = realmConverterProtocol.list(realm: realm)
        
        let favoriteBreweries = results.map { brewery -> BreweryDefaultModel in
            var brewNew = brewery
            brewNew.isFavorite = favoritiesBreweries.contains(where: { breweryRealm in
                breweryRealm.id == brewNew.id
            })
            return brewNew
        }
        return favoriteBreweries
    }
    
}
