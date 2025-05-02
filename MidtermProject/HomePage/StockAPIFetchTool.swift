//
//  StockAPIFetchTool.swift
//  MidtermProject
//
//  Created by TWINB00599242 on 2025/4/30.
//
import UIKit

protocol FetchStockAPIDelegate {
    func passData(data: [StockAPIDataProtocol])
}

class StockAPIFetchTool {
    
    public var delegate: FetchStockAPIDelegate?
    static let shared = StockAPIFetchTool()
    public let cache = NSCache<NSString, NSData>()
    
    func dataTask(urlString: String, index: Int, completion: @escaping (Data?) -> Void) {
        
        if let cachedData = cache.object(forKey: urlString as NSString) {
            print("快取資料")
            completion(cachedData as Data)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error as Any)
                return
            }
            
            if let data = data {
                self.cache.setObject(data as NSData, forKey: urlString as NSString)
                completion(data)
            } else {
                completion(nil)
            }
            
        }
        .resume()
    }
    
    func clearCache() {
        cache.removeAllObjects()
    }
}
