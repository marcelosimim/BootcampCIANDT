//
//  BrewryDetailVC.swift
//  BreweryBees
//
//  Created by FELIPE AUGUSTO SILVA on 03/02/22.
//


import UIKit
import Cosmos
import TinyConstraints
import SDWebImage

class BrewryDetailVC: UIViewController {

    
//    MARK: DEFINING VAR AND CALLING CONTAINER RESOLVErR
    public var Brew: BreweryDetailViewModel = BreweryContainer.shared.resolve(BreweryDetailViewModel.self)!

    static var brewAddress: String = "Avenida Paulista, 1010"
    static var isFavorite: Bool = false
    static var brewAvaliation: String = "400"
    var brewID: String = " "
    var BrewImages: [String] = []
    
    let grayBackground = UIColor(red: 0.949, green: 0.949, blue: 0.9686, alpha: 1.0)
    
  
    
    lazy var cosmosView: CosmosView = {
        var view = CosmosView()
        view.settings.updateOnTouch = false
        view.settings.starSize = 15
        view.rating = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.settings.filledImage?.value(forKey: "5")
        return view
    }()
    
    let rating: UILabel = {
      let label = UILabel()
        label.text = "2.0"
        
        label.font = UIFont.systemFont(ofSize: 14,  weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let backgroundView: UIImageView = {
        let image = UIImage(named: "TopYellowBackground")
        let imageView = UIImageView(image: image!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
        
    }()

    var BrewryTitle: UILabel = {
      let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 16,  weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    var BrewryRoundedLogo: UIImageView = {
        let imageView = UIImageView()
       imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "person.circle")
       imageView.contentMode = .scaleToFill
       imageView.clipsToBounds = true
        imageView.layer.opacity = 0.3
       imageView.backgroundColor = .yellow
       imageView.layer.masksToBounds = true
       imageView.layer.cornerRadius = 20
        return imageView
    }()
      
    let BrewryType: UILabel = {
      let label = UILabel()
        label.text = "Tipo"
        label.font = UIFont.systemFont(ofSize: 14,  weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    var BrewryNetworkIcon: UIImageView = {
        let imageView = UIImageView()
       imageView.image = UIImage(systemName: "network")
       imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black

        return imageView
    }()
    
    let breweryWebsite: UILabel = {
      let label = UILabel()
        label.text = "www.cervejariaa.com.br"
        label.font = UIFont.systemFont(ofSize: 14,  weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let reviewQtdy: UILabel = {
      let label = UILabel()
        label.text = brewAvaliation
        label.font = UIFont.systemFont(ofSize: 14,  weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let BrewryAddressLabel: UILabel = {
      let label = UILabel()
        label.text = brewAddress
        label.font = UIFont.systemFont(ofSize: 14,  weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    var BrewryLocationIcon: UIImageView = {
        let imageView = UIImageView()
       imageView.image = UIImage(systemName: "location.north.circle.fill")
       imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black

        return imageView
    }()
    
    
    let separetorLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(red: 0.8471, green: 0.8471, blue: 0.8471, alpha: 1.0)
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    let separetorLast: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(red: 0.8471, green: 0.8471, blue: 0.8471, alpha: 1.0)
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    let secondSeparetorLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(red: 0.8471, green: 0.8471, blue: 0.8471, alpha: 1.0)
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    
    let thirdSeparetorLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(red: 0.8471, green: 0.8471, blue: 0.8471, alpha: 1.0)
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    let addPhotoButton: UIButton = {
       let button = UIButton()
        button.setTitle("ADICIONAR FOTO", for: .normal)
        button.layer.borderWidth = 1
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    let rateButton: UIButton = {
       let button = UIButton()
        button.setTitle("AVALIAR CERVEJARIA", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(named: "yellow")
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(presentRating), for: .touchUpInside)
        return button
    }()
    
    
    let fakeData = ["noBackground","noBackground","noBackground", "noBackground","noBackground","noBackground",]
    
    
//    let collectionView: UICollectionView?

    fileprivate let galeryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
//        layout.minimumLineSpacing = 50
//        layout.minimumInteritemSpacing = 100
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(galeryDetailCell.self, forCellWithReuseIdentifier: galeryDetailCell.identifier)
        return cv
    }()
    
    let pageControll: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 4
        pc.pageIndicatorTintColor = .gray
        pc.currentPageIndicatorTintColor = .black
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()
    
    let Brewrygalery: UILabel = {
      let label = UILabel()
        label.text = "Galeria"
        label.font = UIFont.systemFont(ofSize: 14,  weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var shareIcon: UIImageView = {
        let imageView = UIImageView()
       imageView.image = UIImage(systemName: "square.and.arrow.up.circle")
       imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black

        return imageView
    }()
    
    
    var favoriteIcon: UIImageView = {
        let imageView = UIImageView()
       imageView.image = UIImage(systemName: "heart")
       imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black

        return imageView
    }()
    

    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = grayBackground
        loader.startAnimating()
        
        galeryCollectionView.dataSource = self
        galeryCollectionView.delegate = self
        ConfigLayoutConstraits()

        loader.startAnimating()
        Brew.fetchDetails(id: brewID)
        
        Brew.onShowDetail = {
            DispatchQueue.main.async {
      
                let detail = self.Brew
                self.BrewryTitle.text = detail.name
                self.breweryWebsite.text = detail.website_url
                self.BrewryAddressLabel.text = detail.street
                self.cosmosView.rating = detail.avarage
                self.reviewQtdy.text = detail.size_evaluations
                self.loader.stopAnimating()
                self.BrewImages = detail.photos
                self.galeryCollectionView.reloadData()
                self.Brewrygalery.text = "Galeria \(self.BrewImages.count)"
                self.rating.text = String(detail.avarage)
                self.BrewryType.text = detail.type
                
                print("detail.type", detail.type)
            }
            
        }

    }

//    MARK: Rate
    
    @objc func presentRating() {
        print("test")
        let rating = RateBrewry()
        rating.BrewName = self.Brew.name
        rating.BrewID = self.Brew.id
        if let rating = rating.sheetPresentationController {
            rating.detents = [.medium()]
        }
        present(rating, animated: true, completion: nil)

    }
    
    func ConfigLayoutConstraits() {

//        Stack Parent
        let stackView = UIView()
        view.addSubview(stackView)
        stackView.addSubview(backgroundView)
        
        
//        White Container
        let detailsModal = UIStackView(arrangedSubviews: [BrewryTitle])
        
        
        detailsModal.layer.cornerRadius = 20
        view.addSubview(detailsModal)
        
        
//        Stack view with holding informations
        let InfoStackView = UIStackView(arrangedSubviews: [BrewryRoundedLogo, BrewryTitle, rating,  cosmosView ])
        InfoStackView.addSubview(BrewryType)
        InfoStackView.addSubview(reviewQtdy)
        detailsModal.addSubview(InfoStackView)

        detailsModal.addSubview(separetorLine)
        let broserSV = UIStackView(arrangedSubviews:
        [BrewryNetworkIcon,  breweryWebsite])
        broserSV.spacing = 10

        
        let AddressStack = UIStackView(arrangedSubviews: [BrewryLocationIcon, BrewryAddressLabel])
        AddressStack.spacing = 10

        detailsModal.addSubview(AddressStack)
        detailsModal.addSubview(broserSV)
        detailsModal.addSubview(secondSeparetorLine)
        detailsModal.backgroundColor = .white
      
        
        let galeryStackView = UIView()
        
        let buttonStackView = UIStackView(arrangedSubviews:
        [addPhotoButton, rateButton])
        
        let shareStackView = UIView()
        shareStackView.addSubview(separetorLast)
        
        shareStackView.addSubview(favoriteIcon)
        shareStackView.addSubview(shareIcon)
        detailsModal.addSubview(shareStackView)
        
        
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 2
        
        
        galeryStackView.addSubview(galeryCollectionView)


//        galeryStackView.axis = .horizontal
        galeryStackView.addSubview(Brewrygalery)
        
        
        detailsModal.addSubview(pageControll)
        detailsModal.addSubview(buttonStackView)
        
        
        detailsModal.addSubview(galeryStackView)
 
        shareStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        broserSV.translatesAutoresizingMaskIntoConstraints = false
        galeryStackView.translatesAutoresizingMaskIntoConstraints = false
        AddressStack.translatesAutoresizingMaskIntoConstraints = false
        detailsModal.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        InfoStackView.translatesAutoresizingMaskIntoConstraints = false
        rateButton.translatesAutoresizingMaskIntoConstraints = false
     
//        Constraints for the top items
        NSLayoutConstraint.activate([
        
//            BackgroundImage
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            
            
//            Detail StackView
            
            detailsModal.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            detailsModal.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            detailsModal.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            detailsModal.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.9),
            
//            INFO STACK VIEW INFORMATIONS
            BrewryRoundedLogo.topAnchor.constraint(equalTo: detailsModal.topAnchor, constant: 15),
            BrewryRoundedLogo.heightAnchor.constraint(equalToConstant: 50),
            BrewryRoundedLogo.widthAnchor.constraint(equalToConstant: 50),
            BrewryRoundedLogo.leftAnchor.constraint(equalTo: detailsModal.leftAnchor, constant: 15),
            
//            brewry title
            
            BrewryTitle.leftAnchor.constraint(equalTo: BrewryRoundedLogo.rightAnchor, constant: 15),
            BrewryTitle.topAnchor.constraint(equalTo: detailsModal.topAnchor, constant: 4),
            
//            TYPE
            
            BrewryType.topAnchor.constraint(equalTo: BrewryTitle.bottomAnchor, constant: -15),
            BrewryType.leftAnchor.constraint(equalTo: BrewryRoundedLogo.rightAnchor, constant: 15),
            
//            Star rating
            
            cosmosView.topAnchor.constraint(equalTo: detailsModal.topAnchor, constant: 25),
            cosmosView.rightAnchor.constraint(equalTo: detailsModal.rightAnchor, constant: -5),
            cosmosView.widthAnchor.constraint(equalToConstant: 100),
            
            rating.rightAnchor.constraint(equalTo: cosmosView.leftAnchor, constant: -5),
            rating.widthAnchor.constraint(equalToConstant: 24),
            rating.topAnchor.constraint(equalTo: detailsModal.topAnchor),
            
            reviewQtdy.rightAnchor.constraint(equalTo: detailsModal.rightAnchor, constant: -15),
            reviewQtdy.topAnchor.constraint(equalTo: cosmosView.bottomAnchor, constant: -15),
            
            
//            website
            
//            website Icon
 
            broserSV.leftAnchor.constraint(equalTo: detailsModal.leftAnchor, constant: 20),
            BrewryNetworkIcon.heightAnchor.constraint(equalToConstant: 20),
            BrewryNetworkIcon.widthAnchor.constraint(equalToConstant: 20),
            
            breweryWebsite.topAnchor.constraint(equalTo: BrewryType.bottomAnchor, constant: 16),

            breweryWebsite.widthAnchor.constraint(equalToConstant: 250),
            
            
            separetorLine.rightAnchor.constraint(equalTo: detailsModal.rightAnchor, constant: -15),
            separetorLine.leftAnchor.constraint(equalTo: detailsModal.leftAnchor, constant: 15),
            separetorLine.heightAnchor.constraint(equalToConstant: 1),
            separetorLine.topAnchor.constraint(equalTo: breweryWebsite.bottomAnchor, constant: 20)
            
        ])
        
        
//        Address Contraints
        
        NSLayoutConstraint.activate([
            
            AddressStack.topAnchor.constraint(equalTo: separetorLine.bottomAnchor, constant: 20),
            AddressStack.rightAnchor.constraint(equalTo: detailsModal.rightAnchor, constant: -20),
            AddressStack.leftAnchor.constraint(equalTo: detailsModal.leftAnchor, constant: 20),
            
//            ICON
            

            BrewryLocationIcon.heightAnchor.constraint(equalToConstant: 20),
            BrewryLocationIcon.widthAnchor.constraint(equalToConstant: 20),
            
            secondSeparetorLine.topAnchor.constraint(equalTo: AddressStack.bottomAnchor, constant: 25),
            secondSeparetorLine.leftAnchor.constraint(equalTo: detailsModal.leftAnchor, constant: 20),
            secondSeparetorLine.rightAnchor.constraint(equalTo: detailsModal.rightAnchor, constant: -20),
            secondSeparetorLine.heightAnchor.constraint(equalToConstant: 1),
        ])
        
        
//        Contetnt View CONTRAINSTS
        
        NSLayoutConstraint.activate([
            galeryStackView.topAnchor.constraint(equalTo: secondSeparetorLine.bottomAnchor, constant: 20),
            galeryStackView.rightAnchor.constraint(equalTo: detailsModal.rightAnchor),
            galeryStackView.leftAnchor.constraint(equalTo: detailsModal.leftAnchor),
            galeryStackView.heightAnchor.constraint(equalToConstant: 130),
            
            
            galeryCollectionView.topAnchor.constraint(equalTo: Brewrygalery.bottomAnchor),
            galeryCollectionView.leftAnchor.constraint(equalTo: galeryStackView.leftAnchor, constant: 15),
            galeryCollectionView.rightAnchor.constraint(equalTo: galeryStackView.rightAnchor, constant: -15),
            galeryCollectionView.heightAnchor.constraint(equalToConstant: 130),
            
            
            Brewrygalery.topAnchor.constraint(equalTo: galeryStackView.topAnchor),
            Brewrygalery.leftAnchor.constraint(equalTo: galeryStackView.leftAnchor, constant: 15),
            
            
//            MARK: Page Control
            
            pageControll.topAnchor.constraint(equalTo: galeryStackView.bottomAnchor, constant: 10),
            pageControll.centerXAnchor.constraint(equalTo: detailsModal.centerXAnchor),
            pageControll.heightAnchor.constraint(equalToConstant: 30)
        ])
    
//    MARK: BUTTON CONSTRAINTS
        
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: pageControll.bottomAnchor, constant: 5),
            buttonStackView.leftAnchor.constraint(equalTo: detailsModal.leftAnchor, constant: 20),
            buttonStackView.rightAnchor.constraint(equalTo: detailsModal.rightAnchor, constant: -20),
            buttonStackView.heightAnchor.constraint(equalTo: detailsModal.widthAnchor, multiplier: 0.3),
            
            addPhotoButton.heightAnchor.constraint(equalTo: buttonStackView.heightAnchor, multiplier: 0.4),
            addPhotoButton.topAnchor.constraint(equalTo: buttonStackView.topAnchor),
            rateButton.heightAnchor.constraint(equalTo: buttonStackView.heightAnchor, multiplier: 0.4),
            rateButton.topAnchor.constraint(equalTo: addPhotoButton.bottomAnchor),
            rateButton.bottomAnchor.constraint(equalTo: buttonStackView.bottomAnchor),
            
            
        ])
        
        NSLayoutConstraint.activate([
            shareStackView.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor),
            shareStackView.leftAnchor.constraint(equalTo: detailsModal.leftAnchor, constant: 15),
            shareStackView.bottomAnchor.constraint(equalTo: detailsModal.bottomAnchor),
            shareStackView.rightAnchor.constraint(equalTo: detailsModal.rightAnchor, constant: -15),
            
            separetorLast.rightAnchor.constraint(equalTo: shareStackView.rightAnchor),
            separetorLast.bottomAnchor.constraint(equalTo: favoriteIcon.topAnchor, constant: -10),
            separetorLast.leftAnchor.constraint(equalTo: shareStackView.leftAnchor),
            separetorLast.heightAnchor.constraint(equalToConstant: 1),
            
            favoriteIcon.rightAnchor.constraint(equalTo: shareStackView.rightAnchor, constant: -5),
            favoriteIcon.heightAnchor.constraint(equalToConstant: 25),
            favoriteIcon.widthAnchor.constraint(equalToConstant: 25),
            favoriteIcon.bottomAnchor.constraint(equalTo: shareStackView.bottomAnchor, constant: -5),
            
            shareIcon.rightAnchor.constraint(equalTo: favoriteIcon.leftAnchor, constant: -5),
            shareIcon.heightAnchor.constraint(equalToConstant: 25),
            shareIcon.widthAnchor.constraint(equalToConstant: 25),
            shareIcon.bottomAnchor.constraint(equalTo: shareStackView.bottomAnchor, constant: -5),
            
        ])
    }
}

extension BrewryDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: galeryCollectionView.frame.width/3, height: galeryCollectionView.frame.height/1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return BrewImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = galeryCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! galeryDetailCell

        cell.feedImageView.sd_setImage(with: URL(string: self.BrewImages[indexPath.row]), placeholderImage: UIImage(named: "Vector-1"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("item clicked \(indexPath)")
    }
    
}



