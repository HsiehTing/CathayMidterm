//
//  APIFetchTool.swift
//  MidtermProject
//
//  Created by TWINB00599242 on 2025/4/29.
//
import UIKit

protocol FetchAPIDelegate {
    func passData(data: [APIDataProtocol])
}

class APIFetchTool {
    
    var delegate: FetchAPIDelegate?
    func dataTAsk(urlString: String, index: Int) {
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error as Any)
                return
            }
            
            do {
                if let data = data {
                    switch index {
                    case 0:
                         let decodedData = try JSONDecoder().decode([IndexData].self, from: data)
                        guard let lastData = decodedData.last else { return }
                        let last2Data = decodedData[decodedData.count - 2]
                        self.delegate?.passData(data: [lastData, last2Data])
                    case 1:
                        let decodedData = try JSONDecoder().decode([FRMSAData].self, from: data)
                        guard let lastData = decodedData.last else { return }
                        let last2Data = decodedData[decodedData.count - 2]
                        self.delegate?.passData(data: [lastData, last2Data])
                            
                    case 2:
                        let decodedData = try JSONDecoder().decode([TAI50I].self, from: data)
                        guard let lastData = decodedData.last else { return }
                        let last2Data = decodedData[decodedData.count - 2]
                        self.delegate?.passData(data: [lastData, last2Data])
                    case 3:
                        let decodedData = try JSONDecoder().decode([HIST].self, from: data)
                        guard let lastData = decodedData.last else { return }
                        let last2Data = decodedData[decodedData.count - 2]
                        self.delegate?.passData(data: [lastData, last2Data])
                    case 4:
                        let decodedData = try JSONDecoder().decode([MFI94U].self, from: data)
                        guard let lastData = decodedData.last else { return }
                        let last2Data = decodedData[decodedData.count - 2]
                        self.delegate?.passData(data: [lastData, last2Data])
                    default:
                        let decodedData = try JSONDecoder().decode([IndexData].self, from: data)
                        guard let lastData = decodedData.last else { return }
                        let last2Data = decodedData[decodedData.count - 2]
                        self.delegate?.passData(data: [lastData, last2Data])
                    }
                }
            } catch {
                print("decoded failed")
            }
        }
        .resume()
    }
}
