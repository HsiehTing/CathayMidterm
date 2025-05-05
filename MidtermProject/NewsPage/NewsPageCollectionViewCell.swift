//
//  newsPageCollectionViewCell.swift
//  MidtermProject
//
//  Created by TWINB00599242 on 2025/5/2.
//
import UIKit

class NewsPageCollectionviewCell: UICollectionViewCell {
    private let shareButton = UIButton()
    private let dateLabel = UILabel()
    private let titleLabel = UILabel()
    private var cellData: NewsAPIModel?
    override init(frame: CGRect) {
        super.init(frame: frame)
        configView()
        configAutoLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func getData(cellData: [NewsAPIModel], index: Int) {
        self.cellData = cellData[index]
        updateLabel()
    }
    private func updateLabel() {
        guard let data = cellData else { return }
        self.dateLabel.text = convertToROCDate(string: data.date)
        self.titleLabel.text = data.title
    }
    private func convertToROCDate(string: String) -> String {
        let yearString = String(string.prefix(3))
        let monthString = String(string.dropFirst(3).prefix(2))
        let dayString = String(string.suffix(2))
        let month = Int(monthString) ?? 0
        let day = Int(dayString) ?? 0
        return "民國 \(yearString) 年 \(month) 月 \(day) 日"
    }
    private func configView() {
        self.addSubview(shareButton)
        self.addSubview(dateLabel)
        self.addSubview(titleLabel)
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up.circle"), for: .normal)
        shareButton.tintColor = .black
        dateLabel.textColor = .black
        dateLabel.font = .systemFont(ofSize: 12, weight: .regular)
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        dateLabel.numberOfLines = 0
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
    }
    private func configAutoLayout() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            dateLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            dateLabel.widthAnchor.constraint(equalToConstant: 200 ),
            dateLabel.heightAnchor.constraint(equalToConstant: 24 ),
            shareButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            shareButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            shareButton.widthAnchor.constraint(equalToConstant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            titleLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 5),
            titleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            titleLabel.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
}
