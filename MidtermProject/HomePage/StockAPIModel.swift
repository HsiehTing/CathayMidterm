//
//  StockAPIModel.swift
//  MidtermProject
//
//  Created by TWINB00599242 on 2025/4/30.
//

protocol StockAPIDataProtocol {
    var code: String { get }
    var name: String { get }
}

struct StockAPIDay: Codable {
    let code: String
    let name: String
    let closingPrice: String
    let change: String
    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case name = "Name"
        case closingPrice = "ClosingPrice"
        case change = "Change"
    }
}
extension StockAPIDay: StockAPIDataProtocol {
}

struct StockAPIMonthYear: Codable {
    let code: String
    let name: String
    let highestPrice: String
    let lowestPrice: String
    let transaction: String
    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case name = "Name"
        case highestPrice = "HighestPrice"
        case lowestPrice = "LowestPrice"
        case transaction = "Transaction"
    }
}
extension StockAPIMonthYear: StockAPIDataProtocol {
}
