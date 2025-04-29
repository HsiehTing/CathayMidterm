//
//  TextFieldValidation.swift
//  MidtermProject
//
//  Created by TWINB00599242 on 2025/4/29.
//

import UIKit

extension UITextField {
    
    func isDigitSafe(with word: String) -> Bool {
        
        guard let text = self.text, !text.isEmpty else {
            print("no digits yet")
            return false
        }
        guard let text = self.text, text.count < 16 else {
            print(" digits should be no more than 16")
            return false
        }
        guard let text = self.text, text.count > 8 else {
            print(" digits should be no less than 8")
            return false
        }
        return true
    }
    
}
