//
//  ChangeInfoViewController.swift
//  MidtermProject
//
//  Created by TWINB00599242 on 2025/5/2.
//
import UIKit

class ChangeInfoViewController: UIViewController, ChangeInfoDelegate {
    
    private let changeInfoCollectionView = UICollectionView(
        frame: .zero, collectionViewLayout: SignupViewController.configFlowLayout()
    )
    private var passBackArray: [String: String] = [:]
    private let confirmButton = UIButton()
    private let signupVC = SignupViewController()
    private let changeInfoCollectionViewIdentifier = "changeInfoCollectionViewIdentifier"
    private let questionSet: [String] = ["原密碼", "新密碼", "再次輸入新密碼"]

    override func viewDidLoad() {
        super.viewDidLoad()
        getPersonalInfo()
        setNavigationTitle()
        configCollectionView()
        configButton()
        configAutoLayout()
        setUpTapGesture()
    }
    
    private func getPersonalInfo() {
        
        guard let data = UserDefaults.standard.object(forKey: "PersonalInfo") as? [String: String] else { return }
        passBackArray = data
    }
    
    func passInfo(info: String, question: String) {
        self.passBackArray[question] = info
        
        if  passBackArray[question]?.isEmpty == false {
            confirmButton.isUserInteractionEnabled = true
            confirmButton.backgroundColor = .black
        } else {
            confirmButton.isUserInteractionEnabled = false
            confirmButton.backgroundColor = .lightGray
        }
        
    }
    
    func setUpTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    private func setNavigationTitle() {
        navigationItem.title = "變更個人資料"
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
        view.addSubview(changeInfoCollectionView)
        changeInfoCollectionView.register(ChangeInfoCollectionViewCell.self, forCellWithReuseIdentifier: changeInfoCollectionViewIdentifier)
        changeInfoCollectionView.delegate = self
        changeInfoCollectionView.dataSource = self
    }
    
    private func configAutoLayout() {
        changeInfoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            changeInfoCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            changeInfoCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            changeInfoCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            changeInfoCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            confirmButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            confirmButton.widthAnchor.constraint(equalToConstant: 360),
            confirmButton.heightAnchor.constraint(equalToConstant: 60),
            confirmButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
            
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
        UserDefaults.standard.set(passBackArray, forKey: "PersonalInfo")
        navigationController?.popViewController(animated: true)
    }
    
}

extension ChangeInfoViewController: UICollectionViewDelegate {
    
}

extension ChangeInfoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let infoQuestion = signupVC.questionSets.dropFirst(3)
        return infoQuestion.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let infoQuestion = signupVC.questionSets.dropFirst(3)
        guard let cell = changeInfoCollectionView.dequeueReusableCell(withReuseIdentifier: changeInfoCollectionViewIdentifier, for: indexPath) as? ChangeInfoCollectionViewCell else { return UICollectionViewCell() }
        cell.getData(questionSet: Array(infoQuestion), index: indexPath.item)
        cell.delegate = self
        return cell
    }
    
    
}
