//
//  StockDayViewCOntroller.swift
//  MidtermProject
//
//  Created by TWINB00599242 on 2025/4/30.
//

import UIKit

class StockDayViewController: UIViewController {
    private let stockDayCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configFlowLayout())
    private let stockCollectionViewReuseIdentifier = "stockCollectionViewReuseIdentifier"
    private let stockCollectionHeaderViewReuseIdentifier = "stockCollectionHeaderViewReuseIdentifier"
    private let apiTool = StockAPIFetchTool.shared
    private let dropDownButton = UIButton(type: .custom)
    private let segmentedControl = UISegmentedControl()
    private let cell = StockDayCollectionViewCell()
    private let apiURL: [String] = [
        "https://openapi.twse.com.tw/v1/exchangeReport/STOCK_DAY_ALL",
        "https://openapi.twse.com.tw/v1/exchangeReport/FMSRFK_ALL",
        "https://openapi.twse.com.tw/v1/exchangeReport/FMNPTK_ALL"
    ]
    private var headerTitleArray: [String] = ["代號", "名稱", "價格", "價格變動", "變動比例", "自選"]
    private var selectedItems = {
        UserDefaults.standard.stringArray(forKey: "selectedItems")
    }() ?? []
    public var cellData: CellData?
    public var filteredCellData: CellData?
    public var navigationTitle: String?
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
    }
    private func fetchDayAPI() {
        self.apiTool.dataTask(urlString: self.apiURL[0], index: 0) { data in
            guard let data = data else { return }
            do {
                let decodedData = try JSONDecoder().decode([StockAPIDay].self, from: data)
                DispatchQueue.main.async {
                    print("data 1 count \(decodedData.count)")
                    self.cellData = .day(decodedData)
                    self.filteredCellData = self.cellData
                    self.headerTitleArray =  ["代號", "名稱", "價格", "價格變動", "變動比例", "自選"]
                    self.stockDayCollectionView.reloadData()
                }
            } catch {
                print("decoded failed")
            }
        }
    }
    private func fetchMonthAPI() {
        self.apiTool.dataTask(urlString: self.apiURL[1], index: 1) { data in
            guard let data = data else { return }
            do {
                let decodedData = try JSONDecoder().decode([StockAPIMonthYear].self, from: data)
                DispatchQueue.main.async {
                    print("data 2 count \(decodedData.count)")
                    self.cellData = .monthOrYear(decodedData)
                    self.filteredCellData = self.cellData
                    self.headerTitleArray =  ["代號", "名稱", "最高價格", "最低價格", "交易筆數", "自選"]
                    self.stockDayCollectionView.reloadData()
                }
            } catch {
                print("decoded failed 2 \(error)")
            }
        }
    }
    private func fetchYearAPI() {
        self.apiTool.dataTask(urlString: self.apiURL[2], index: 2) { data in
            guard let data = data else { return }
            do {
                let decodedData = try JSONDecoder().decode([StockAPIMonthYear].self, from: data)
                DispatchQueue.main.async {
                    print("data 3 count \(decodedData.count)")
                    self.cellData = .monthOrYear(decodedData)
                    self.filteredCellData = self.cellData
                    self.headerTitleArray =  ["代號", "名稱", "最高價格", "最低價格", "交易筆數", "自選"]
                    self.stockDayCollectionView.reloadData()
                }
            } catch {
                print("decoded failed 3 \(error)")
            }
        }
        self.reloadInputViews()
    }
    private func filterData(by code: String) {
        guard let cellData = self.cellData else { return }

        switch cellData {
        case .day(let data):
            let filtered = data.filter { $0.code.contains(code) }
            self.filteredCellData = .day(filtered)

        case .monthOrYear(let data):
            let filtered = data.filter { $0.code.contains(code) }
            self.filteredCellData = .monthOrYear(filtered)
        }
        stockDayCollectionView.reloadData()
    }
    private func configView() {
        congfigCollectionView()
        configDropDownButton()
        configSegmentControl()
    }
    private func congfigCollectionView() {
        view.addSubview(stockDayCollectionView)
        stockDayCollectionView.register(
            StockDayCollectionViewCell.self, forCellWithReuseIdentifier: stockCollectionViewReuseIdentifier)
        stockDayCollectionView.register(
            StockDayColectionViewHeaderViewCell.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                        withReuseIdentifier: stockCollectionHeaderViewReuseIdentifier)
        stockDayCollectionView.delegate = self
        stockDayCollectionView.dataSource = self
    }
    private func configDropDownButton() {
        view.addSubview(dropDownButton)
        dropDownButton.setTitle("個股日成交量", for: .normal)
        dropDownButton.showsMenuAsPrimaryAction = true
        dropDownButton.backgroundColor = .darkGray
        dropDownButton.menu = UIMenu(children: [
            UIAction(title: "個股日成交量", handler: { _ in
                let title = "個股日成交量"
                self.navigationItem.title = title
                self.dropDownButton.setTitle(title, for: .normal)
                self.fetchDayAPI()
            }),
            UIAction(title: "個股月成交量", handler: { _ in
                let title = "個股月成交量"
                self.navigationItem.title = title
                self.dropDownButton.setTitle(title, for: .normal)
                self.fetchMonthAPI()
            }),
            UIAction(title: "個股年成交量", handler: { _ in
                let title = "個股年成交量"
                self.navigationItem.title = title
                self.dropDownButton.setTitle(title, for: .normal)
                self.fetchYearAPI()
            })
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
        segmentedControl.addTarget(self, action: #selector(didTapSegmentControl(_:)), for: .valueChanged)
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
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(40)
            )
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5)
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 1)
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [sectionHeader]
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(
               barButtonSystemItem: .search,
               target: self,
               action: #selector(didTapSearchButton)
           )
        guard let rightButton = navigationItem.rightBarButtonItem else { return }
        rightButton.tintColor = .black
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
            segmentedControl.topAnchor.constraint(equalTo: dropDownButton.bottomAnchor,
                                                  constant: 20),
            segmentedControl.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor,
                                                      constant: 60),
            segmentedControl.widthAnchor.constraint(equalToConstant: 160),
            segmentedControl.heightAnchor.constraint(equalToConstant: 25),
            stockDayCollectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 30),
            stockDayCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stockDayCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stockDayCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    @objc private func didTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc private func didTapSegmentControl(_ sender: UISegmentedControl) {
        guard let cellData = self.cellData else { return }
        switch sender.selectedSegmentIndex {
        case 0:
            self.filteredCellData = cellData
        case 1:
            switch cellData {
            case .day(let data):
                let filtered = data.filter { selectedItems.contains($0.code) }
                self.filteredCellData = .day(filtered)
            case .monthOrYear(let data):
                let filtered = data.filter { selectedItems.contains($0.code) }
                self.filteredCellData = .monthOrYear(filtered)
            }
        default: break
        }
        stockDayCollectionView.reloadData()
    }
    @objc private func didTapSearchButton() {
        let alert = UIAlertController(title: "搜尋代號", message: "輸入股票代號", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "輸入代號..."
        }

        let searchAction = UIAlertAction(title: "搜尋", style: .default) { [weak self] _ in
            guard let self = self,
                  let code = alert.textFields?.first?.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                  !code.isEmpty else { return }

            self.filterData(by: code)
        }

        alert.addAction(searchAction)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        present(alert, animated: true)
    }

}

