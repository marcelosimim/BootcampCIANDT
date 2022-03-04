//
//  EvaluatedViewController.swift
//  BreweryBees
//
//  Created by Marcelo Simim Santos on 25/02/22.
//

import UIKit

class EvaluatedViewController: UIViewController, EvaluatedAuthDelegate {
    
    let evaluatedViewModel: EvaluatedViewModel = BreweryContainer.shared.resolve(EvaluatedViewModel.self)!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.969, alpha: 1)
        settingSubviews()
        settingConstraints()
    }
    
    let container = ContainerEvaluated()

    lazy var evaluatedAuth: EvaluatedAuthViewController = {
        let evaluatedAuth = EvaluatedAuthViewController()
        evaluatedAuth.delegate = self
        evaluatedAuth.view.translatesAutoresizingMaskIntoConstraints = false
        return evaluatedAuth
    }()
    
    lazy var evaluatedNotFounded: EvaluatedNotFoundedViewController = {
        let evaluatedNotFounded = EvaluatedNotFoundedViewController()
        evaluatedNotFounded.view.isHidden = true
        evaluatedNotFounded.view.translatesAutoresizingMaskIntoConstraints = false
        return evaluatedNotFounded
    }()
    
    lazy var evaluatedResults: EvaluatedResultsViewController = {
        let evaluatedResults = EvaluatedResultsViewController()
        evaluatedResults.view.isHidden = true
        evaluatedResults.view.translatesAutoresizingMaskIntoConstraints = false
        return evaluatedResults
    }()
    
    // MARK: - Setting Subviews
    
    func settingSubviews(){
        view.addSubview(container.view)
        addChild(container)
        container.view.addSubview(evaluatedAuth.view)
        container.view.addSubview(evaluatedNotFounded.view)
        container.view.addSubview(evaluatedResults.view)
    }
    
    // MARK: - Setting constraits
    
    func settingConstraints(){
        container.didMove(toParent: self)
        container.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.view.topAnchor.constraint(equalTo: view.topAnchor),
            container.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            container.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            evaluatedAuth.view.topAnchor.constraint(equalTo: container.view.topAnchor),
            evaluatedAuth.view.leadingAnchor.constraint(equalTo: container.view.leadingAnchor),
            evaluatedAuth.view.trailingAnchor.constraint(equalTo: container.view.trailingAnchor),
            evaluatedAuth.view.bottomAnchor.constraint(equalTo: container.view.bottomAnchor),
            evaluatedNotFounded.view.topAnchor.constraint(equalTo: container.view.topAnchor),
            evaluatedNotFounded.view.leadingAnchor.constraint(equalTo: container.view.leadingAnchor),
            evaluatedNotFounded.view.trailingAnchor.constraint(equalTo: container.view.trailingAnchor),
            evaluatedNotFounded.view.bottomAnchor.constraint(equalTo: container.view.bottomAnchor),
            evaluatedResults.view.topAnchor.constraint(equalTo: container.view.topAnchor),
            evaluatedResults.view.leadingAnchor.constraint(equalTo: container.view.leadingAnchor),
            evaluatedResults.view.trailingAnchor.constraint(equalTo: container.view.trailingAnchor),
            evaluatedResults.view.bottomAnchor.constraint(equalTo: container.view.bottomAnchor)
        ])
    }
    
    func getEvaluatedBreweries(email: String) {
        evaluatedAuth.view.isHidden = true
        evaluatedViewModel.getRatedBreweries(email: email)
        evaluatedViewModel.onShowResults = { hasData in
            DispatchQueue.main.async {
                self.evaluatedNotFounded.view.isHidden = hasData
                if hasData {
                    self.evaluatedResults.breweriesRated = self.evaluatedViewModel.breweriesRated!
                    self.evaluatedResults.view.isHidden = false
                    self.evaluatedResults.tableView.reloadData()
                }
            }
        }
    }
}

class ContainerEvaluated: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
