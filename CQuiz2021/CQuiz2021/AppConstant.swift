//
//  AppConstant.swift
//  CQuiz2021
//
//  Created by CuscSoftware on 09/06/2021.
//

import Foundation
class AppConstant {
    public static var baseHost = "http://192.168.233.1:3030"
//    public static var baseHost = "https://doankhoapham.herokuapp.com"
    public static var baseURL = "\(baseHost)/api/"
    public static var uploadAvatarUrl =  "\(baseURL)uploadFile"
    public static var joinUrl = "\(baseURL)join"
    public static var getUrlImageQuestionUrl = "\(baseHost)/upload/"
    
}
