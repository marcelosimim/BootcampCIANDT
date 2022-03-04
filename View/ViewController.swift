import UIKit


class ViewController: UIViewController, UITextFieldDelegate, SearchResultDelegate {
    
    private var homeViewModel: HomeViewModel = BreweryContainer.shared.resolve(HomeViewModel.self)!
    
    
    func navigateToDetails(id: String) {
      
        let newController = BrewryDetailVC()

        let detailsVC = storyboard?.instantiateViewController(withIdentifier: "detail") as? BrewryDetailVC
        
        detailsVC?.brewID = id
        navigationController?.pushViewController(detailsVC!, animated: true)
    }
    
    private enum Constants {
        static let titleWelcomeText = "TitleWelcome"
        static let searchMyBrewery = "SerchMyBrewery"
        static let findMyLocation = "FindMyLocation"
        static let favoriteNavBarTitle = "favorite.navigationBar.title"
    }
    
    @IBAction func evaluatedClicked(_ sender: UIBarButtonItem) {
        let newController = EvaluatedViewController()
        self.navigationController?.pushViewController(newController, animated: true)
    }
   
    @IBAction func favoriteClick(_ sender: Any) {
        let favoriteController = FavoriteBees()
        let backItem = UIBarButtonItem()
        backItem.title = Constants.favoriteNavBarTitle.localized
        navigationItem.backBarButtonItem = backItem
        navigationController?.navigationBar.tintColor = UIColor(named: "YellowBees")
        navigationController?.pushViewController(favoriteController, animated: true)
    }
    
    public func navigationBrewery() {
        let brewryDetailVC = BrewryDetailVC()
        
        navigationController?.pushViewController(brewryDetailVC, animated: true)
    }
    
    var textField: UITextField = {
        let text = UITextField(frame: .zero)
        
        text.translatesAutoresizingMaskIntoConstraints = false
        text.placeholder = Constants.searchMyBrewery.localized
        text.textAlignment = .left
        text.font = UIFont(name: "", size: 16)
        text.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        text.borderStyle = .roundedRect
        text.leftViewMode = UITextField.ViewMode.always
        
        return text
    }()
    
    var topTenContainer = TopTenContainer()
    
    lazy var notFound: FindBreweryErrorViewController = {
        
        if let ntf = Bundle.main.loadNibNamed(FindBreweryErrorViewController.identifier, owner: self, options: nil)?.first as? FindBreweryErrorViewController {
            ntf.translatesAutoresizingMaskIntoConstraints = false
            return ntf
        }
        
            fatalError("FindBreweryErrorViewController not loaded")
    }()
   
    lazy var carousel : Carousel = {
        let carousel = Carousel()
        var slides: [CarouselSlide] = []
        for n in 1...7{
            slides.append(CarouselSlide(image: UIImage(systemName: "house")!, title: "Cervejaria \(n)", score: "5.0", type: "Tipo", distance: "1km"))
        }
        
        carousel.translatesAutoresizingMaskIntoConstraints = false
        carousel.slides = slides
               
        return carousel
       }()
    
    lazy var searchResultViewController: SearchResultViewController = {
        let search =  SearchResultViewController()
        
        search.view.translatesAutoresizingMaskIntoConstraints = false
        search.delegate = self
        
        return search
    }()
    
    lazy var topBrewery: UILabel = {
        let text = UILabel()
        
        text.text = "As 10 mais bem avaliadas:"
        text.font = UIFont(name: "Quicksand-Bold", size: 22)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.tintColor = .black
        
        return text
    }()
    
    lazy var background =  BackgroundView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "BreweryBees"
        bestLocation()
        
