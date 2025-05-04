//
//  settingPageViewController.swift
//  MidtermProject
//
//  Created by TWINB00599242 on 2025/4/29.
//

import UIKit

class SettingPageViewController: UIViewController {
    private let stackView = UIStackView()
    private let screenShotStackView = UIStackView()
    private let regardingLabel = UILabel()
    private let changeInfoButton = UIButton()
    private let changePasswordButton = UIButton()
    private let restrictScreenshotLabel = UILabel()
    private let restrictScreenshotSwitch = UISwitch()
    private let logOutButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        configAutoLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        guard let data = UserDefaults.standard.object(forKey: "PersonalInfo") as? [String: String] else { return }
        guard let name = data["姓名"] else { return }
        regardingLabel.text = "Hi, \(name)"
    }
    private func configView() {
        view.addSubview(stackView)
        view.addSubview(regardingLabel)
        view.addSubview(logOutButton)
        stackView.insertArrangedSubview(changeInfoButton, at: 0)
        stackView.insertArrangedSubview(changePasswordButton, at: 1)

        screenShotStackView.insertArrangedSubview(restrictScreenshotLabel, at: 0)
        screenShotStackView.insertArrangedSubview(restrictScreenshotSwitch, at: 1)
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.layer.borderColor = UIColor.darkGray.cgColor
        stackView.layer.borderWidth = 2
        stackView.layer.cornerRadius = 12
        stackView.addArrangedSubview(wrapWithBottomBorder(changeInfoButton))
        stackView.addArrangedSubview(wrapWithBottomBorder(changePasswordButton))
        stackView.insertArrangedSubview(screenShotStackView, at: 2)

        screenShotStackView.axis = .horizontal
        screenShotStackView.distribution = .fillEqually
        screenShotStackView.alignment = .center
        guard let data = UserDefaults.standard.object(forKey: "PersonalInfo") as? [String: String] else { return }
        guard let name = data["姓名"] else { return }
        regardingLabel.text = "Hi, \(name)"
        regardingLabel.font = .systemFont(ofSize: 32)
        changeInfoButton.setTitle("變更個人資料", for: .normal)
        changeInfoButton.titleLabel?.font = .systemFont(ofSize: 24)
        changeInfoButton.setTitleColor(.black, for: .normal)
        changeInfoButton.titleLabel?.textAlignment = .left
        changePasswordButton.setTitle("變更密碼", for: .normal)
        changePasswordButton.titleLabel?.font = .systemFont(ofSize: 24)
        changePasswordButton.setTitleColor(.black, for: .normal)
        changePasswordButton.titleLabel?.textAlignment = .left
        restrictScreenshotLabel.text = "禁止截圖"
        restrictScreenshotLabel.font = .systemFont(ofSize: 24)
        restrictScreenshotLabel.textAlignment = .center
        logOutButton.setTitle("登出", for: .normal)
        logOutButton.titleLabel?.font = .systemFont(ofSize: 24)
        logOutButton.backgroundColor = .black
        logOutButton.tintColor = .white
        logOutButton.layer.cornerRadius = 12
        changeInfoButton.addTarget(self, action: #selector(didTapChangeInfoButton), for: .touchUpInside)
        changePasswordButton.addTarget(self, action: #selector(didTapChangePasswordButton), for: .touchUpInside)
        logOutButton.addTarget(self, action: #selector(didTapLogOutButton), for: .touchUpInside)
    }
    private func configAutoLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        regardingLabel.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        changeInfoButton.translatesAutoresizingMaskIntoConstraints = false
        changePasswordButton.translatesAutoresizingMaskIntoConstraints = false
        screenShotStackView.translatesAutoresizingMaskIntoConstraints = false
        restrictScreenshotSwitch.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            regardingLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            regardingLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            regardingLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            changeInfoButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1),
            changeInfoButton.heightAnchor.constraint(equalToConstant: 120),
            changePasswordButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1),
            changePasswordButton.heightAnchor.constraint(equalToConstant: 120),
            stackView.topAnchor.constraint(equalTo: regardingLabel.bottomAnchor, constant: 120),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            stackView.widthAnchor.constraint(equalToConstant: 360),
            screenShotStackView.heightAnchor.constraint(equalToConstant: 120),
            restrictScreenshotSwitch.centerYAnchor.constraint(equalTo: screenShotStackView.centerYAnchor),
            logOutButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            logOutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            logOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            logOutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    private func wrapWithBottomBorder(_ view: UIView,
                                      borderColor: UIColor = .darkGray, borderHeight: CGFloat = 1) -> UIView {
        let container = UIView()
        container.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            view.topAnchor.constraint(equalTo: container.topAnchor),
            view.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        let border = UIView()
        border.backgroundColor = borderColor
        container.addSubview(border)
        border.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            border.heightAnchor.constraint(equalToConstant: borderHeight),
            border.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            border.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            border.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        return container
    }
    @objc func didTapChangeInfoButton() {
        let infoVC = ChangeInfoViewController()
        self.navigationController?.pushViewController(infoVC, animated: true)
    }
    @objc func didTapChangePasswordButton() {
        let passwordVC = ChangePasswordViewController()
        self.navigationController?.pushViewController(passwordVC, animated: true)
    }
    @objc func didTapLogOutButton() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            let loginController = LoginViewController()
            window.rootViewController = loginController
            window.makeKeyAndVisible()
        }
    }

}
