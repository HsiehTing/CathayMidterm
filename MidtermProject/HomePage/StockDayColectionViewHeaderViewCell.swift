//
//  StockDayHeaderViewCell.swift
//  MidtermProject
//
//  Created by TWINB00599242 on 2025/5/1.
//

import UIKit

class StockDayColectionViewHeaderViewCell: UICollectionReusableView {
    
    private let stackView = UIStackView()
    private let firstLabel = UILabel()
    private let secondLabel = UILabel()
    private let thirdLabel = UILabel()
    private let fourthLabel = UILabel()
    private let fifthLabel = UILabel()
    private let starButtonLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configView()
        configViewAutoLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    open func getHeaderData(index: IndexPath) {
        updateLabelContent()
    }
    
    private func updateLabelContent() {
        
    }
    
    private func configStackView() {
        
    }
    
    private func configView() {
        
    }
    
    private func configViewAutoLayout() {
        
    }
    
    

    
}