        homeViewModel.onshowResults = {
            if self.homeViewModel.searchResults.isEmpty == false {
                self.searchResultViewController.breweryDefaultModel = self.homeViewModel.searchResults
                self.sendToResults()
            }
        }
    }
    
    func sendToResults() {
        DispatchQueue.main.async {
            self.topBrewery.isHidden = true
            self.searchResultViewController.view.isHidden = false
            self.searchResultViewController.tableView.reloadData()
            let results = self.homeViewModel.searchResults.count
            self.searchResultViewController.numberOfResults.text = "\(self.homeViewModel.searchResults.count >= 1 ?  " \(results) resultados" : " \(results) resultado")"
        }
    }
    
    
    //    ADDING CHILD TO VIEWCONTROLLER
    
    func bestLocation() {
        view.addSubview(topTenContainer.view)
        addChild(topTenContainer)
        topTenContainer.view.addSubview(notFound)
        topTenContainer.view.addSubview(carousel)
        topTenContainer.view.addSubview(searchResultViewController.view)
        topTenContainer.view.addSubview(topBrewery)
        topBrewery.isHidden = false
        backgroundComponent()
        homeLayout()
        notFound.isHidden = true
        carousel.isHidden = false
        searchResultViewController.view.isHidden = true
        setConstraints()
        self.textField.delegate = self
        navigationController?.navigationBar.tintColor = UIColor(named: "YellowBees")
        view.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.969, alpha: 1)
    }
    
    // SETTING CONTRAINTS
    
    func setConstraints() {
        topTenContainer.didMove(toParent: self)
        topTenContainer.view.isHidden = false
        topTenContainer.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topTenContainer.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            topTenContainer.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topTenContainer.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topTenContainer.view.topAnchor.constraint(equalTo: background.bottomAnchor),
            topTenContainer.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            notFound.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            notFound.topAnchor.constraint(equalTo: background.bottomAnchor),
            notFound.heightAnchor.constraint(equalToConstant: 100),
            notFound.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            notFound.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.heightAnchor.constraint(equalToConstant: 200),
            carousel.topAnchor.constraint(equalTo: topBrewery.bottomAnchor, constant: 20),
            carousel.centerXAnchor.constraint(equalTo: topTenContainer.view.centerXAnchor),
            carousel.leadingAnchor.constraint(equalTo: topTenContainer.view.leadingAnchor, constant: 17),
            carousel.trailingAnchor.constraint(equalTo: topTenContainer.view.trailingAnchor, constant: -17),
            topBrewery.topAnchor.constraint(equalTo: topTenContainer.view.topAnchor, constant: 16),
            topBrewery.trailingAnchor.constraint(equalTo: topTenContainer.view.trailingAnchor),
            topBrewery.leadingAnchor.constraint(equalTo: topTenContainer.view.leadingAnchor, constant: 20),
            topBrewery.centerXAnchor.constraint(equalTo: topTenContainer.view.centerXAnchor),
            carousel.heightAnchor.constraint(equalToConstant: 200),
            searchResultViewController.view.centerXAnchor.constraint(equalTo: topTenContainer.view.centerXAnchor),
            searchResultViewController.view.topAnchor.constraint(equalTo: topTenContainer.view.topAnchor),
            searchResultViewController.view.trailingAnchor.constraint(equalTo: topTenContainer.view.trailingAnchor),
            searchResultViewController.view.bottomAnchor.constraint(equalTo: topTenContainer.view.bottomAnchor),
            searchResultViewController.view.leadingAnchor.constraint(equalTo: topTenContainer.view.leadingAnchor),
        ])
    }
    
    @objc func  textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let brewerySearchField = textField.text ?? ""
        
        if !brewerySearchField.isEmpty {
            homeViewModel.searchField(searchField: brewerySearchField
            ) {
                result in
                if !result {
                    DispatchQueue.main.async {
                        self.notFound.isHidden = false
                        self.searchResultViewController.view.isHidden = true
                        self.carousel.isHidden = true
                        self.topBrewery.isHidden = true
                        self.searchResultViewController.numberOfResults.text = "\(self.homeViewModel.searchResults.count)"
                    }
                }
            }
       
            textField.resignFirstResponder()
            
        }
        
//        notFound.isEmpty = !brewerySearchField
        
//        carousel.isHidden = true
//        topBrewery.isHidden = true
        return true
    }
}

extension ViewController {
    func homeLayout() {
        
        backgroundComponent()
        
        let welcomeText: UILabel = {
            let text = UILabel()

            text.text = Constants.titleWelcomeText.localized
            text.font = UIFont(name: "Quicksand-Bold", size: 22)
            text.translatesAutoresizingMaskIntoConstraints = false
            text.lineBreakMode = .byWordWrapping
            text.numberOfLines = 2
            
            return text
        }()
        
        let locationImg: UIImageView = {
            let img = UIImageView()
            
            img.translatesAutoresizingMaskIntoConstraints = false
            img.image = UIImage(named: "GPS")
            
            return img
        }()
        
        let locationText: UILabel = {
            let text = UILabel()
            text.text = Constants.findMyLocation.localized
            text.font = UIFont(name: "Quicksand-Bold", size: 16)
            text.translatesAutoresizingMaskIntoConstraints = false
            
            return text
        }()
        
        
        
        view.addSubview(welcomeText)
        view.addSubview(textField)
        view.addSubview(locationText)
        view.addSubview(locationImg)
        
        textField.leftImage( UIImage(named: "Search"), imageWidth: 22, padding: 10)
        
        NSLayoutConstraint.activate([
            
            //welcomeText
            
            welcomeText.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            welcomeText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            welcomeText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            // Search Bar
            
            textField.topAnchor.constraint(equalTo: welcomeText.bottomAnchor, constant: 15),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            textField.heightAnchor.constraint(equalToConstant: 48),
            
            //locationText
            
            locationText.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: 30),
            locationText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            locationText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            locationText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            
            //location Image
            
            locationImg.topAnchor.constraint(equalTo: locationText.topAnchor, constant: -3),
            locationImg.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
        ])
    }
}

extension ViewController {
func backgroundComponent() {
    background.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(background)
    NSLayoutConstraint.activate([
        background.topAnchor.constraint(equalTo: view.topAnchor),
        background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
    ])
    }
}
