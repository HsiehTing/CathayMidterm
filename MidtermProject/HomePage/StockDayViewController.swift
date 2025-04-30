//
//  StockDayViewCOntroller.swift
//  MidtermProject
//
//  Created by TWINB00599242 on 2025/4/30.
//

import UIKit

//TODO: collectionView 加上 header 寫上標題資訊
//TODO: 每進一次頁面都要打 API 既然已經快取了 可以判斷是否快取有資料後再打
//TODO: 畫面下面空格消除
//TODO: 顯示出api 資訊，並且透過不同的下拉選單來切換

class StockDayViewController: UIViewController {
    
    private let stockInfoArray: [StockAPIDataProtocol] = []
    private let stockDayCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configFlowLayout())
    private let stockCollectionViewReuseIdentifier = "stockCollectionViewReuseIdentifier"
    private let apiTool = StockAPIFetchTool()
    private let dropDownButton = UIButton(type: .custom)
    private let segmentedControl = UISegmentedControl()
    
    var navigationTitle: String?
    private let apiURL: [String] = [
        "https://openapi.twse.com.tw/v1/exchangeReport/STOCK_DAY_ALL",
        "https://openapi.twse.com.tw/v1/exchangeReport/FMSRFK_ALL",
        "https://openapi.twse.com.tw/v1/exchangeReport/FMNPTK_ALL"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        configNavigationTitle()
        configToolBarButton()
        fetchAPI()
        configAutoLayout()
    }
    
    private func fetchAPI() {
        fetchDayAPI()
        fetchMonthAPI()
        fetchYearAPI()
    }
    
    private func fetchDayAPI() {
        self.apiTool.dataTAsk(urlString: self.apiURL[0], index: 0) { data in
            guard let data = data else { return }
            
            do {
                let decodedData = try JSONDecoder().decode([StockAPIDay].self, from: data)
                DispatchQueue.main.async {
                    print("data 1 count \(decodedData.count)")
                }
            } catch {
                print("decoded failed")
            }
        }
    }
    
    private func fetchMonthAPI() {
        self.apiTool.dataTAsk(urlString: self.apiURL[1], index: 1) { data in
            guard let data = data else { return }
            
            do {
                let decodedData = try JSONDecoder().decode([StockAPIMonthYear].self, from: data)
                DispatchQueue.main.async {
                    print("data 2 count \(decodedData.count)")
                }
            } catch {
                print("decoded failed 2 \(error)")
            }
        }
    }
    
    private func fetchYearAPI() {
        self.apiTool.dataTAsk(urlString: self.apiURL[2], index: 2) { data in
            guard let data = data else { return }
            do {
                let decodedData = try JSONDecoder().decode([StockAPIMonthYear].self, from: data)
                DispatchQueue.main.async {
                    print("data 3 count \(decodedData.count)")
                }
            } catch {
                print("decoded failed 3 \(error)")
            }
        }
        self.reloadInputViews()
    }
    
    private func configView() {
        congfigCollectionView()
        configDropDownButton()
        configSegmentControl()
    }
    
    private func congfigCollectionView() {
        view.addSubview(stockDayCollectionView)
        stockDayCollectionView.register(StockDayCollectionViewCell.self, forCellWithReuseIdentifier: stockCollectionViewReuseIdentifier)
        stockDayCollectionView.delegate = self
        stockDayCollectionView.dataSource = self
        stockDayCollectionView.backgroundColor = .red
    }
    
    private func configDropDownButton() {
        view.addSubview(dropDownButton)
        var buttonTitleString = "個股日成交量"
        dropDownButton.setTitle(buttonTitleString, for: .normal)
        dropDownButton.showsMenuAsPrimaryAction = true
        dropDownButton.backgroundColor = .darkGray
        dropDownButton.menu = UIMenu(children: [
            UIAction(title: "個股日成交量", handler: { action in
                let title = "個股日成交量"
                self.navigationItem.title = title
                self.dropDownButton.setTitle(title, for: .normal)
            }),
            UIAction(title: "個股月成交量", handler: { action in
                let title = "個股月成交量"
                self.navigationItem.title = title
                self.dropDownButton.setTitle(title, for: .normal)
            }),
            UIAction(title: "個股年成交量", handler: { action in
                let title = "個股年成交量"
                self.navigationItem.title = title
                self.dropDownButton.setTitle(title, for: .normal)
            }),
        ])
    }
    
    private func configSegmentControl() {
        view.addSubview(segmentedControl)
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "全部", at: 1, animated: false)
        segmentedControl.insertSegment(withTitle: "自選", at: 2, animated: false)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .clear
        segmentedControl.tintColor = .clear
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "HelveticaNeue", size: 18),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
            ], for: .normal)
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "HelveticaNeue", size: 18),
            NSAttributedString.Key.foregroundColor: UIColor.black
            ], for: .selected)

    }
    
    private func configNavigationTitle() {
        self.navigationItem.title = navigationTitle
    }
    
    static func configFlowLayout() -> UICollectionViewCompositionalLayout {
        
        let layOut = UICollectionViewCompositionalLayout { _, _ in
            
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.1)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 6)
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
        return layOut
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
    
    private func configAutoLayout() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        dropDownButton.translatesAutoresizingMaskIntoConstraints = false
        stockDayCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dropDownButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            dropDownButton.widthAnchor.constraint(equalToConstant: 220),
            dropDownButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            segmentedControl.topAnchor.constraint(equalTo: dropDownButton.bottomAnchor, constant: 20),
            segmentedControl.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: 60),
            segmentedControl.widthAnchor.constraint(equalToConstant: 160),
            segmentedControl.heightAnchor.constraint(equalToConstant: 25),
            stockDayCollectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 30),
            stockDayCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stockDayCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stockDayCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc private func didTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension StockDayViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        stockInfoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = stockDayCollectionView.dequeueReusableCell(withReuseIdentifier: stockCollectionViewReuseIdentifier, for: indexPath) as? StockDayCollectionViewCell else { return UICollectionViewCell()}
        
        return cell
    }
    
}

extension StockDayViewController: UICollectionViewDelegate {
    
}
