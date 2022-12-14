//
//  LoginViewController.swift
//  CHATAPPDEMO
//
//  Created by rajanOS on 27/01/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
     
    
    
    private let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    
    
    
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let emailField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "email adress0"
        
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    private let passwordField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "password"
        
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    
    private let loginButton: UIButton = {
       let button = UIButton()
        button.setTitle("login", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        view.backgroundColor = .white
        
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "register", style: .done, target:self, action: #selector(didTapRegister))
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        emailField.delegate = self
        passwordField.delegate = self
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(emailField)
        scrollView.addSubview(imageView)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginButton)
        // Do any additional setup after loading the view.
    }
    

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = scrollView.width/3
        imageView.frame = CGRect(x: (scrollView.width-size)/2, y: 20, width: size, height: size)
    
        emailField .frame = CGRect(x: 30, y: imageView.bottom+10, width: scrollView.width-60, height: 52)
    
        
            passwordField
            .frame = CGRect(x: 30, y: emailField
                                .bottom+10, width: scrollView.width-60, height: 52)
        
            loginButton
            .frame = CGRect(x: 30, y: passwordField
                                .bottom+10, width: scrollView.width-60, height: 52)
    
    
    }
    
    @objc private func loginButtonTapped(){
        
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        guard let email = emailField.text,
              let password = passwordField.text,!email.isEmpty,!password.isEmpty, password.count >= 6  else{
        alertuserLoginError()
                  
                  return
              }
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { authResult , error in
            
            
            guard let result = authResult, error == nil else{
                print("feild:\(email)")
                
                return
            }
            let user = result.user
            print("loggedin\(user)")
        })
        
    }
    
    func alertuserLoginError(){
        let alert = UIAlertController(title: "oops", message: "please enter all info", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "dissmis", style: .cancel, handler: nil))
        present(alert,animated: true)
    }
    @objc private func didTapRegister(){
let vc = RegisterViewController()
        vc.title = "create acc"
        navigationController?.pushViewController(vc, animated: true)
    }



}
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            loginButtonTapped()
        }
        
        return true
    }
}
