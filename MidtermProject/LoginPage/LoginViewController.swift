//
//  LoginViewController.swift
//  MidtermProject
//
//  Created by TWINB00599242 on 2025/4/28.
//

import UIKit

class LoginViewController: UIViewController {
    
    let accountLabel = UILabel()
    let passwordLabel = UILabel()
    let rememberMeLabel = UILabel()
    let loginButton = UIButton(type: .roundedRect)
    let rememberCheckBox = UIButton(type: .custom, primaryAction: UIAction(handler: { _ in }))
    let signUpButton = UIButton(type: .custom)
    let accountInputTextField = UITextField()
    let passwordInputTextField = UITextField()
    let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        configAutoLayout()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configAccountInput()
        configPasswordInput()
    }
    
    private func configView() {
        view.addSubview(accountLabel)
        view.addSubview(passwordLabel)
        view.addSubview(loginButton)
        view.addSubview(signUpButton)
        view.addSubview(accountInputTextField)
        view.addSubview(passwordInputTextField)
        view.addSubview(stackView)
        configStackView()
        configAccountLabel()
        configPasswordLabel()
        configRememberMeLabel()
        configSignUpButton()
        configLoginButton()
        configRememberCheckBox()
    }
    
    private func configStackView() {
        stackView.addArrangedSubview(rememberCheckBox)
        stackView.addArrangedSubview(rememberMeLabel)
        stackView.axis = .horizontal
        stackView.alignment = .leading
        rememberMeLabel.text = "記住我"
    }
    
    private func configAccountLabel() {
        accountLabel.font = .systemFont(ofSize: 24)
        accountLabel.textAlignment = .left
        accountLabel.text = "帳號"
    }
    
    private func configPasswordLabel() {
        passwordLabel.font = .systemFont(ofSize: 24)
        passwordLabel.textAlignment = .left
        passwordLabel.text = "密碼"
    }
    
    private func configRememberMeLabel() {
        rememberMeLabel.font = .systemFont(ofSize: 24)
    }
    
    private func configBottomLine() -> CALayer {
        let bottomLine = CALayer()
        bottomLine.frame =  CGRectMake(0.0, view.frame.height - 1, view.frame.width, 1.0)
        bottomLine.backgroundColor = UIColor(.black).cgColor
        return bottomLine
    }
    
    private func configAccountInput() {
        
        accountInputTextField.setUnderLine()
    }
    
    private func configPasswordInput() {
        passwordInputTextField.setUnderLine()
    }
    
    private func configSignUpButton() {
        signUpButton.setTitle("註冊帳號", for: .normal)
        signUpButton.setTitleColor(.systemBlue, for: .normal)
        signUpButton.titleLabel?.font = .systemFont(ofSize: 24)
        signUpButton.addTarget(self, action: #selector(didTapSignUpPage), for: .touchUpInside)
    }
    
    private func configLoginButton() {
        loginButton.setTitle("登入", for: .normal)
        loginButton.backgroundColor = .black
        loginButton.titleLabel?.font = .systemFont(ofSize: 24)
        loginButton.tintColor = .white
        loginButton.layer.cornerRadius = 15
    }
    
    private func configRememberCheckBox() {
        rememberCheckBox.setImage(UIImage(systemName: "square"), for: .normal)
        rememberCheckBox.setImage(UIImage(systemName: "checkmark.square"), for: .selected)
        rememberCheckBox.tintColor = .black
        rememberCheckBox.addTarget(self, action: #selector(didTapCheckBox), for: .touchUpInside)
    }
    
    private func configAutoLayout() {
        accountLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        rememberMeLabel.translatesAutoresizingMaskIntoConstraints = false
        rememberCheckBox.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        accountInputTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordInputTextField.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            accountLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 60),
            accountLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 180),
            accountLabel.heightAnchor.constraint(equalToConstant: 24),
            
            accountInputTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            accountInputTextField.topAnchor.constraint(equalTo: accountLabel.bottomAnchor, constant: 10),
            accountInputTextField.widthAnchor.constraint(equalToConstant: 280),
            accountInputTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 60),
            passwordLabel.topAnchor.constraint(equalTo: accountInputTextField.topAnchor, constant: 80),
            passwordLabel.heightAnchor.constraint(equalToConstant: 24),
            
            passwordInputTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            passwordInputTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 10),
            passwordInputTextField.widthAnchor.constraint(equalToConstant: 280),
            passwordInputTextField.heightAnchor.constraint(equalToConstant: 40),
            
            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: passwordInputTextField.bottomAnchor, constant: 30),
            stackView.widthAnchor.constraint(equalToConstant: 300),
            stackView.heightAnchor.constraint(equalToConstant: 60),
            
            rememberCheckBox.widthAnchor.constraint(equalToConstant: 32),
            rememberCheckBox.heightAnchor.constraint(equalToConstant: 32),
            
            loginButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30),
            loginButton.heightAnchor.constraint(equalToConstant: 44),
            loginButton.widthAnchor.constraint(equalToConstant: 300),
            
            signUpButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 60),
            signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30),
            signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -160),
            signUpButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc private func didTapCheckBox() {
        rememberCheckBox.isSelected.toggle()
        rememberCheckBox.configuration?.baseBackgroundColor = .white
        rememberCheckBox.configuration?.baseForegroundColor = .black
    }
    
    @objc private func didTapSignUpPage() {
        let signupVC = SignupViewController()
        self.navigationController?.pushViewController(signupVC, animated: true)
    }
}

extension UITextField {
    
    func setUnderLine() {
        self.layer.sublayers?.removeAll(where: { $0.name == "underline" })
        let border = CALayer()
        let width = CGFloat(1.5)
        border.borderColor = UIColor.black.cgColor
        border.frame =  CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width - 10, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
}
