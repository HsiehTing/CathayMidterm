//
//  FetchAPIDelegate.swift
//  MidtermProject
//
//  Created by TWINB00599242 on 2025/5/2.
//
import UIKit

protocol FetchNewsAPIDelegate {
    func passData(data: [NewsAPIModel])
}

class FetchNewsAPITool {
    
    var delegate: FetchNewsAPIDelegate?
    func dataTAsk(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error as Any)
                return
            }
            
            do {
                if let data = data {
                    let decodedData = try JSONDecoder().decode([NewsAPIModel].self, from: data)
                    self.delegate?.passData(data: decodedData)
                }
            } catch {
                print("decoded failed")
            }
        }
        .resume()
    }
}
