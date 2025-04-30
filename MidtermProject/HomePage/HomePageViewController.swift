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
    private let apiTool = APIFetchTool()
    private var apiData: [String: Any] = [:]
    private let urlStringSet = [
        "https://openapi.twse.com.tw/v1/exchangeReport/MI_INDEX4",
        "https://openapi.twse.com.tw/v1/indicesReport/FRMSA",
        "https://openapi.twse.com.tw/v1/indicesReport/TAI50I",
        "https://openapi.twse.com.tw/v1/indicesReport/MI_5MINS_HIST",
        "https://openapi.twse.com.tw/v1/indicesReport/MFI94U"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitile()
        configView()
        configHomePageCollectionViewAutoLayout()
//        DispatchQueue.main.async {
//            self.apiTool.dataTAsk(urlString: self.urlStringSet[0])
//            self.homePageCollectionView.reloadData()
//        }
    }
    
    private func configView() {
        view.addSubview(homePageCollectionView)
        homePageCollectionView.register(HomePageCollectionViewCell.self, forCellWithReuseIdentifier: homePageCollectionViewIdentifier)
        homePageCollectionView.delegate = self
        homePageCollectionView.dataSource = self
    }
    
    private func setNavigationTitile() {
        navigationItem.title = "註冊新帳號"
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
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(150)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
            
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.homePageCollectionView.dequeueReusableCell(withReuseIdentifier: homePageCollectionViewIdentifier, for: indexPath) as? HomePageCollectionViewCell else { return UICollectionViewCell() }
        
        cell.getData(dataSet: self.apiData, index: indexPath.row)
        
        return cell
    }
    
    
}

extension HomePageViewController: UICollectionViewDelegate {
    
}

