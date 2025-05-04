//
//  StockDayHeaderViewCell.swift
//  MidtermProject
//
//  Created by TWINB00599242 on 2025/5/1.
//

import UIKit

class StockDayColectionViewHeaderViewCell: UICollectionReusableView {
    public var titleArray: [String] = ["代號", "名稱", "價格", "價格變動", "變動比例", "自選"]
    private let stackView = UIStackView()
    private var firstLabel = UILabel()
    private let secondLabel = UILabel()
    private let thirdLabel = UILabel()
    private let fourthLabel = UILabel()
    private let fifthLabel = UILabel()
    private let starButtonLabel = UILabel()
    private let defaults = UserDefaults.standard
    override init(frame: CGRect) {
        super.init(frame: frame)
        configView()
        configViewAutoLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    open func getHeaderData(titleArray: [String]) {
        self.titleArray = titleArray
        updateLabelContent()
    }
    private func updateLabelContent() {
        self.firstLabel.text = titleArray[0]
        self.secondLabel.text = titleArray[1]
        self.thirdLabel.text = titleArray[2]
        self.fourthLabel.text = titleArray[3]
        self.fifthLabel.text = titleArray[4]
        self.starButtonLabel.text = titleArray[5]
    }
    private func configView() {
        configStackView()
    }
    private func configStackView() {
        self.addSubview(stackView)
        stackView.insertArrangedSubview(firstLabel, at: 0)
        stackView.insertArrangedSubview(secondLabel, at: 1)
        stackView.insertArrangedSubview(thirdLabel, at: 2)
        stackView.insertArrangedSubview(fourthLabel, at: 3)
        stackView.insertArrangedSubview(fifthLabel, at: 4)
        stackView.insertArrangedSubview(starButtonLabel, at: 5)
        firstLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        secondLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        thirdLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        fourthLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        fifthLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        starButtonLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
    }
    private func configViewAutoLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        thirdLabel.translatesAutoresizingMaskIntoConstraints = false
        fourthLabel.translatesAutoresizingMaskIntoConstraints = false
        fifthLabel.translatesAutoresizingMaskIntoConstraints = false
        starButtonLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            firstLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.15),
            secondLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.3),
            thirdLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.15),
            fourthLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.15),
            fifthLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.15),
            starButtonLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.1)
        ])
    }
}
