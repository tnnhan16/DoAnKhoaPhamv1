//
//  Register_Service.swift
//  CQuiz2021
//
//  Created by CuscSoftware on 09/06/2021.
//

import Foundation
//class Joining_Service {
//    static func join() ->String {
//        let url = URL(string:  AppConstant.joinUrl)
//        let boundary = UUID().uuidString
//        let session = URLSession.shared
//        
////        var urlRequest = URLRequest(url: url!)
////        urlRequest.httpMethod = "POST"
////        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//        
////        var data = Data()
////        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
////        data.append("Content-Disposition: form-data; name=\"\(fileName)\"; filename=\"\(fileName).png\"\r\n".data(using: .utf8)!)
////        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
////        data.append(dataFile)
////        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
//        
////        var result:String = ""
////        session.dataTask(with: urlRequest) { responseData, responseNum, err in
////            if err == nil {
////                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
////                if let json = jsonData as? [String: Any]{
////                    print(json)
////                    result = "S"
////                }
////            } else {
////                result = "F"
////            }
////            }).resume()
////        return result
//    }
//}
