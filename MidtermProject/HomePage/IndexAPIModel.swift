//
//  IndexAPIModel.swift
//  MidtermProject
//
//  Created by TWINB00599242 on 2025/4/30.
//

protocol APIDataProtocol {
    var indexValue: String { get }
}

struct IndexData: Codable {
    let date: String
    let tradeValue: String
    let formosaIndex: String
    let change: String
    
    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case tradeValue = "TradeValue"
        case formosaIndex = "FormosaIndex"
        case change = "Change"
    }
}

extension IndexData: APIDataProtocol {
    var indexValue: String {
        formosaIndex
    }
}

struct FRMSAData: Codable {
    let date: String
    let formosaIndex: String
    let formosaTotalReturnIndex: String
    
    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case formosaIndex = "FormosaIndex"
        case formosaTotalReturnIndex = "FormosaTotalReturnIndex"
    }
}

extension FRMSAData: APIDataProtocol {
    var indexValue: String {
        formosaIndex
    }
}

struct TAI50I: Codable {
    let date: String
    let taiwan50Index: String
    let taiwan50TotalReturnIndex: String
    
    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case taiwan50Index = "Taiwan50Index"
        case taiwan50TotalReturnIndex = "Taiwan50TotalReturnIndex"
    }
}
extension TAI50I: APIDataProtocol {
    var indexValue: String {
        taiwan50Index
    }
}

struct HIST: Codable {
    let date: String
    let openingIndex: String
    let highestIndex: String
    let lowestIndex: String
    let closingIndex: String
    
    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case openingIndex = "OpeningIndex"
        case highestIndex = "HighestIndex"
        case lowestIndex = "LowestIndex"
        case closingIndex = "ClosingIndex"
    }
}
extension HIST: APIDataProtocol {
    var indexValue: String {
        closingIndex
    }
}

struct MFI94U: Codable {
    let date: String
    let taiEXTotalReturnIndex: String
    
    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case taiEXTotalReturnIndex = "TAIEXTotalReturnIndex"

    }
}
extension MFI94U: APIDataProtocol {
    var indexValue: String {
        taiEXTotalReturnIndex
    }
}
