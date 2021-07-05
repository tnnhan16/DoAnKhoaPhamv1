//
//  AppConstant.swift
//  CQuiz2021
//
//  Created by CuscSoftware on 09/06/2021.
//

import Foundation
class AppConstant {
    public static var baseHost = "http://172.16.160.122:3030"
    public static var baseURL = "\(baseHost)/api/"
    public static var uploadAvatarUrl =  "\(baseURL)uploadFile"
    public static var joinUrl = "\(baseURL)join"
    public static var getUrlImageQuestionUrl = "\(baseHost)/upload/"
    
}
