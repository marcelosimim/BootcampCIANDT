//
//  EvaluatedNotFoundedViewController.swift
//  BreweryBees
//
//  Created by Marcelo Simim Santos on 28/02/22.
//

import UIKit

class EvaluatedNotFoundedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        settingSubviews()
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
        label.text = "Nenhuma cervejaria avaliada"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
       let label = UILabel()
        label.text = "Você ainda não avaliou nenhuma cervejaria. Suas cervejarias avaliadas aparecerão aqui."
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func settingSubviews(){
        view.addSubview(headerView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
    }
    
    // MARK: - Setting constraits
    
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
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: viewHeight*12),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: viewWidth*16),
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}
