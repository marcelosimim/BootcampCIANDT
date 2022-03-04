//
//  API.swift
//  BreweryBees
//
//  Created by FELIPE AUGUSTO SILVA on 16/02/22.
//

import Foundation

enum NetworkError: Error {
    case badURL
}

protocol BreweryProtocolAPI {
    func fetchDetails(id: String, completion: @escaping (BreweryDefaultModel) -> ())
    func fetchTopTen(completion: @escaping (Array<BreweryDefaultModel>) -> ())
    func searchBrewery(searchField: String, completion: @escaping (Result<Array<BreweryDefaultModel>, NetworkError>) -> ())
    func reviewBrew(email: String, breweryId: String, evaluationGrade: String, completion: @escaping () -> ())
    func fetchRated(email:String, completion: @escaping (Array<BreweryDefaultModel>) -> ())
}

class BreweryApi: BreweryProtocolAPI {
    let baseURL: String = "https://bootcamp-mobile-01.eastus.cloudapp.azure.com/breweries"
   
    //   MARK: Function to fetch the brewery Details
    func fetchDetails(id: String, completion: @escaping (BreweryDefaultModel) -> ()) {
        //    Checking if URL is valid
        guard let sourceURL = URL(string: "\(baseURL)\(id)" )
        else {
            return
        }
        
        //     Making request and handling response
        URLSession.shared.dataTask(with: sourceURL) {(data, URLResponse, error) in
            
            if let data = data {
                
                do {
                    let decoder = JSONDecoder()
                    let results = try decoder.decode(BreweryDefaultModel.self, from: data)
                    print("results", results)
                    completion(results)
                }
                catch {
                    print("error", error)
                    return
                }
                
            }
        }.resume()
    }
    
    
//      Fetch top ten
func fetchTopTen(completion: @escaping (Array<BreweryDefaultModel>) -> ()) {
        guard let sourceURL = URL(string: "\(baseURL)/topTen")
        else {
            return
        }
        
        URLSession.shared.dataTask(with: sourceURL) {(data, URLResponse, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let results = try decoder.decode(Array<BreweryDefaultModel>.self, from: data)
                    print("results", results)
                    completion(results)
                }
                catch {
                    print("error", error)
                    return
                    }
            }
        }.resume()
    }
    
//      MARK: Function to search the brewery
    
    func searchBrewery(searchField: String, completion: @escaping (Result<Array<BreweryDefaultModel>, NetworkError>) -> ()) {
        var newSearchField = searchField
        
        if(searchField.contains(" ")) {
            newSearchField = searchField.replacingOccurrences(of: " ", with: "%20")
        }
        
        guard let sourceURL = URL(string: "\(baseURL)?by_city=\(newSearchField)")
        else {
            return
        }
        
        URLSession.shared.dataTask(with: sourceURL) {
            data, _, error in
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let results = try decoder.decode(Array<BreweryDefaultModel>.self, from: data) 
                    print("this is: \(results)")
                    completion(.success(results))
                    
                } catch {
                    print("Error: \(error)")
                    completion(.failure(.badURL))
                }
            }
            
        }.resume()
        
    }
    func reviewBrew(email: String, breweryId: String, evaluationGrade: String, completion: () -> ()) {
        guard let rateURL = URL(string: "\(baseURL)") else {
            return  }
        
        var request = URLRequest(url: rateURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("evaluation", evaluationGrade)
        let parameters: [String: Any] = [
            "email": email,
            "brewery_id": breweryId,
            "evaluation_grade": Float(evaluationGrade)
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
        
        URLSession.shared.dataTask(with: request) { data, _, error   in
            guard let data = data, error == nil else {
                return
            }
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print("success: \(response)")
                
            }
            catch {
                print("error", error)
            }
        }.resume()
    }
    
    func fetchRated(email: String, completion: @escaping (Array<BreweryDefaultModel>) -> ()) {
        guard let sourceURL = URL(string: "\(baseURL)/myEvaluations/\(email)")
        else {
            return
        }
        
        URLSession.shared.dataTask(with: sourceURL) {(data, URLResponse, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let results = try decoder.decode(Array<BreweryDefaultModel>.self, from: data)
                    print(results)
                    completion(results)
                }
                catch {
                    print("error", error)
                    return
                }
            }
        }.resume()
    }
}
