//
//  FavoriteBreweryViewModel.swift
//  BreweryBees
//
//  Created by Paulo Henrique Bendazzoli on 24/02/22.
//

import Foundation
import RealmSwift

class FavoriteBreweryViewModel {
    
    public var realmConverterProtocol: BreweryBeesRealmConverterProtocol
    
    init(realmConverterProtocol: BreweryBeesRealmConverterProtocol) {
        self.realmConverterProtocol = realmConverterProtocol
    }
    
    let realm = try! Realm()
    
    func addFavorite(breweryDefaultModel: BreweryDefaultModel, completion: @escaping (Bool) -> ()){
        realmConverterProtocol.save(realm: self.realm, breweryDefaultModel: breweryDefaultModel, completion: completion)
    }
    
    func removeFavorite(id: String, completion: @escaping (Bool) -> ()){
        realmConverterProtocol.delete(realm: self.realm, id: id, completion: completion)
    }
    
    func getFavorite() -> [BreweryDefaultModel]{
        return realmConverterProtocol.list(realm: self.realm)
    }
}
