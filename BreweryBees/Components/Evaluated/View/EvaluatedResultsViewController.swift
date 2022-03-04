//
//  EvaluatedResultsViewController.swift
//  BreweryBees
//
//  Created by Marcelo Simim Santos on 28/02/22.
//

import UIKit

class EvaluatedResultsViewController: UIViewController {
    
    static let identifier = "EvaluatedTableViewCell"
    let evaluatedViewModel = BreweryContainer.shared.resolve(EvaluatedViewModel.self)!
    var breweriesRated:[BreweryDefaultModel] = []
    var sortByName = true

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.969, alpha: 1)
        settingLayout()
        settingConstraints()
    }
    
    lazy var headerView: UIImageView  = {
        let view = UIImageView()
        view.image = UIImage(named: "bgYellow")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Cervejarias que você avaliou"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var resultsLabel: UILabel = {
       let label = UILabel()
        label.text = "\(breweriesRated.count) resultados"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var sortLabel: UILabel = {
       let label = UILabel()
        label.text = "Ordenar por: Nota"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let filterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.init(systemName: "text.append"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(filterClicked), for: .touchDown)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var tableView: UITableView = {
       let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EvaluatedTableViewCell.self, forCellReuseIdentifier: "\(EvaluatedTableViewCell.identifier)")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var orderView: UIImageView  = {
        let view = UIImageView()
        view.image = UIImage(named: "whiteview")
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var sortBylabel: UILabel = {
        let label = UILabel()
         label.text = "Ordenar por"
        label.isHidden = true
         label.font = UIFont.systemFont(ofSize: 16)
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.isHidden = true
        button.tintColor = .black
        button.addTarget(self, action: #selector(closeClicked), for: .touchDown)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var nameTitle: UILabel = {
        let label = UILabel()
         label.text = "Nome (A a Z)"
        label.isHidden = true
         label.font = UIFont.systemFont(ofSize: 14)
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    
    lazy var averageTitle: UILabel = {
        let label = UILabel()
         label.text = "Nota (maior para menor)"
        label.isHidden = true
         label.font = UIFont.systemFont(ofSize: 14)
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    
    lazy var nameButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.isHidden = true
        button.tintColor = .black
        button.addTarget(self, action: #selector(nameClicked), for: .touchDown)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var averageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "circle.circle.fill"), for: .normal)
        button.isHidden = true
        button.tintColor = .black
        button.addTarget(self, action: #selector(averageClicked), for: .touchDown)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func settingLayout(){
        view.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.969, alpha: 1)
        view.addSubview(headerView)
        view.addSubview(titleLabel)
        view.addSubview(resultsLabel)
        view.addSubview(sortLabel)
        view.addSubview(filterButton)
        view.addSubview(tableView)
        view.addSubview(orderView)
        view.addSubview(sortBylabel)
        view.addSubview(closeButton)
        view.addSubview(nameTitle)
        view.addSubview(averageTitle)
        view.addSubview(nameButton)
        view.addSubview(averageButton)
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 8
    }
    
    func settingConstraints(){
        let viewHeight:CGFloat = view.bounds.height/640.0
        let viewWidth:CGFloat = view.bounds.width/360.0
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 200),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: viewHeight*16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: viewWidth*16),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultsLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: viewHeight*20),
            resultsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: viewWidth*16),
            resultsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sortLabel.topAnchor.constraint(equalTo: resultsLabel.topAnchor, constant: viewHeight*30),
            sortLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: viewWidth*16),
            sortLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            filterButton.topAnchor.constraint(equalTo: resultsLabel.topAnchor, constant: viewHeight*30),
            filterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: viewWidth*18*(-1)),
            tableView.topAnchor.constraint(equalTo: sortLabel.bottomAnchor, constant: viewHeight*12),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            orderView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            orderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            orderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            orderView.heightAnchor.constraint(equalToConstant: viewHeight*144),
            sortBylabel.centerXAnchor.constraint(equalTo: orderView.centerXAnchor),
            sortBylabel.topAnchor.constraint(equalTo: orderView.topAnchor, constant: viewHeight*16),
            closeButton.centerYAnchor.constraint(equalTo: sortBylabel.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: viewWidth*21*(-1)),
            nameTitle.topAnchor.constraint(equalTo: orderView.topAnchor, constant: viewHeight*72),
            nameTitle.leadingAnchor.constraint(equalTo: orderView.leadingAnchor, constant: viewWidth*12),
            averageTitle.topAnchor.constraint(equalTo: orderView.topAnchor, constant: viewHeight*108),
            averageTitle.leadingAnchor.constraint(equalTo: orderView.leadingAnchor, constant: viewWidth*12),
            nameButton.topAnchor.constraint(equalTo: nameTitle.topAnchor),
            nameButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: viewWidth*10*(-1)),
            averageButton.topAnchor.constraint(equalTo: averageTitle.topAnchor),
            averageButton.trailingAnchor.constraint(equalTo: nameButton.trailingAnchor),
        ])
    }
    
    @objc func filterClicked() {
        setOrderView(false)
    }
    
    @objc func closeClicked() {
       setOrderView(true)
    }
    
    @objc func nameClicked() {
        sortLabel.text = "Ordenar por: Nome"
        nameButton.setImage(UIImage(systemName: "circle.circle.fill"), for: .normal)
        averageButton.setImage(UIImage(systemName: "circle"), for: .normal)
        breweriesRated = breweriesRated.sorted(by: { return $0.name! < $1.name! })
        tableView.reloadData()
    }
    
    @objc func averageClicked() {
        sortLabel.text = "Ordenar por: Nota"
        averageButton.setImage(UIImage(systemName: "circle.circle.fill"), for: .normal)
        nameButton.setImage(UIImage(systemName: "circle"), for: .normal)
        breweriesRated = breweriesRated.sorted(by: { return $0.average! > $1.average! })
        tableView.reloadData()
    }
    
    func setOrderView(_ bool:Bool){
        orderView.isHidden = bool
        sortBylabel.isHidden = bool
        closeButton.isHidden = bool
        nameTitle.isHidden = bool
        averageTitle.isHidden = bool
        nameButton.isHidden = bool
        averageButton.isHidden = bool
    }
}

extension EvaluatedResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        resultsLabel.text = "\(breweriesRated.count) resultados"
        return breweriesRated.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EvaluatedTableViewCell.identifier, for: indexPath) as! EvaluatedTableViewCell
        cell.configureCell(with: (breweriesRated[indexPath.row]))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            
//            let storyboard = UIStoryboard(name: "Main", bundle:nil)
//            let navController = storyboard.instantiateViewController(withIdentifier: "nav") as! UINavigationController
//            let id = self.breweriesRated[indexPath.row].id ?? ""
//
//            let newController = BrewryDetailVC()
//            let detailsVC = storyboard.instantiateViewController(withIdentifier: "detail") as? BrewryDetailVC
//            detailsVC?.brewID = id
//            navController.pushViewController(detailsVC!, animated: true)
        }
}
