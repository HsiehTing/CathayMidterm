//
//  ChangePasswordViewController.swift
//  MidtermProject
//
//  Created by TWINB00599242 on 2025/5/2.
//

import UIKit

class ChangePasswordViewController: UIViewController, ChangeInfoDelegate, ChangePasswordDelegate {
    
    private let changePasswordCollectionView = UICollectionView(
        frame: .zero, collectionViewLayout: SignupViewController.configFlowLayout()
    )
    
    private let changePasswordCollectionViewIdentifier = "changePasswordCollectionViewIdentifier"
    private let confirmButton = UIButton()
    public let questionSets = ["原密碼", "新密碼", "確認密碼"]
    private var passBackArray: [String: String] = [:]
    private var personalInfo: [String: String] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle()
        getPersonalInfo()
        configCollectionView()
        configButton()
        configAutoLayout()
        setUpTapGesture()
    }
    
    private func setNavigationTitle() {
        navigationItem.title = "變更密碼"
    }
    
    private func getPersonalInfo() {
        
        guard let data = UserDefaults.standard.object(forKey: "PersonalInfo") as? [String: String] else { return }
        personalInfo = data
    }
    
    func passInfo(info: String, question: String) {
        self.passBackArray[question] = info
        
        if passBackArray.count == questionSets.count ,
           passBackArray["原密碼"] == personalInfo["密碼"],
            passBackArray["新密碼"] == passBackArray["再次輸入新密碼"], passBackArray["原密碼"] != passBackArray["密碼"] {
            confirmButton.isUserInteractionEnabled = true
            confirmButton.backgroundColor = .black
        } else {
            confirmButton.backgroundColor = .lightGray
            confirmButton.isUserInteractionEnabled = false
        }
    }
    
    func setUpTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    private func configButton() {
        view.addSubview(confirmButton)
        confirmButton.setTitle("確認變更", for: .normal)
        confirmButton.titleLabel?.font = .systemFont(ofSize: 24)
        confirmButton.backgroundColor = .lightGray
        confirmButton.isUserInteractionEnabled = false
        confirmButton.tintColor = .white
        confirmButton.layer.cornerRadius = 12
        confirmButton.addTarget(self, action: #selector(didTapSignup), for: .touchUpInside)
    }
    
    private func configCollectionView() {
        view.addSubview(changePasswordCollectionView)
        changePasswordCollectionView.register(ChangePasswordViewCell.self, forCellWithReuseIdentifier: changePasswordCollectionViewIdentifier)
        changePasswordCollectionView.delegate = self
        changePasswordCollectionView.dataSource = self
    }
    
    private func configAutoLayout() {
        changePasswordCollectionView.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            
            changePasswordCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            changePasswordCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            changePasswordCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            changePasswordCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            confirmButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            confirmButton.widthAnchor.constraint(equalToConstant: 360),
            confirmButton.heightAnchor.constraint(equalToConstant: 60),
            confirmButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
            
        ])
    }
    
    static func configFlowLayout() -> UICollectionViewCompositionalLayout {
        
        let layOut = UICollectionViewCompositionalLayout { _, _ in
            
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.2)
            )
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 40, bottom: 0, trailing: 40)
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
        return layOut
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func didTapSignup() {
        personalInfo["密碼"] = passBackArray["新密碼"]
        UserDefaults.standard.set(personalInfo, forKey: "PersonalInfo")
        navigationController?.popViewController(animated: true)
    }
    
}

extension ChangePasswordViewController: UICollectionViewDelegate {
    
}

extension ChangePasswordViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        questionSets.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = changePasswordCollectionView.dequeueReusableCell(withReuseIdentifier: changePasswordCollectionViewIdentifier, for: indexPath) as? ChangePasswordViewCell else { return UICollectionViewCell() }
        cell.getData(index: indexPath.item)
        cell.delegate = self
        return cell
    }
    
}

