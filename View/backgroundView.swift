import UIKit

class BackgroundView: UIView {
    
    lazy var img: UIImageView = {
       let img = UIImageView()
       
       img.translatesAutoresizingMaskIntoConstraints = false
       img.image = UIImage(named: "bgYellow")
       
       return img
   }()
    
    func setupView() {
        buildViewHierachy()
        setupConstraints()
        setupAddtionalConfiguration()
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: .zero)
        
       setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension BackgroundView: SearchProtocol {
    func buildViewHierachy() {
        self.addSubview(img)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            img.heightAnchor.constraint(equalToConstant: 200),
            img.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            img.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            img.topAnchor.constraint(equalTo: self.topAnchor),
        ])
       
    }
    
    func setupAddtionalConfiguration() {}
    
}
