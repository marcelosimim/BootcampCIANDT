//
//  EvaluatedAuthViewController.swift
//  BreweryBees
//
//  Created by Marcelo Simim Santos on 25/02/22.
//

import UIKit

protocol EvaluatedAuthDelegate: AnyObject {
    func getEvaluatedBreweries(email: String)
}

class EvaluatedAuthViewController: UIViewController {
    
    weak var delegate: EvaluatedAuthDelegate?
    let defaults = UserDefaults.standard
    var rememberEmail:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingSubviews()
        settingConstraints()
        getEmail()
    }
    
    // MARK: - Components
    
    lazy var headerView: UIImageView  = {
        let view = UIImageView()
        view.image = UIImage(named: "bgYellow")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Cervejarias que você avaliou"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
       let label = UILabel()
        label.text = "Informe seu e-mail para consultar as cervejarias avaliadas."
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .emailAddress
        textField.placeholder = "nome@email.com"
        textField.text = ""
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var checkbox: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "select"), for: .normal)
        button.addTarget(self, action: #selector(checkboxClicked), for: .touchDown)
        button.translatesAutoresizingMaskIntoConstraints  = false
        return button
    }()
    
    lazy var rememberEmailLabel: UILabel = {
       let label = UILabel()
        label.text = "Lembrar meu e-mail para futuras consultas"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("CONFIRMAR", for: .normal)
        button.layer.backgroundColor = UIColor(red: 1, green: 0.8, blue: 0, alpha: 0.3).cgColor
        button.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.3), for: .normal)
        button.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.3), for: .disabled)
        button.isEnabled = false
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(buttonClicked), for: .touchDown)
        button.translatesAutoresizingMaskIntoConstraints  = false
        return button
    }()
    
    // MARK: - Setting Subviews
    
    func settingSubviews(){
        view.addSubview(headerView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(emailTextField)
        view.addSubview(checkbox)
        view.addSubview(rememberEmailLabel)
        view.addSubview(confirmButton)
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
            emailTextField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 24*viewHeight),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: viewWidth*16),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkbox.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: viewHeight*20),
            checkbox.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: viewWidth*16),
            checkbox.heightAnchor.constraint(equalToConstant: 18),
            checkbox.widthAnchor.constraint(equalToConstant: 18),
            rememberEmailLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: viewHeight*20),
            rememberEmailLabel.leadingAnchor.constraint(equalTo: checkbox.trailingAnchor, constant: viewWidth*4),
            confirmButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: viewHeight*66),
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: viewWidth*16),
            confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
}


extension EvaluatedAuthViewController {
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    @objc func buttonClicked(){
        if rememberEmail {
            defaults.set(emailTextField.text, forKey: "Email")
        }else{
            defaults.set("", forKey: "Email")
        }
        
        delegate?.getEvaluatedBreweries(email: emailTextField.text ?? "")
    }
    
    func setButtonEnabled(){
        confirmButton.isEnabled = true
        confirmButton.layer.backgroundColor = UIColor(red: 1, green: 0.8, blue: 0, alpha: 1).cgColor
    }
    
    func setButtonDisabled(){
        confirmButton.isEnabled = false
        confirmButton.layer.backgroundColor = UIColor(red: 1, green: 0.8, blue: 0, alpha: 0.3).cgColor
    }
    
    @objc func checkboxClicked(){
        rememberEmail = !rememberEmail
        if rememberEmail {
            checkbox.setImage(UIImage(named: "select"), for: .normal)
        }else {
            checkbox.setImage(UIImage(named: "unselected"), for: .normal)
        }
    }
    
    func getEmail(){
        let email = defaults.string(forKey: "Email")
        
        guard let email = email else {
            return
        }

        emailTextField.text = email
        setButtonEnabled()
    }
}

extension EvaluatedAuthViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        
        if isValidEmail(emailTextField.text ?? "") {
            setButtonEnabled()
        }else{
            setButtonDisabled()
        }
        return true
    }
}
