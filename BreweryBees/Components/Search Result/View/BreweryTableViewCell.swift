//
//  BreweryTableViewCell.swift
//  BreweryBees
//
//  Created by Francisca Elisa Carvalho Rosa on 01/02/22.
//

import UIKit
import SDWebImage
import RealmSwift

class BreweryTableViewCell: UITableViewCell {
    
    static let identifier = "BreweryTableViewCell"
    public var breweryModel = BreweryDefaultModel()
    
    @IBOutlet weak var imageBrew: UIImageView!
    @IBOutlet weak var nameBrew: UILabel!
    @IBOutlet weak var ratingBrew: UILabel!
    @IBOutlet weak var typeBrew: UILabel!
    @IBOutlet weak var distanceCircleMark: UIImageView!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var isFavoriteButton: UIButton!
    
    @IBOutlet weak var backgroundViewCell: UIView!
    
    let realm = try! Realm()
    let searchResultViewModel: SearchResultViewModel = BreweryContainer.shared.resolve(SearchResultViewModel.self)!
    
    fileprivate func changeImageState() {
        isFavoriteButton.setImage(UIImage(systemName: breweryModel.isFavorite ?? false ? "suit.heart.fill" : "suit.heart"), for: .normal)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        distance.isHidden = true
        distanceCircleMark.isHidden = true
        
        changeImageState()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageBrew.layer.cornerRadius = imageBrew.frame.height / 2
    }
    
    @IBAction func shareButton(_ sender: Any) {
       //to implement share action
    }
    
    var searchResultViewController = SearchResultViewController()
    
    @IBAction func favoriteButton(_ sender: Any) {
        
        guard let isFavorite = breweryModel.isFavorite else { return }
        
        if isFavorite {
            breweryModel.isFavorite = false
            guard let id = breweryModel.id else { return }
            searchResultViewModel.removeFavorite(id: id) {
                 deleteResult in
                 if deleteResult {
                   self.isFavoriteButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
                 }
               }
        } else {
            breweryModel.isFavorite = true
            
            searchResultViewModel.addFavorite(breweryDefaultModel: breweryModel) { saveResult in
                if saveResult {
                    self.isFavoriteButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
                }
            }
        }
    }
    
    func configureCell(with breweryDefaultModel: BreweryDefaultModel) {//model of data
        self.breweryModel = breweryDefaultModel
        changeImageState()
        
        nameBrew.text = breweryModel.name
        guard let rating = breweryModel.average else { return }
        ratingBrew.text = "\(String(describing: rating))"
        typeBrew.text = breweryModel.brewery_type
        
        let givenString = breweryModel.name ?? ""
        if var firstChar = givenString.first{
            firstChar = Character(firstChar.lowercased())
            if breweryModel.photos?[0] != nil {
                imageBrew.sd_setImage(with: URL(string: breweryModel.photos?[0] ?? ""))
            } else {
                imageBrew.image = UIImage(systemName: "\(firstChar).circle")
            }
        }
    }
}