extension StockDayViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch filteredCellData {
        case .day(let dayData):
            return dayData.count
        case .monthOrYear(let monthYearData):
            return monthYearData.count
        default:
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = stockDayCollectionView.dequeueReusableCell(
            withReuseIdentifier: stockCollectionViewReuseIdentifier,
            for: indexPath) as? StockDayCollectionViewCell else { return UICollectionViewCell() }
        guard let filteredCellData = self.filteredCellData else { return UICollectionViewCell() }
        cell.getData(cellData: filteredCellData, selectedItems: selectedItems, index: indexPath.item)
        cell.starButtonAppendCallBack = { [weak self] code in
            guard let self = self else { return }
            self.selectedItems.append(code)
            UserDefaults.standard.set(self.selectedItems, forKey: "selectedItems")
            self.stockDayCollectionView.reloadData()
        }
        cell.starButtonRemoveCallBack = { [weak self] code in
            guard let self = self else { return }
            self.selectedItems = self.selectedItems.filter { $0 != code }
            UserDefaults.standard.set(self.selectedItems, forKey: "selectedItems")
            self.stockDayCollectionView.reloadData()
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind, withReuseIdentifier: stockCollectionHeaderViewReuseIdentifier, for: indexPath)
                    as? StockDayColectionViewHeaderViewCell else { return UICollectionReusableView() }
            headerView.getHeaderData(titleArray: self.headerTitleArray)
            return headerView
        } else {
            return UICollectionReusableView()
        }
    }
}

extension StockDayViewController: UICollectionViewDelegate {
}

enum CellData {
    case day([StockAPIDay])
    case monthOrYear([StockAPIMonthYear])
}
