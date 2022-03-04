//
//  EvaluatedTableViewCell.swift
//  BreweryBees
//
//  Created by Marcelo Simim Santos on 28/02/22.
//

import UIKit
import Cosmos

class EvaluatedTableViewCell: UITableViewCell {
    
    static let identifier = "EvaluatedTableViewCell"
    public var breweryModel = BreweryDefaultModel()
    
    lazy var view:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var imageIcon: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "Vector-1")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(red: 1, green: 0.839, blue: 0.039, alpha: 1)
        imageView.backgroundColor = UIColor(red: 1, green: 0.8, blue: 0, alpha: 0.16)
        imageView.layer.borderWidth = 1.0
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var ratingLabel: UILabel  = {
        let label = UILabel()
         label.font = UIFont.systemFont(ofSize: 14)
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    lazy var cosmosView: CosmosView = {
        var view = CosmosView()
        view.isUserInteractionEnabled = false
        view.settings.starSize = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        view.settings.filledImage?.value(forKey: "5")
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        settingLayout()
        settingConstraints()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func settingLayout(){
        view.backgroundColor = UIColor.white
        backgroundColor = UIColor.clear
        addSubview(view)
        addSubview(imageIcon)
        addSubview(titleLabel)
        addSubview(ratingLabel)
        addSubview(cosmosView)
        view.layer.cornerRadius = 8
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.2
//        backgroundColor = UIColor.purple
    }
    
    func settingConstraints(){
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            
            imageIcon.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            imageIcon.heightAnchor.constraint(equalToConstant: 48),
            imageIcon.widthAnchor.constraint(equalToConstant: 48),
            
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: imageIcon.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            ratingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            ratingLabel.leadingAnchor.constraint(equalTo: imageIcon.trailingAnchor, constant: 8),
            
            cosmosView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            cosmosView.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor, constant: 5),
        ])
    }
    
    func configureCell(with model: BreweryDefaultModel){
        let name = model.name ?? ""
        if var firstChar = name.first{
            firstChar = Character(firstChar.lowercased())
            let image = UIImage(systemName: "\(firstChar).circle")
            imageIcon.image = image
        }
        titleLabel.text = model.name
        ratingLabel.text = "\(model.average ?? 0)"
        cosmosView.rating = model.average ?? 0
    }
}
