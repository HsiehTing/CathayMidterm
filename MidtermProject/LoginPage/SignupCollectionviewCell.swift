//
//  SignupCollectionviewCell.swift
//  MidtermProject
//
//  Created by TWINB00599242 on 2025/4/28.
//

import UIKit

class SignupCollectionviewCell: UICollectionViewCell {

    var questionSets: [String] = []
    var index: Int = 0
    var delegate: SignupDelegate?
    private let questionLabel = UILabel()
    private let inputTextField = UITextField()
    private let stackView = UIStackView()
    private let underlineView = UIView()
    private let requirementLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.inputTextField.setUnderLine()
        configView()
        configAutoLayout()
        setupUnderline()
        configTextField()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.inputTextField.setUnderLine()
    }
    
    func getData(quesionSets: [String], index: Int) {
        self.questionSets = quesionSets
        self.index = index
        configLabel()
        if index == 0 || index == 1 {
            configRequirementLabel()
            inputTextField.addTarget(self, action: #selector(textfieldDidEndEditing_DigitSafe(_:)), for: .editingDidEnd)
        } else {
            inputTextField.addTarget(self, action: #selector(textfieldDidEndEditing(_:)), for: .editingDidEnd)
        }
        
    }
    
    func configTextField() {
        inputTextField.keyboardType = .asciiCapable
        inputTextField.autocapitalizationType = .none
        inputTextField.spellCheckingType = .no
        inputTextField.autocorrectionType = .no
    }
    
    @objc func textfieldDidEndEditing_DigitSafe(_ textField: UITextField) {
        
        guard let text = inputTextField.text else { return }
        
        guard inputTextField.isDigitSafe(with: text) else {
            self.requirementLabel.textColor = .red
            return
        }
        self.delegate?.passInfo(info: text, index: index)
        self.requirementLabel.textColor = .gray
    }
    
    @objc func textfieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = inputTextField.text else { return }
        
        self.delegate?.passInfo(info: text, index: index)
    }
    
    func configRequirementLabel() {
    
        requirementLabel.backgroundColor = .gray
        requirementLabel.text = "限 8-16 位英數字符號"
        requirementLabel.font = .systemFont(ofSize: 12)
        requirementLabel.textAlignment = .left
        requirementLabel.backgroundColor = .white
        requirementLabel.textColor = .gray
        requirementLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(requirementLabel)
        NSLayoutConstraint.activate([
            requirementLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            requirementLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            requirementLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            requirementLabel.widthAnchor.constraint(equalToConstant: 220),
            requirementLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configView() {
        self.addSubview(stackView)
        configStackView()
    }
    
    private func configStackView() {
        stackView.addArrangedSubview(questionLabel)
        stackView.addArrangedSubview(inputTextField)
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 20
        self.questionLabel.font = .systemFont(ofSize: 24)
    }
    
    private func configLabel() {
        self.questionLabel.text = questionSets[index]
        self.questionLabel.font = .systemFont(ofSize: 24)
    }
    
    private func configAutoLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
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
}
