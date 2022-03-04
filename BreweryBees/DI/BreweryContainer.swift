//
//  Container.swift
//  BreweryBees
//
//  Created by FELIPE AUGUSTO SILVA on 16/02/22.
//

import Foundation
import Swinject

class BreweryContainer {
    public static var shared: Container {
       let breweryResolver = Container()
        
//        MARK: Registering protocol with call back of the API 
        breweryResolver.register(BreweryProtocolAPI.self) {_ in BreweryApi()}
        
//        MARK: Registering View Model
        breweryResolver.register(BreweryDetailViewModel.self) { resolver in BreweryDetailViewModel(repository: resolver.resolve(BreweryRepositoryProtocol.self)!) }
        breweryResolver.register(BreweryRepository.self) { r in
            BreweryRepository(api: r.resolve(BreweryProtocolAPI.self)!)
        }
        
        // MARK: - Registering TopTen View Model
        breweryResolver.register(BreweryTopTenViewModel.self) { resolver in BreweryTopTenViewModel(repository:
               resolver.resolve(BreweryRepositoryProtocol.self)!)
        }
        
//       MARK: Registering Repository
        breweryResolver.register(BreweryRepositoryProtocol.self) { r in
            BreweryRepository(api: r.resolve(BreweryProtocolAPI.self)!)
        }
        
//       MARK: Registering HomeViewModel
        breweryResolver.register(HomeViewModel.self) {resolver in
            HomeViewModel(repository: resolver.resolve(BreweryRepositoryProtocol.self)!)
        }
            
        // MARK: Realm's registering
        breweryResolver.register(BreweryBeesRealmProtocol.self) {_ in BreweryBeesRealm()}
        
        breweryResolver.register(BreweryBeesRealmConverterProtocol.self) {
            r in BreweryBeesRealmConverter(breweryBeesRealmProtocol: r.resolve(BreweryBeesRealmProtocol.self)!)
        }
        
        // MARK: Search ViewModel
        breweryResolver.register(SearchResultViewModel.self) { resolver in SearchResultViewModel(realmConverterProtocol: resolver.resolve(BreweryBeesRealmConverterProtocol.self)!)
        }
        
        // MARK: Favorite ViewModel
        breweryResolver.register(FavoriteBreweryViewModel.self) { resolver in FavoriteBreweryViewModel(realmConverterProtocol: resolver.resolve(BreweryBeesRealmConverterProtocol.self)!)
        }
        
        breweryResolver.register(EvaluatedViewModel.self) { _ in EvaluatedViewModel() }
        
        return breweryResolver
    }
}
