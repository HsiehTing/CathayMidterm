//
//  StockDayCollectionViewCell.swift
//  MidtermProject
//
//  Created by TWINB00599242 on 2025/4/30.
//

import UIKit

class StockDayCollectionViewCell: UICollectionViewCell {
    private var cellData: CellData?
    private var index: Int?
    private let firstLabel = UILabel()
    private let secondLabel = UILabel()
    private let thirdLabel = UILabel()
    private let fourthLabel = UILabel()
    private let fifthLabel = UILabel()
    private let stackView = UIStackView()
    private let starButton = UIButton(type: .custom)
    private var selectedItems: [String]?
    public var starButtonAppendCallBack: ((String) -> Void)?
    public var starButtonRemoveCallBack: ((String) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configView()
        configColor()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    open func getData(cellData: CellData, selectedItems: [String], index: Int) {
        self.selectedItems = selectedItems
        self.cellData = cellData
        self.index = index
        setUpLabelText()
        setUpStarButton()
        configColor()
    }
    private func configView() {
        self.addSubview(stackView)
        configStackView()
        configStackViewAutoLayout()
        setUpStarButton()
    }
    private func setUpStarButton() {
        guard let index = self.index else { return }
        guard let selectedItems = self.selectedItems else { return }
        starButton.addTarget(self, action: #selector(didTapStarButton), for: .touchUpInside)
        switch cellData {
        case .day(let data):
            if selectedItems.contains(where: { $0 == data[index].code }) {
                self.starButton.isSelected = true
            } else {
                self.starButton.isSelected = false
            }
        case .monthOrYear(let data):
            if selectedItems.contains(where: { $0 == data[index].code }) {
                self.starButton.isSelected = true
            } else {
                self.starButton.isSelected = false
            }
        default:
                self.starButton.isSelected = false
        }
    }
    private func setUpLabelText() {
        guard let index = self.index else { return }
        switch cellData {
        case .day(let dayData):
            guard
                   let value = Float(dayData[index].closingPrice),
                   let change = Float(dayData[index].change)
               else {
                   return
               }

            let changeRate = (change/(value - change)) * 100
            let roundedChangeRate = (changeRate * 100).rounded() / 100
            let formatter = NumberFormatter()
            formatter.minimumIntegerDigits = 1
            formatter.maximumFractionDigits = 2
            formatter.numberStyle = .decimal
            firstLabel.text = dayData[index].code
            secondLabel.text = dayData[index].name
            thirdLabel.text = dayData[index].closingPrice
            fourthLabel.text = "\(change)"
            fifthLabel.text = "\(roundedChangeRate)%"
        case.monthOrYear(let monthYearData):
            firstLabel.text = monthYearData[index].code
            secondLabel.text = monthYearData[index].name
            thirdLabel.text = monthYearData[index].highestPrice
            fourthLabel.text = monthYearData[index].lowestPrice
            fifthLabel.text = monthYearData[index].transaction
        default:
            firstLabel.text = "error"
            secondLabel.text = "error"
            thirdLabel.text = "error"
            fourthLabel.text = "error"
            fifthLabel.text = "error"
        }
    }
    private func configColor() {
        switch cellData {
        case .day(let data):
            guard let index = self.index else { return }
            guard let change = Float(data[index].change) else { return }
                    if change > 0 {
                        self.firstLabel.textColor = .red
                        self.secondLabel.textColor = .red
                        self.thirdLabel.textColor = .red
                        self.fourthLabel.textColor = .red
                        self.fifthLabel.textColor = .red
                    }
        default:
            break
        }
    }
    private func configStackView() {
        let starImage = UIImage(systemName: "star")?.withRenderingMode(.alwaysTemplate)
        let starFillImage = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
        stackView.insertArrangedSubview(firstLabel, at: 0)
        stackView.insertArrangedSubview(secondLabel, at: 1)
        stackView.insertArrangedSubview(thirdLabel, at: 2)
        stackView.insertArrangedSubview(fourthLabel, at: 3)
        stackView.insertArrangedSubview(fifthLabel, at: 4)
        stackView.insertArrangedSubview(starButton, at: 5)
        firstLabel.font = .systemFont(ofSize: 12, weight: .medium)
        secondLabel.font = .systemFont(ofSize: 12, weight: .medium)
        thirdLabel.font = .systemFont(ofSize: 12, weight: .medium)
        fourthLabel.font = .systemFont(ofSize: 12, weight: .medium)
        fifthLabel.font = .systemFont(ofSize: 12, weight: .medium)
        firstLabel.textColor = .green
        secondLabel.textColor = .green
        thirdLabel.textColor = .green
        fourthLabel.textColor = .green
        fifthLabel.textColor = .green
        starButton.setImage(starImage, for: .normal)
        starButton.setImage(starFillImage, for: .selected)
        starButton.tintColor = .systemYellow
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
    }
    private func configStackViewAutoLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        thirdLabel.translatesAutoresizingMaskIntoConstraints = false
        fourthLabel.translatesAutoresizingMaskIntoConstraints = false
        fifthLabel.translatesAutoresizingMaskIntoConstraints = false
        starButton.translatesAutoresizingMaskIntoConstraints = false
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
            starButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.1)
        ])
    }
    @objc private func didTapStarButton() {
        starButton.isSelected.toggle()
        guard let code = self.firstLabel.text else { return }
        if starButton.isSelected {
            starButtonAppendCallBack?(code)
        } else {
            starButtonRemoveCallBack?(code)
        }
    }
}
