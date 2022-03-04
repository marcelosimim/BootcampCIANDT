//
//  galeryDetailCell.swift
//  BreweryBees
//
//  Created by FELIPE AUGUSTO SILVA on 03/02/22.
//

import UIKit

class galeryDetailCell: UICollectionViewCell {
    
        static let identifier = "cell"
        
       lazy var feedImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "house")
           imageView.translatesAutoresizingMaskIntoConstraints = false
           imageView.contentMode = .scaleToFill
            return imageView
        }()
        
        override init(frame: CGRect)  {
            super.init(frame: frame)
            
            contentView.addSubview(feedImageView)
        
            layoutConfig()
        }
        required init?(coder: NSCoder) {
            fatalError("error")
        }
        
        private func layoutConfig() {
            
            
            
            NSLayoutConstraint.activate([
                feedImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                feedImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
                feedImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
                feedImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            ])
        }


        }
