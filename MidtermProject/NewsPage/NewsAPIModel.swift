//
//  newsAPIModel.swift
//  MidtermProject
//
//  Created by TWINB00599242 on 2025/5/2.
//

struct NewsAPIModel : Codable {
    let title: String
    let url: String
    let date: String
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case url = "Url"
        case date = "Date"
    }
}
