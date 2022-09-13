//
//  ViewController.swift
//  createSecondRXSwiftApp
//
//  Created by MacOS on 30/06/2022.
//

import UIKit
import RxSwift
import RxCocoa

class AuthorizationView: UIViewController {
    
    //MARK: - IBOutlet
    let containerView = UIView()
    
    let emailLable              = CFRegisterLable(title: .email)
    let emailTextField          = CFText()
    let underLineViewEmail      = UIView()
    
    let passwordLable           = CFRegisterLable(title: .password)
    let passwordTextField       = CFText()
    let underLineViewPassword   = UIView()
    
    
    let loginButton             = CFMainButton(title: .login)
    
    let bottomImage             = UIImageView()
    
    //MARK: - Constant
    
    let viewModel = AuthorizationViewModel()
    
    let bag = DisposeBag()
    
    //MARK: - View DidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confirureUI()
        bindTextField()
        subscripeOnButtonValidation()
        loginAction()
    }
    
    //MARK: - Configuration Func
    
    private func confirureUI(){
        
        view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.isHidden = true
        
        addGestureToEndEditing()
        
        view.addSubview(containerView)
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            containerView.heightAnchor.constraint(equalToConstant: 180)
        ])
        
        containerView.addSubview(emailLable)
        NSLayoutConstraint.activate([
            emailLable.topAnchor.constraint(equalTo: containerView.topAnchor),
            emailLable.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            emailLable.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            emailLable.heightAnchor.constraint(equalToConstant: 22)
        ])
        
        containerView.addSubview(emailTextField)
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: emailLable.bottomAnchor, constant: 5),
            emailTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor , constant: 10),
            emailTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor , constant: -10),
            emailTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        containerView.addSubview(underLineViewEmail)
        underLineViewEmail.backgroundColor = Colors.coffee
        underLineViewEmail.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            underLineViewEmail.topAnchor.constraint(equalTo: emailTextField.bottomAnchor),
            underLineViewEmail.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            underLineViewEmail.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            underLineViewEmail.heightAnchor.constraint(equalToConstant: 2)
        ])
        
        containerView.addSubview(passwordLable)
        NSLayoutConstraint.activate([
            passwordLable.topAnchor.constraint(equalTo: underLineViewEmail.bottomAnchor, constant: 13),
            passwordLable.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            passwordLable.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            passwordLable.heightAnchor.constraint(equalToConstant: 22)
        ])
        containerView.addSubview(passwordTextField)
        passwordTextField.isSecureTextEntry = true
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: passwordLable.bottomAnchor, constant: 5),
            passwordTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor , constant: 10),
            passwordTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor , constant: -10),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        underLineViewPassword.backgroundColor = Colors.coffee
        underLineViewPassword.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(underLineViewPassword)
        NSLayoutConstraint.activate([
            underLineViewPassword.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor),
            underLineViewPassword.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            underLineViewPassword.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            underLineViewPassword.heightAnchor.constraint(equalToConstant: 2)
        ])
        
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 47),
            loginButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 66)
        ])
        
        
        view.addSubview(bottomImage)
        bottomImage.contentMode = .scaleToFill
        bottomImage.image = UIImage(named: "coffee-time-artwork")
        bottomImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomImage.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30),   //47
            bottomImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    private func addGestureToEndEditing(){
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    
    //MARK: - HelperFunctions
    
    private func bindTextField(){
        emailTextField.rx.text.orEmpty.bind(to: viewModel.emailBehavior).disposed(by: bag)
        passwordTextField.rx.text.orEmpty.bind(to: viewModel.passwordBehavior).disposed(by: bag)
    }
    
    private func subscripeOnButtonValidation(){
        viewModel.isEveryThingValid.bind(to: self.loginButton.rx.isEnabled).disposed(by: bag)
    }
    
    private func loginAction(){
        loginButton.rx.tap.throttle(RxTimeInterval.microseconds(300), scheduler: MainScheduler.instance).subscribe { [weak self](_) in
            guard let self = self else {return}
            /// if you have API you can send the request here
            let menuVC = MenuView()
            //self.present(menuVC, animated: true)
            self.navigationController?.pushViewController(menuVC, animated: true)
        }.disposed(by: bag)
    }
    
    
}

