//
//  RateBrewry.swift
//  BreweryBees
//
//  Created by FELIPE AUGUSTO SILVA on 03/02/22.
//

import Cosmos
import UIKit
import Lottie

class RateBrewry: UIViewController, UITextFieldDelegate {
    public var Brew: BreweryDetailViewModel = BreweryContainer.shared.resolve(BreweryDetailViewModel.self)!
    
    var isSuccess = false
    var isSelected = false
    var isValid = false
    var BrewName: String = " "
    var BrewID: String = ""
    
    let Brewrytitle: UILabel = {
      let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 20,  weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var cosmosView: CosmosView = {
        var view = CosmosView()
        view.settings.starSize = 25
        view.rating = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        view.settings.filledImage?.value(forKey: "5")
        return view
    }()
    
    
    let EmailField: UITextField = {
        let field = UITextField()

        field.placeholder = "nome@email.com"
//        field.layer.borderWidth = 0.1
//        field.layer.cornerRadius = 5
        return field
    }()
    
    let selectButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "unselected"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(onButtonSelect), for: .touchUpInside)
        
        return button
    }()
    
    
    let remberEmailLabel: UILabel = {
      let label = UILabel()
        label.text = "Lembrar meu e-mail para futuras avaliações"
        label.font = UIFont.systemFont(ofSize: 14,  weight: .ultraLight)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let saveRate: UIButton = {
       let button = UIButton()
        button.setTitle("SALVAR", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(named: "yellow")
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        button.layer.opacity = 0.3
        button.addTarget(self, action: #selector(saveBrewryRate), for: .touchUpInside)
        return button
    }()
    
    let rateStackView = UIView()
    
    let successStackView = UIView()
    
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
    
    let BrewryrateSuccess: UILabel = {
      let label = UILabel()
        label.text = "Você já avaliou esta cervejaria!"
        label.font = UIFont.systemFont(ofSize: 18,  weight: .regular)
        label.textColor = UIColor(named: "success-green")
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let BrindeText: UILabel = {
      let label = UILabel()
        label.text = "Um brinde!"
        label.font = UIFont.systemFont(ofSize: 20,  weight: .bold)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let SeparetorLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(red: 0.8471, green: 0.8471, blue: 0.8471, alpha: 1.0)
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    

    let lottie = AnimationView(name: "successLottie")
        

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.EmailField.delegate = self
        
        Brewrytitle.text = BrewName
        
        view.backgroundColor = .white
        view.addSubview(favoriteIcon)
        view.addSubview(shareIcon)
        view.addSubview(rateStackView)
        view.addSubview(successStackView)
        layoutConfigContraits()
        
    }
    
    @objc func saveBrewryRate() {
        let textfield = self.EmailField.text ?? "?"
        let rate = String(self.cosmosView.rating)
        
//        rateBrew
        Brew.rateBrew(id: "alphabet-city-brewing-co-new-york", email: textfield, rate: rate) {
            print("test rating")
        }
        
        self.rateStackView.isHidden = true
        self.successStackView.isHidden = false
        self.lottie.loopMode = .repeat(1)
        self.lottie.play()
    
    }
    
    @objc func onButtonSelect() {
        if !isSelected {
            self.selectButton.setBackgroundImage(UIImage(named: "select"), for: .normal)
            self.isSelected = true
            if isValid && isSelected {
            self.saveRate.isEnabled = true
            self.saveRate.layer.opacity = 1
            }
        }
        else {
            self.selectButton.setBackgroundImage(UIImage(named: "unselected"), for: .normal)
            self.isSelected = false
            self.saveRate.isEnabled = false
            self.saveRate.layer.opacity = 0.3
        }
        
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    func textFieldShouldReturn(_ EmailField: UITextField) -> Bool {
        //textField code
        let textfield = EmailField.text ?? "?"
        if  isValidEmail(textfield) {
            print("email is valid")
            self.EmailField.layer.borderWidth = 0
            isValid = true
            if isValid && isSelected {
            self.saveRate.isEnabled = true
            self.saveRate.layer.opacity = 1
            }
        } else {
            print("email not valid")
            EmailField.isError(baseColor: UIColor.gray.cgColor, numberOfShakes: 6, revert: true)
            
        }
        EmailField.resignFirstResponder()
        return true
    }

    
    
    private func layoutConfigContraits() {
        view.addSubview(rateStackView)
        
        rateStackView.addSubview(EmailField)
        rateStackView.addSubview(Brewrytitle)
        rateStackView.addSubview(cosmosView)
        rateStackView.addSubview(remberEmailLabel)
        rateStackView.addSubview(saveRate)
        rateStackView.addSubview(selectButton)
        
        successStackView.addSubview(BrindeText)
        successStackView.addSubview(lottie)
        successStackView.addSubview(BrewryrateSuccess)
        successStackView.addSubview(SeparetorLine)
        successStackView.isHidden = true
        
        successStackView.translatesAutoresizingMaskIntoConstraints = false
        rateStackView.translatesAutoresizingMaskIntoConstraints = false
        
//        MARK: STACKS CONSTRAINT
        NSLayoutConstraint.activate(
        [
            rateStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            rateStackView.heightAnchor.constraint(equalTo: view.heightAnchor),
            rateStackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            rateStackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            successStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            successStackView.heightAnchor.constraint(equalTo: view.heightAnchor),
            successStackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            successStackView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ]
        )
        
//        MARK: RATESTACKVIEW CONSTRAINTS
        NSLayoutConstraint.activate([
            Brewrytitle.topAnchor.constraint(equalTo: rateStackView.topAnchor, constant: 25),
            Brewrytitle.centerX(to: rateStackView),
            
            cosmosView.topAnchor.constraint(equalTo: Brewrytitle.bottomAnchor, constant: 8),
            cosmosView.centerX(to: rateStackView),
            
            EmailField.topAnchor.constraint(equalTo: cosmosView.bottomAnchor, constant: 45),
            EmailField.centerX(to: rateStackView),
            EmailField.widthAnchor.constraint(equalTo: rateStackView.widthAnchor, multiplier: 0.9),
            EmailField.heightAnchor.constraint(equalToConstant: 40),
            
            remberEmailLabel.topAnchor.constraint(equalTo: EmailField.bottomAnchor, constant: 15),
            remberEmailLabel.leftAnchor.constraint(equalTo: selectButton.rightAnchor, constant: 5),
            
            selectButton.topAnchor.constraint(equalTo: EmailField.bottomAnchor, constant: 15),
            selectButton.leftAnchor.constraint(equalTo: rateStackView.leftAnchor,constant: 20),
            selectButton.heightAnchor.constraint(equalToConstant: 17),
            selectButton.widthAnchor.constraint(equalToConstant: 17),
                
            saveRate.topAnchor.constraint(equalTo: remberEmailLabel.bottomAnchor, constant: 25),
            saveRate.leftAnchor.constraint(equalTo: rateStackView.leftAnchor, constant: 20),
            saveRate.rightAnchor.constraint(equalTo: rateStackView.rightAnchor, constant: -20),
            saveRate.heightAnchor.constraint(equalToConstant: 40)
        ])
    
        NSLayoutConstraint.activate([
            BrindeText.topAnchor.constraint(equalTo: successStackView.topAnchor, constant: 20),
            BrindeText.centerX(to: successStackView),
            
            lottie.topAnchor.constraint(equalTo: BrindeText.topAnchor, constant: 10),
            lottie.widthAnchor.constraint(equalToConstant: 150),
            lottie.heightAnchor.constraint(equalToConstant: 150),
            lottie.centerX(to: successStackView),
            
            BrewryrateSuccess.topAnchor.constraint(equalTo: lottie.bottomAnchor, constant: 20),
            BrewryrateSuccess.centerX(to: successStackView),
            
            favoriteIcon.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            favoriteIcon.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            favoriteIcon.widthAnchor.constraint(equalToConstant: 30),
            favoriteIcon.heightAnchor.constraint(equalToConstant: 30),
            
            shareIcon.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            shareIcon.rightAnchor.constraint(equalTo: favoriteIcon.leftAnchor, constant: -15),
            shareIcon.heightAnchor.constraint(equalToConstant: 30),
            shareIcon.widthAnchor.constraint(equalToConstant: 30),
            
            SeparetorLine.bottomAnchor.constraint(equalTo: shareIcon.topAnchor, constant: -25),
            SeparetorLine.rightAnchor.constraint(equalTo: successStackView.rightAnchor,constant: -15),
            
            SeparetorLine.leftAnchor.constraint(equalTo: successStackView.leftAnchor,constant: 15),
            SeparetorLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    

}

extension UITextField {
    func isError(baseColor: CGColor, numberOfShakes shakes: Float, revert: Bool) {
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "shadowColor")
        animation.fromValue = baseColor
        animation.toValue = UIColor.red.cgColor
        animation.duration = 0.3
        if revert { animation.autoreverses = true } else { animation.autoreverses = false }
        self.layer.add(animation, forKey: "")

        let shake: CABasicAnimation = CABasicAnimation(keyPath: "position")
        shake.duration = 0.05
        shake.repeatCount = shakes
        if revert { shake.autoreverses = true  } else { shake.autoreverses = false }
        shake.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 5, y: self.center.y))
        shake.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 5, y: self.center.y))
        self.layer.add(shake, forKey: "position")
        self.textColor = .red
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor(red: 1, green: 0, blue: 0.0157, alpha: 1.0).cgColor
        
    }
}
