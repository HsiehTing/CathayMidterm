//
//  newsPageViewController.swift
//  MidtermProject
//
//  Created by TWINB00599242 on 2025/4/29.
//

import UIKit

class NewsPageViewController: UIViewController, FetchNewsAPIDelegate {
    private let apiTool = FetchNewsAPITool()
    private let urlString = "https://openapi.twse.com.tw/v1/news/newsList"
    private let newsPageCollectionViewIdentifier = "newsPageCollectionViewCell"
    private var newsArray: [NewsAPIModel] = []
    private let sortButton = UIButton()
    private let sortLabel = UILabel()
    private let sortStack = UIStackView()
    private let newsPageCollectionView = UICollectionView(
        frame: .zero, collectionViewLayout: configFlowLayout()
    )
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        configAutoLayout()
        setNavigationTitile()
        fetchAPI()
        configAPI()
        apiTool.dataTAsk(urlString: urlString)
    }
    private func configAPI() {
        apiTool.delegate = self
    }
    private func fetchAPI() {
        apiTool.dataTAsk(urlString: urlString)
    }
    func passData(data: [NewsAPIModel]) {
        self.newsArray = data
        DispatchQueue.main.async {
            self.newsPageCollectionView.reloadData()
        }
    }
    private func configView() {
        configCollectionView()
        configSortStackView()
        configSortButtonView()
        configSortLabel()
    }
    private func configCollectionView() {
        view.addSubview(newsPageCollectionView)
        newsPageCollectionView.register(NewsPageCollectionviewCell.self,
                                        forCellWithReuseIdentifier: newsPageCollectionViewIdentifier)
        newsPageCollectionView.delegate = self
        newsPageCollectionView.dataSource = self
    }
    private func configSortButtonView() {
        sortButton.addTarget(self, action: #selector(didTapSortButton), for: .touchUpInside)
        sortButton.setImage(UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
        sortButton.setImage(UIImage(systemName: "arrowtriangle.up.fill"), for: .selected)
        sortButton.tintColor = .black
    }
    private func configSortStackView() {
        view.addSubview(sortStack)
        sortStack.insertArrangedSubview(sortLabel, at: 0)
        sortStack.insertArrangedSubview(sortButton, at: 1)
        sortStack.axis = .horizontal
        sortStack.distribution = .fillProportionally
    }
    
    private func configSortLabel() {
        sortLabel.textColor = .lightGray
        sortLabel.text = "由新至舊"
    }
    private func setNavigationTitile() {
        navigationItem.title = "新聞"
    }
    private func configAutoLayout() {
        sortStack.translatesAutoresizingMaskIntoConstraints = false
        newsPageCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        sortButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
        sortButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
        sortStack.heightAnchor.constraint(equalToConstant: 44),
        newsPageCollectionView.topAnchor.constraint(equalTo: sortStack.bottomAnchor, constant: 15),
        newsPageCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
        newsPageCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
        newsPageCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -15)
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
                heightDimension: .fractionalHeight(0.3)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 20, trailing: 10)
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
        return layOut
    }
    @objc func didTapSortButton() {
        self.sortButton.isSelected.toggle()
        self.newsArray = newsArray.reversed()
        self.newsPageCollectionView.reloadData()
        if sortButton.isSelected == true {
            self.sortLabel.text = "由舊至新"
        } else {
            self.sortLabel.text = "由新至舊"
        }
    }
}

extension NewsPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        newsArray.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = newsPageCollectionView.dequeueReusableCell(
            withReuseIdentifier: newsPageCollectionViewIdentifier,
            for: indexPath) as? NewsPageCollectionviewCell else { return UICollectionViewCell() }
        cell.getData(cellData: newsArray, index: indexPath.item)
        return  cell
    }
}

extension NewsPageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newsData = newsArray[indexPath.item]
        let webVC = NewsWebPageViewController()
        webVC.urlString = newsData.url
        self.navigationController?.pushViewController(webVC, animated: true)
    }
}
