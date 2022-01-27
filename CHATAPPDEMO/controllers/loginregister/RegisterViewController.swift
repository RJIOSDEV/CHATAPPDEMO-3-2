//
//  RegisterViewController.swift
//  CHATAPPDEMO
//
//  Created by rajanOS on 27/01/22.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
     
    
    
    private let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    
    
    
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .gray
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    private let firstnameField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "firstname"
        
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    private let LastnameField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "lastname"
        
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
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
    
    private let registerButton: UIButton = {
       let button = UIButton()
        button.setTitle("register", for: .normal)
        button.backgroundColor = .systemGreen
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
        
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        emailField.delegate = self
        passwordField.delegate = self
        
        view.addSubview(scrollView)
        scrollView.addSubview(firstnameField)
        scrollView.addSubview(LastnameField)
        scrollView.addSubview(emailField)
        scrollView.addSubview(imageView)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(registerButton)
        
        imageView.isUserInteractionEnabled = true
        scrollView.isUserInteractionEnabled = true
        
        
        
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didChangeProfilePic))
    //    gesture.numberOfTouchesRequired = 1
    //    gesture.numberOfTapsRequired = 1
        
        
        imageView.addGestureRecognizer(gesture)
        
        // Do any additional setup after loading the view.
    }
    @objc private func didChangeProfilePic(){
        
        
        presentPhotoActionSheet()
        print("change pic called")
    }
    

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = scrollView.width/3
        imageView.frame = CGRect(x: (scrollView.width-size)/2, y: 20, width: size, height: size)
        imageView.layer.cornerRadius = imageView.width/2
        
            firstnameField .frame = CGRect(x: 30, y: imageView.bottom+10, width: scrollView.width-60, height: 52)
        
            LastnameField .frame = CGRect(x: 30, y: firstnameField.bottom+10, width: scrollView.width-60, height: 52)
        
    
        emailField .frame = CGRect(x: 30, y: LastnameField.bottom+10, width: scrollView.width-60, height: 52)
    
        
            passwordField
            .frame = CGRect(x: 30, y: emailField
                                .bottom+10, width: scrollView.width-60, height: 52)
        
            registerButton
            .frame = CGRect(x: 30, y: passwordField
                                .bottom+10, width: scrollView.width-60, height: 52)
    
    
    }
    
    @objc private func registerButtonTapped(){
        passwordField.resignFirstResponder()
        emailField.resignFirstResponder()
        firstnameField.resignFirstResponder()
        LastnameField.resignFirstResponder()
        
        guard let firstName = firstnameField.text,
            let lastName = LastnameField.text,
            
            let email = emailField.text,
              let password = passwordField.text,
              !email.isEmpty,
              !password.isEmpty,
              !firstName.isEmpty,
              !lastName.isEmpty,
              password.count >= 6  else {
        alertuserLoginError()
                  
                  return
              }
        //firebase login
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { authResult, error in
            
            guard let result = authResult,error == nil else{
                print("error user creating")
            return
            }
            let user = result.user
            print("creaed \(user)")
        })
        
    }
    
    func alertuserLoginError(){
        let alert = UIAlertController(title: "oops", message: "please enter all info to create account", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "dissmis", style: .cancel, handler: nil))
        present(alert,animated: true)
    }
    @objc private func didTapRegister(){
let vc = RegisterViewController()
        vc.title = "create acc"
        navigationController?.pushViewController(vc, animated: true)
    }



}
extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            registerButtonTapped()
        }
        
        return true
    }
}
extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
    
    func presentPhotoActionSheet(){
        
        let actionSheet = UIAlertController(title: "profile", message: "how would yo like", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "censal", style: .cancel, handler: nil))
        
        actionSheet.addAction(UIAlertAction(title: "take photo ", style: .default, handler: { [weak self]_ in
            
            self?.presentCamera()
            
            
            
        }))
        actionSheet.addAction(UIAlertAction(title: "choosephoto", style: .default, handler: {[weak self]_ in
            self?.presentPhotoPicker()
            
        }))
        present(actionSheet, animated: true)

        
    }
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
    }
    
    func presentPhotoPicker(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
     
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      //  print(info)
      guard  let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        else{
            return
        }
        self.imageView.image = selectedImage
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}
