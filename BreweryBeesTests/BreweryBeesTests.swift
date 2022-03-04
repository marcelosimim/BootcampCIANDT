//
//  BreweryBeesTests.swift
//  BreweryBeesTests
//
//  Created by Gabriel Paschoal on 28/01/22.
//

import XCTest
@testable import BreweryBees

class BreweryBeesTests: XCTestCase {
    
    let breweryApi = MockBreweryApi()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        breweryApi.reset()
        super.tearDown()
      }
    
    // MARK: - Top 10 Tests
    
    func testTopTenResponseSuccess(){
        breweryApi.shouldReturnError = false
        breweryApi.addDataToMockArray()
        
        let repository = BreweryRepository(api: breweryApi)
        let expectation = self.expectation(description: "Top Ten Response Success")
        var topTen:Array<BreweryDefaultModel> = []
        
        repository.fetchTopTen{
            results in
            expectation.fulfill()
            topTen = results
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(10, topTen.count)
    }
    
    func testTopTenResponseError(){
        breweryApi.shouldReturnError = true
        
        let repository = BreweryRepository(api: breweryApi)
        let expectation = self.expectation(description: "Top Ten Response Error")
        var topTen:Array<BreweryDefaultModel> = []
        
        repository.fetchTopTen { results in
            expectation.fulfill()
            topTen = results
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(0, topTen.count)
    }
    
    func testTopTenViewModelSuccess(){
        breweryApi.shouldReturnError = false
        breweryApi.addDataToMockArray()
        
        let repository = BreweryRepository(api: breweryApi)
        let viewModel = BreweryTopTenViewModel(repository: repository)
        let expectation = self.expectation(description: "Top Ten View Model Success")
        var topTen: [BreweryDefaultModel] = []
        
        viewModel.fetchTopTen()
        expectation.fulfill()
        topTen = viewModel.breweryTopTen
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(10, topTen.count)
    }
    
    func testTopTenViewModelError(){
        breweryApi.shouldReturnError = true
        
        let repository = BreweryRepository(api: breweryApi)
        let viewModel = BreweryTopTenViewModel(repository: repository)
        let expectation = self.expectation(description: "Top Ten View Model Error")
        var topTen: [BreweryDefaultModel] = []
        
        viewModel.fetchTopTen()
        expectation.fulfill()
        topTen = viewModel.breweryTopTen
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(0, topTen.count)
    }
    
    // MARK: - Search Tests
    
    func testSearchResponseSuccess(){
        breweryApi.shouldReturnError = false
        breweryApi.addDataToMockArray()
        
        let repository = BreweryRepository(api: breweryApi)
        let expectation = self.expectation(description: "Search Response Success")
        var completion:Result<Array<BreweryDefaultModel>, NetworkError>?
        
        repository.searchBrewery(searchField: ""){
            result in
            print("results ", result)
            expectation.fulfill()
            completion = result
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(Result.success(breweryApi.mockArrayResponse), completion)
    }
    
    func testSearchResponseError(){
        breweryApi.shouldReturnError = true
        
        let repository = BreweryRepository(api: breweryApi)
        let expectation = self.expectation(description: "Search Response Error")
        var completion:Result<Array<BreweryDefaultModel>, NetworkError>?
        
        repository.searchBrewery(searchField: ""){
            result in
            expectation.fulfill()
            completion = result
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(Result.failure(.badURL), completion)
    }
    
    func testSearchViewModelSuccess(){
        breweryApi.shouldReturnError = false
        breweryApi.addDataToMockArray()
        
        let repository = BreweryRepository(api: breweryApi)
        let viewModel = HomeViewModel(repository: repository)
        let expectation = self.expectation(description: "Search View Model Success")
        var search: [BreweryDefaultModel] = []
        var completion: Bool?
        
        viewModel.searchField(searchField: ""){
            result in
            expectation.fulfill()
            completion = result
        }
        
        search = viewModel.searchResults
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(10, search.count)
        XCTAssertTrue(completion!)
    }
    
    func testSearchViewModelError(){
        breweryApi.shouldReturnError = true
        breweryApi.addDataToMockArray()
        
        let repository = BreweryRepository(api: breweryApi)
        let viewModel = HomeViewModel(repository: repository)
        let expectation = self.expectation(description: "Search View Model Success")
        var search: [BreweryDefaultModel] = []
        var completion: Bool?
        
        viewModel.searchField(searchField: ""){
            result in
            expectation.fulfill()
            completion = result
        }
        
        search = viewModel.searchResults
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(0, search.count)
        XCTAssertFalse(completion!)
    }
}

