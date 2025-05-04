//
//  HomePageViewController.swift
//  MidtermProject
//
//  Created by TWINB00599242 on 2025/4/29.
//

import UIKit

class HomePageViewController: UIViewController {
    private let homePageCollectionView = UICollectionView(
        frame: .zero, collectionViewLayout: configFlowLayout()
    )
    private let homePageCollectionViewIdentifier = "homePageCollectionView"
    private var apiData: [String: Any] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitile()
        configView()
        configHomePageCollectionViewAutoLayout()
    }
    private func configView() {
        view.addSubview(homePageCollectionView)
        homePageCollectionView.register(HomePageCollectionViewCell.self,
                                        forCellWithReuseIdentifier: homePageCollectionViewIdentifier)
        homePageCollectionView.delegate = self
        homePageCollectionView.dataSource = self
    }
    private func setNavigationTitile() {
        navigationItem.title = "昨日收盤指數"
    }
    private func configHomePageCollectionViewAutoLayout() {
        self.homePageCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            homePageCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            homePageCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            homePageCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            homePageCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    static func configFlowLayout() -> UICollectionViewCompositionalLayout {
        let layOut = UICollectionViewCompositionalLayout { _, _ in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1.0)
            )
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.3)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 30, trailing: 10)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
        return layOut
    }
}

extension HomePageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.homePageCollectionView.dequeueReusableCell(
            withReuseIdentifier: homePageCollectionViewIdentifier, for: indexPath)
                as? HomePageCollectionViewCell else { return UICollectionViewCell() }
        cell.getData(dataSet: self.apiData, index: indexPath.row)

        return cell
    }
    @objc private func didTapSignUpPage() {
        let signupVC = SignupViewController()
        self.navigationController?.pushViewController(signupVC, animated: true)
    }
}

extension HomePageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let titleSets = ["櫃買指數", "寶島指數", "臺灣 50", "加權指數", "加權報酬指數"]
        let stockVC = StockDayViewController()
        stockVC.navigationTitle = titleSets[indexPath.item]
        self.navigationController?.pushViewController(stockVC, animated: true)
    }
}
