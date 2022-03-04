//
//  SearchResultViewModel.swift
//  BreweryBees
//
//  Created by Paulo Henrique Bendazzoli on 23/02/22.
//

import Foundation
import RealmSwift

class SearchResultViewModel {
    
    public var realmConverterProtocol: BreweryBeesRealmConverterProtocol
    
    init(realmConverterProtocol: BreweryBeesRealmConverterProtocol) {
        self.realmConverterProtocol = realmConverterProtocol
    }
    
    var onRefreshResults: (() -> Void)?
    let realm = try! Realm()
    
    func addFavorite(breweryDefaultModel: BreweryDefaultModel, completion: @escaping (Bool) -> ()){
        realmConverterProtocol.save(realm: self.realm, breweryDefaultModel: breweryDefaultModel, completion: completion)
        self.onRefreshResults?()
    }
    
    func removeFavorite(id: String, completion: @escaping (Bool) -> ()){
        realmConverterProtocol.delete(realm: self.realm, id: id, completion: completion)
        self.onRefreshResults?()
    }
    
    func getFavorite() -> [BreweryDefaultModel]{
        return realmConverterProtocol.list(realm: self.realm)
    }
}
