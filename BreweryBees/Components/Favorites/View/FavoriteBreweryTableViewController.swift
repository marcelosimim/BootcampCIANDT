//
//  FavoriteBreweryTableViewController.swift
//  BreweryBees
//
//  Created by FELIPE AUGUSTO SILVA on 18/02/22.
//

import Foundation
import UIKit

class FavoriteBreweryTableViewController: UIViewController {
    func loadData() {
        self.tableView.reloadData()
    }
    
    private enum Constants {
        static let navigationBarFavoriteTitle = "favorite.title.navigationBar"
        static let noAddedFavoriteTitle = "favorite.title.noFavoriteAdded"
        static let noAddedFavoriteDescription = "favorite.description.noFavoriteAdded"
        static let favoriteAddedTitle = "favorite.title.added"
        static let favoriteBreweryResultOne = "favorite.breweryResultOne"
        static let favoriteBreweryResultMore = "favorite.breweryResultMore"
        static let favoriteOrderBy = "favorite.orderBy"
        static let favoritePopUpRemoveTitle = "favorite.removePopUp.title"
        static let favoritePopUpRemoveDescription = "favorite.removePopUp.description"
        static let favoritePopUpCancelButton = "favorite.removePopUp.cancelButton"
        static let favoritePopUpConfirmButton = "favorite.removePopUp.confirmButton"
    }
    
    static let identifier = "SearchResultViewController"
    
    weak var delegate: SearchResultDelegate?
    
    let brewryDetailVC = BrewryDetailVC()
    
    var brewerySavedOnRealmModel: [BreweryDefaultModel] = []
    
    let favoriteBreweryViewModel: FavoriteBreweryViewModel = BreweryContainer.shared.resolve(FavoriteBreweryViewModel.self)!
    
    let titleOfSearch: UILabel = {
        let text = UILabel()
        
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = Constants.favoriteAddedTitle.localized
        text.textAlignment = .left
        text.font = UIFont(name: "Quicksand-Bold", size: 22)
        
        return text
        
    }()
    
    let numberOfResults: UILabel = {
        let text = UILabel()
        
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textAlignment = .left
        text.font = UIFont(name: "Quicksand-Regular", size: 14)
        
        return text
    }()
    
    let sortedBy: UILabel = {
        let text = UILabel()
        let orderByLabel = "Nota"
        
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = "\(Constants.favoriteOrderBy.localized) \(orderByLabel)"
        text.textAlignment = .left
        text.font = UIFont(name: "Quicksand-Regular", size: 14)
        
        return text
    }()
    
    let filterButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage.init(systemName: "text.append"), for: .normal)
        button.tintColor = .black
        
        return button
    }()
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(sortedBy)
        self.view.addSubview(tableView)
        self.view.addSubview(numberOfResults)
        self.view.addSubview(filterButton)
        self.view.addSubview(titleOfSearch)
        
        for view in self.view.subviews {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        brewerySavedOnRealmModel = favoriteBreweryViewModel.getFavorite()
        
        numberOfResults.text = (brewerySavedOnRealmModel.count == 1 ?
                                "\(brewerySavedOnRealmModel.count) \(Constants.favoriteBreweryResultOne.localized)" :
        "\(brewerySavedOnRealmModel.count) \(Constants.favoriteBreweryResultMore.localized)")
        
        generateConstraints()
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: BreweryTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: BreweryTableViewCell.identifier)
    
    }


    func generateConstraints() {
        NSLayoutConstraint.activate([
            
            titleOfSearch.topAnchor.constraint(equalTo: super.view.topAnchor, constant: 16),
            titleOfSearch.leadingAnchor.constraint(equalTo: super.view.leadingAnchor, constant: 16),
            titleOfSearch.trailingAnchor.constraint(equalTo: super.view.trailingAnchor, constant: -16),
            
            numberOfResults.topAnchor.constraint(equalTo: titleOfSearch.bottomAnchor, constant: 4),
            numberOfResults.leadingAnchor.constraint(equalTo: titleOfSearch.leadingAnchor),
            numberOfResults.trailingAnchor.constraint(equalTo: titleOfSearch.trailingAnchor),
            
            filterButton.topAnchor.constraint(equalTo: numberOfResults.bottomAnchor, constant: 16),
            filterButton.trailingAnchor.constraint(equalTo: titleOfSearch.trailingAnchor),
            
            sortedBy.topAnchor.constraint(equalTo: filterButton.topAnchor),
            sortedBy.leadingAnchor.constraint(equalTo: titleOfSearch.leadingAnchor),
            sortedBy.trailingAnchor.constraint(lessThanOrEqualTo: filterButton.leadingAnchor, constant: 8),
            
            tableView.topAnchor.constraint(equalTo: sortedBy.bottomAnchor, constant: 12),
            tableView.leadingAnchor.constraint(equalTo: sortedBy.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: titleOfSearch.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
        ])
    }
}

extension FavoriteBreweryTableViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BreweryTableViewCell.identifier, for: indexPath) as! BreweryTableViewCell
        cell.configureCell(with: brewerySavedOnRealmModel[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        brewerySavedOnRealmModel.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}
