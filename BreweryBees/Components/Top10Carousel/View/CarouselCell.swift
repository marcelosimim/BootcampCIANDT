//
//  CarouselCell.swift
//  BreweryBees
//
//  Created by Marcelo Simim Santos on 01/02/22.
//

import UIKit

public class CarouselCell: UICollectionViewCell {
    
    static let identifier = "\(CarouselCell.self)"
    
    public var slide : CarouselSlide? {
        didSet {
            guard let slide = slide else {
                return
            }
            parseData(forSlide: slide)
        }
    }
    
    public lazy var imageArea : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        return imageView
    }()
    
    public var titleLabel : UILabel = {
        let label = UILabel()
        
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var starImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = UIColor(red: 255/255, green: 214/255, blue: 10/255, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    public var scoreLabel : UILabel = {
        let label = UILabel()
        
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    public var typeLabel : UILabel = {
        let label = UILabel()
        
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    public var distanceLabel : UILabel = {
        let label = UILabel()
        
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var infoView: UIView = {
        let view = UIView()
        view.addSubview(titleLabel)
        view.addSubview(scoreStack)
        view.addSubview(typeLabel)
        view.addSubview(distanceLabel)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var scoreStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [starImageView, scoreLabel])
      
        stack.axis = .horizontal
        stack.spacing = 5
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageArea, infoView])
        stack.layer.cornerRadius = 20
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    // MARK: - Configuration Methods
    private func setup() {
        backgroundColor = .white
        layer.cornerRadius = 20
        contentView.layer.cornerRadius = 20
        contentView.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentStack.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),

            imageArea.heightAnchor.constraint(equalTo: contentStack.heightAnchor, multiplier: 0.6),
            imageArea.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor),
            imageArea.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor),
            
            infoView.topAnchor.constraint(equalTo: imageArea.bottomAnchor),
            infoView.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor, constant: 8),
            infoView.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor),

            titleLabel.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor),
            
            scoreStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            scoreStack.leadingAnchor.constraint(equalTo: infoView.leadingAnchor),
            scoreStack.trailingAnchor.constraint(equalTo: infoView.trailingAnchor),
            
            starImageView.widthAnchor.constraint(equalToConstant: (starImageView.image?.size.width)!),
            
            typeLabel.topAnchor.constraint(equalTo: scoreStack.bottomAnchor, constant: 12),
            typeLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 2),
            typeLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor),
            
            distanceLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 12),
            distanceLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 2),
            distanceLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor),
        ])
    }
    
    private func parseData(forSlide slide: CarouselSlide) {
        imageArea.image = slide.image
        titleLabel.text = slide.title
        scoreLabel.text = slide.score
        typeLabel.text = slide.type
        distanceLabel.text = slide.distance
    }
}
