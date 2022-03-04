//
//  BreweryBeesRealm.swift
//  BreweryBees
//
//  Created by Paulo Henrique Bendazzoli on 21/02/22.
//
import RealmSwift

protocol BreweryBeesRealmProtocol {
    func save(realm: Realm, brewery: BreweryDefaultRealm, completion: @escaping (Bool) -> ())
    
    func list(realm: Realm) -> [BreweryDefaultRealm]
    
    func delete(realm: Realm, id: String, completion: @escaping (Bool) -> ())
}

class BreweryBeesRealm: BreweryBeesRealmProtocol {
    public func save(realm: Realm, brewery: BreweryDefaultRealm, completion: @escaping (Bool) -> ()) {
        do {
            let breweryFound = findById(realm: realm, id: brewery.id)
            
            if breweryFound == nil {
                realm.beginWrite()
                realm.add(brewery)
                try realm.commitWrite()
                completion(true)
            }
        } catch {
            completion(false)
        }
    }
    
    public func list(realm: Realm) -> [BreweryDefaultRealm]{
        var returnBreweries: [BreweryDefaultRealm] = []
        
        for brewery in realm.objects(BreweryDefaultRealm.self) {
            returnBreweries.append(brewery)
        }
        return returnBreweries
    }

    public func delete(realm: Realm, id: String, completion: @escaping (Bool) -> ()) {
        do {
            let brewery = findById(realm: realm, id: id)
            
            guard let brewery = brewery else {return}
            
            if brewery.id != "" {
                realm.beginWrite()
                realm.delete(brewery)
                try realm.commitWrite()
                completion(true)
            }
        } catch {
            completion(false)
        }
    }
    
    private func findById(realm: Realm, id: String) -> BreweryDefaultRealm? {
        return realm.object(ofType: BreweryDefaultRealm.self, forPrimaryKey: id)
    }
}
