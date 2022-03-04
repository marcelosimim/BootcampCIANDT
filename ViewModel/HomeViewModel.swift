import Foundation

class HomeViewModel {
   
    public let repository: BreweryRepositoryProtocol
    public var searchResults: [BreweryDefaultModel] = []
    
    init(repository: BreweryRepositoryProtocol) {
        self.repository = repository
    }
    var onshowResults: (() -> Void)?
    
    func searchField(searchField: String, completion: @escaping (Bool) -> ()) {
        self.searchResults = []
        
        repository.searchBrewery(searchField: searchField) {
            [weak self] result in
            switch result {
            case .success(let results):
                let filterBreweries = FilterBreweries()
                self?.searchResults = filterBreweries.filter(results: results)
                self?.onshowResults?()
                completion(true)
                
            case .failure(_):
                completion(false)
                
            }
        }
    }
}
