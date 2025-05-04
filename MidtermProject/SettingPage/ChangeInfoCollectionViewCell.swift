//
//  ChangeInfoCollectionViewCell.swift
//  MidtermProject
//
//  Created by TWINB00599242 on 2025/5/3.
//

import UIKit

class ChangeInfoCollectionViewCell: UICollectionViewCell {
    private let questionLabel = UILabel()
    private let inputTextField = UITextField()
    private let stackView = UIStackView()
    private let underlineView = UIView()
    private let confirmButton = UIButton()
    public var questionSet: [String]?
    public var index: Int?
    var delegate: ChangeInfoDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        configView()
        configStackView()
        configLabel()
        configTextField()
        configAutoLayout()
        setupUnderline()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.inputTextField.setUnderLine()
    }
    func getData(questionSet: [String], index: Int) {
        self.questionSet = questionSet
        self.index = index
        configLabel()
        inputTextField.addTarget(self, action: #selector(textfieldDidEndEditing(_:)), for: .editingDidEnd)
    }
    private func configView() {
        self.addSubview(stackView)
        self.addSubview(confirmButton)
    }
    private func configStackView() {
        stackView.addArrangedSubview(questionLabel)
        stackView.addArrangedSubview(inputTextField)
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 20
        self.questionLabel.font = .systemFont(ofSize: 24)
    }
    func configTextField() {
        inputTextField.keyboardType = .asciiCapable
        inputTextField.autocapitalizationType = .none
        inputTextField.spellCheckingType = .no
        inputTextField.autocorrectionType = .no
    }
    private func configLabel() {
        guard let questionSet = questionSet else { return }
        guard let index = index else { return }

        self.questionLabel.text = questionSet[index]
        self.questionLabel.font = .systemFont(ofSize: 24)
    }
    private func configAutoLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            questionLabel.widthAnchor.constraint(equalToConstant: 220),
            inputTextField.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
    private func setupUnderline() {
           underlineView.backgroundColor = .black
           underlineView.isUserInteractionEnabled = false
           self.addSubview(underlineView)
    }
    @objc func textfieldDidEndEditing(_ textField: UITextField) {
        guard let text = inputTextField.text else { return }
        guard let questionSet = questionSet else { return }
        guard let index = index else { return }
        self.delegate?.passInfo(info: text, question: questionSet[index])

    }
}
