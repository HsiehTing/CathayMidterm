//
//  SignupViewController.swift
//  MidtermProject
//
//  Created by TWINB00599242 on 2025/4/28.
//

//TODO: 問題集用collectionView 呈現
//TODO: 輸入匡的輸入限制
//TODO: 確認所有問題都輸入完成後才可以點選註冊

import UIKit

class SignupViewController: UIViewController, SignupDelegate {
    
    private let questionCollectionView = UICollectionView(
        frame: .zero, collectionViewLayout: SignupViewController.configFlowLayout()
    )
    private let signupButton = UIButton()
    private var passBackArray: [String: String] = [:]
    let questionSets = ["帳號", "密碼", "再次確認密碼", "姓名"]
    private let questionCollectionViewIdentifier = "QuestionCollectionView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle()
        configCollectionView()
        configSignupButton()
        configAutoLayout()
        configToolBarButton()
        self.setUpTapGesture()
    }
    
    func passInfo(info: String, question: String) {
        self.passBackArray[question] = info
        
        if passBackArray.count == questionSets.count , passBackArray["密碼"] == passBackArray["再次確認密碼"], passBackArray["帳號"] != passBackArray["密碼"] {
            signupButton.isUserInteractionEnabled = true
            signupButton.backgroundColor = .black
        } else {
            signupButton.backgroundColor = .lightGray
            signupButton.isUserInteractionEnabled = false
        }
    }
    
    func setUpTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    private func setNavigationTitle() {
        navigationItem.title = "註冊新帳號"
    }
    
    private func configToolBarButton() {
        let backButton = UIButton()
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationController?.isToolbarHidden = false
        self.navigationItem.hidesBackButton = true
    }
    
    private func configCollectionView() {
        view.addSubview(questionCollectionView)
        questionCollectionView.register(SignupCollectionviewCell.self, forCellWithReuseIdentifier: questionCollectionViewIdentifier)
        questionCollectionView.delegate = self
        questionCollectionView.dataSource = self
    }
    
    private func configSignupButton() {
        view.addSubview(signupButton)
        signupButton.backgroundColor = .lightGray
        signupButton.isUserInteractionEnabled = false
        signupButton.layer.cornerRadius = 15
        signupButton.setTitle("註冊", for: .normal)
        signupButton.titleLabel?.font = .systemFont(ofSize: 24)
        signupButton.addTarget(self, action: #selector(didTapSignup), for: .touchUpInside)
        
    }
    
    private func configAutoLayout() {
        questionCollectionView.translatesAutoresizingMaskIntoConstraints = false
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.questionCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.questionCollectionView.bottomAnchor.constraint(equalTo: signupButton.topAnchor),
            self.questionCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            self.questionCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            self.signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.signupButton.widthAnchor.constraint(equalToConstant: 300),
            self.signupButton.heightAnchor.constraint(equalToConstant: 50),
            self.signupButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
    
    @objc private func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func didTapSignup() {
        UserDefaults.standard.set(passBackArray, forKey: "PersonalInfo")
        navigationController?.popViewController(animated: true)
    }
    
}

extension SignupViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        questionSets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: questionCollectionViewIdentifier, for: indexPath) as? SignupCollectionviewCell else { return UICollectionViewCell() }
        
        cell.getData(quesionSets: questionSets, index: indexPath.item)
        cell.delegate = self
        return cell
    }
    
}

extension SignupViewController: UICollectionViewDelegate {
    
}

