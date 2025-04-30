//
//  HomePageCollectionViewCell.swift
//  MidtermProject
//
//  Created by TWINB00599242 on 2025/4/29.
//
import UIKit

class HomePageCollectionViewCell: UICollectionViewCell, FetchAPIDelegate {
    
    private let titleSets = ["櫃買指數", "寶島指數", "臺灣 50", "加權指數", "加權報酬指數"]
    private var index: Int?
    private var color = UIColor()
    private var apiData: [String: Any] = [:]
    private let indexTitleLabel = UILabel()
    private let indexValueLabel = UILabel()
    private let changeLabel = UILabel()
    private let stackView = UIStackView()
    private let apiTool = APIFetchTool()
    private let urlStringSet = [
        "https://openapi.twse.com.tw/v1/exchangeReport/MI_INDEX4",
        "https://openapi.twse.com.tw/v1/indicesReport/FRMSA",
        "https://openapi.twse.com.tw/v1/indicesReport/TAI50I",
        "https://openapi.twse.com.tw/v1/indicesReport/MI_5MINS_HIST",
        "https://openapi.twse.com.tw/v1/indicesReport/MFI94U"
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configView()
        configAutoLayout()
        apiTool.delegate = self
        DispatchQueue.main.async {
            guard let index = self.index else { return }
            self.apiTool.dataTAsk(urlString: self.urlStringSet[index], index: index)
            self.reloadInputViews()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func passData(data: [APIDataProtocol]) {
        switch index {
        case 0:
            
            DispatchQueue.main.async {
                self.setUpColor(data: data)
            }
            
        case 1:
            guard let data = data as? [FRMSAData] else { return }
            
            DispatchQueue.main.async {
                self.setUpColor(data: data)
            }
            
        case 2:
            guard let data = data as? [TAI50I] else { return }
            
            DispatchQueue.main.async {
                self.setUpColor(data: data)
            }
            
        case 3:
            guard let data = data as? [HIST] else { return }
            
            DispatchQueue.main.async {
                self.setUpColor(data: data)
            }
            
        case 4:
            guard let data = data as? [MFI94U] else { return }
            
            DispatchQueue.main.async {
                self.setUpColor(data: data)
            }
            
        default:
            guard let data = data as? [IndexData] else { return }
            
            DispatchQueue.main.async {
                self.setUpColor(data: data)
            }
            
        }
        
    }
    
    func getData(dataSet: [String: Any] , index: Int) {
        //TODO: 要用 switch 來轉換格式
        self.index = index

    }
    
    func setUpColor(data: [APIDataProtocol]) {
        guard let secondIndex = Double(data[1].indexValue) else { return }
        guard let lastIndex = Double(data[0].indexValue) else { return }
        guard let index = index else { return }
        let indexTitle = titleSets[index]
        self.indexValueLabel.text = data[0].indexValue
        self.indexTitleLabel.text = indexTitle
        let changeInt = (lastIndex - secondIndex).rounded()
        let changeRate = ((lastIndex - secondIndex) / secondIndex) * 100
        let roundedChangeRate = (changeRate * 100).rounded() / 100
            if roundedChangeRate >= 0 {
                self.changeLabel.textColor = .red
                self.indexTitleLabel.textColor = .red
                self.indexValueLabel.textColor = .red
                self.changeLabel.text = "+\(changeInt) (\(roundedChangeRate)) ↑"
                self.layer.borderColor = UIColor.red.cgColor
            } else {
                self.changeLabel.textColor = .green
                self.indexTitleLabel.textColor = .green
                self.indexValueLabel.textColor = .green
                self.changeLabel.text = "-\(changeInt) (\(roundedChangeRate)) ↓"
                self.layer.borderColor = UIColor.green.cgColor
                
            }
        
    }
    
    func configView() {
        self.addSubview(indexTitleLabel)
        self.addSubview(stackView)
        stackView.addArrangedSubview(indexValueLabel)
        stackView.addArrangedSubview(changeLabel)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        self.indexValueLabel.font = .systemFont(ofSize: 24)
        self.changeLabel.font = .systemFont(ofSize: 12)
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 1
    }
    
    func configAutoLayout() {
        
        indexTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            indexTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            indexTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: indexTitleLabel.bottomAnchor, constant: 25),
        ])
        
    }
    
}
