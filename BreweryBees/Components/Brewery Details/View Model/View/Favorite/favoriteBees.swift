import UIKit

class FavoriteBees: ViewController {
    
    private enum Constants {
        static let navigationBarFavoriteTitle = "favorite.title.navigationBar"
        static let noAddedFavoriteTitle = "favorite.title.noFavoriteAdded"
        static let noAddedFavoriteDescription = "favorite.description.noFavoriteAdded"
        static let favoriteAddedTitle = "favorite.title.added"
        static let favoriteBreweryResultOne = "favorite.breweryResult"
        static let favoriteOrderBy = "favorite.orderBy"
        static let favoritePopUpRemoveTitle = "favorite.removePopUp.title"
        static let favoritePopUpRemoveDescription = "favorite.removePopUp.description"
        static let favoritePopUpCancelButton = "favorite.removePopUp.cancelButton"
        static let favoritePopUpConfirmButton = "favorite.removePopUp.confirmButton"
    }
    
    let yourBackImage = UIImage(named: "Arrow")
    
    lazy var favoriteBreweryTableViewController: FavoriteBreweryTableViewController = {
       let favorite = FavoriteBreweryTableViewController()
        
        return favorite
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        favoriteBackgroundComponent()
        view.addSubview(favoriteBreweryTableViewController.view)
        favoriteBreweryTableViewController.view.isHidden = true
        
        if 1 == 1 {
            favoriteAddedView()
        } else {
            noFavoritiesAddedView()
        }
    }

    private func favoriteAddedView() {
        favoriteBreweryTableViewController.view.isHidden = false
    }
    
    private func noFavoritiesAddedView() {
        let notFoundBrewery: UILabel = {
            let text = UILabel()
            let valueText = NSMutableAttributedString(string: Constants.noAddedFavoriteTitle.localized, attributes: [NSMutableAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)])
            
            text.translatesAutoresizingMaskIntoConstraints = false
            text.attributedText = valueText
            text.numberOfLines = 2
            text.textAlignment = .center
            
            return text
        }()
        
        let notFoundFavorite: UILabel = {
            let text = UILabel()
            let valueText = NSMutableAttributedString(string: Constants.noAddedFavoriteDescription.localized, attributes: [NSMutableAttributedString.Key.font : UIFont.systemFont(ofSize: 20)])
            
            
            text.translatesAutoresizingMaskIntoConstraints = false
            text.attributedText = valueText
            text.numberOfLines = 4
            text.textAlignment = .center
            
            return text
        }()
        
        view.addSubview(notFoundBrewery)
        view.addSubview(notFoundFavorite)
        
        NSLayoutConstraint.activate([
            notFoundBrewery.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            notFoundBrewery.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            notFoundBrewery.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            notFoundBrewery.leadingAnchor.constraint(equalTo: view.leadingAnchor),

            notFoundFavorite.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            notFoundFavorite.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            notFoundFavorite.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            notFoundFavorite.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
        ])
    }
}

extension FavoriteBees {
    func favoriteBackgroundComponent() {
        background.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(background)
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
