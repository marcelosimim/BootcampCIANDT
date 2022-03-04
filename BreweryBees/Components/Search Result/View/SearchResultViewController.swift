//
//  SearchResultViewController.swift
//  BreweryBees
//
//  Created by Francisca Elisa Carvalho Rosa on 01/02/22.
//

import UIKit

protocol SearchResultDelegate: AnyObject{
    func navigateToDetails(id: String)
}

class SearchResultViewController: UIViewController {
    
    static let identifier = "SearchResultViewController"
    
    weak var delegate: SearchResultDelegate?
    
    let brewryDetailVC = BrewryDetailVC()
    
    var breweryDefaultModel: [BreweryDefaultModel] = []
    
    let searchResultViewModel: SearchResultViewModel = BreweryContainer.shared.resolve(SearchResultViewModel.self)!
    
    let titleOfSearch: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "Segundo a opinião dos usuários:"
        
        return label
    }()
    let numberOfResults: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.text = "30 resultados"
        
        return label
    }()
    let sortedBy: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.text = "Ordenado por: Nota"
        
        return label
    }()
    let filterButton: UIButton = {
        let button = UIButton()
        
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
        self.tableView.reloadData()
        
        self.view.backgroundColor = .systemGray6
        
        for view in self.view.subviews {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        generateConstraints()
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: BreweryTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: BreweryTableViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
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

extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BreweryTableViewCell.identifier, for: indexPath) as! BreweryTableViewCell
        
        let filterBreweries = FilterBreweries()
        let breweries = filterBreweries.filter(results: breweryDefaultModel)
        
        cell.configureCell(with: breweries[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        breweryDefaultModel.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            let id = self.breweryDefaultModel[indexPath.row].id ?? ""
            delegate?.navigateToDetails(id: "/\(id)")
        }
}

