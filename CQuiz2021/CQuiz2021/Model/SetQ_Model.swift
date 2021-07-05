////
////  Register_Model.swift
////  CQuiz2021
////
////  Created by CuscSoftware on 09/06/2021.
////
//
//import Foundation
//import SwiftyJSON
//
//class Player_Model {
//    public var _id:String?
//    public var setq_created_by:String?
//    public var setq_description:String?
//    public var setq_image:String?
//    public var setq_title:String?
//    public var setq_visibility:String?
//    
//    enum Key:String {
//        case _id = "_id"
//        case setq_created_by = "setq_created_by"
//        case setq_description = "setq_description"
//        case setq_image = "setq_image"
//        case setq_title = "setq_title"
//        case setq_visibility = "setq_visibility"
//    }
//    
//    public static func parseJson(json:JSON) -> Player_Model {
//        let model = Player_Model()
//        model._id = json[Key._id.rawValue].stringValue
//        model.setq_created_by = json[Key.setq_created_by.rawValue].stringValue
//        model.setq_description = json[Key.setq_description.rawValue].stringValue
//        model.setq_image = json[Key.setq_image.rawValue].stringValue
//        model.setq_title = json[Key.setq_title.rawValue].stringValue
//        model.setq_visibility = json[Key.setq_visibility.rawValue].stringValue
//        return model
//    }
//}

import Foundation

struct SetQ_Model:Decodable{
    var kq:Int
    var SetQ_Model:[SetQ]
}

struct SetQ:Decodable{
    var _id: String
    var setq_created_by:String
    var setq_description:String
    var setq_image:String
    var setq_title:String
    var setq_visibility:String
    
    init(_id:String, setq_created_by:String, setq_description:String, setq_image:String, setq_title:String, setq_visibility:String) {
        self._id = _id
        self.setq_created_by = setq_created_by
        self.setq_description = setq_description
        self.setq_image = setq_image
        self.setq_title = setq_title
        self.setq_visibility = setq_visibility
    }
}
